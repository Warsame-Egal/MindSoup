package com.amzi.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import com.objects.Models.User;

public class AccountDao {

	private static boolean status = false;
	private static DatabaseDao db;
	private static Connection conn = null;

	public static boolean signUp(String fName, String lName, String email, String username, String password,
			String currentTime) {
		db = new DatabaseDao();
		conn = db.getConnection();
		PreparedStatement pst = null;
		int rowCount = 0;
		String accountType = "0"; // Account Type is 0 = User, 1 = Administrator

		// TODO In the future, get Date of birth and (Male or Female). but we'll do this later
		// TODO encrypt password before storing

		try {
			// This checks if the client is attempting to sign up with a
			// username or email already in use
			PreparedStatement usrCheck = conn.prepareStatement("SELECT id FROM account WHERE username=? OR email=?");
			usrCheck.setString(1, username);
			usrCheck.setString(2, email);

			/*If insert is skipped, the  row count is 0 and function returns false*/
			if (!usrCheck.executeQuery().next()) 
			{
				pst = conn.prepareStatement(
						"INSERT INTO account (firstName, lastName, email, username, password, accountType, createdDate, dob)"
								+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
				pst.setString(1, fName);
				pst.setString(2, lName);
				pst.setString(3, email);
				pst.setString(4, username);
				pst.setString(5, password);
				pst.setString(6, accountType);
				pst.setString(7, currentTime);
				pst.setString(8, "1970-01-01"); //TODO dirty workaround until date
				// picker is implemented

				rowCount = pst.executeUpdate();
			}

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			if (pst != null) {
				try {
					pst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		if (rowCount > 0)
			return true;
		return false;
	}

	public static boolean validate(String username, String password) {
		db = new DatabaseDao();
		PreparedStatement pst = null;
		ResultSet rs = null;
		try {
			conn = db.getConnection();

			// TODO encrypt password before query

			pst = conn.prepareStatement("SELECT * FROM account WHERE username=? AND password=? AND deleted=0");
			pst.setString(1, username);
			pst.setString(2, password);

			rs = pst.executeQuery();
			status = rs.next();

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			if (pst != null) {
				try {
					pst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return status;
	}

	public static User getUserDetails(int accountId) {
		db = new DatabaseDao();
		PreparedStatement statement = null;
		ResultSet rs = null;

		try {
			conn = db.getConnection();

			String query = "select *";
			query += "from account where id = ?";

			statement = conn.prepareStatement(query);

			statement.setInt(1, accountId);
			rs = statement.executeQuery();
			rs.first();

			return new User(rs);

		} catch (Exception ex) {
			System.out.println("problem with the sQL" + ex);

		} finally {

			if (statement != null) {
				try {
					statement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return null;

	}

	public static int getUserId(String username) {
		db = new DatabaseDao();
		PreparedStatement pst = null;
		ResultSet rs = null;
		try {
			conn = db.getConnection();
			
			pst = conn.prepareStatement("SELECT id FROM account WHERE username=? ");
			pst.setString(1, username);

			rs = pst.executeQuery();
			rs.first();
			return rs.getInt(1);

		} catch (Exception ex) {
			System.out.println("Error accurred while getting the user id " + ex);
		} finally {
			if (pst != null) {
				try {
					pst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return 0;
	}

	/* fetches all the users in the database. */
	public static ArrayList<User> getAllUsers() {
		db = new DatabaseDao();
		ResultSet rs = null;
		PreparedStatement pst = null;
		
		ArrayList<User> users = new ArrayList<User>();

		String query = "select * from account";

		try {
			conn = db.getConnection();
			pst = conn.prepareStatement(query);
			rs = pst.executeQuery();
			if (rs.first()) {
				do {
					User u = new User(rs);
					users.add(u);
				}
				while (rs.next());
				return users;
			}
		} catch (Exception e) {
			System.out.println("Error occured while fetching list:" + e);
		}
		return null;

	}
	/**
	 *
	 * @param accountId
	 * @return true if it successful or false if not successful.
	 */
	public static boolean deleteUser(int accountId) {
		db = new DatabaseDao();
		PreparedStatement statement = null;
		int rowCount = 0;

		try {
			conn = db.getConnection();

			String query = "delete from account where id = ?"; 
			statement = conn.prepareStatement(query);

			
			statement.setInt(1, accountId);
			
			rowCount = statement.executeUpdate();
		

		} catch (Exception ex) {
			System.out.println("problem with the sQL" + ex);

		} finally {

			if (statement != null) {
				try {
					statement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		if (rowCount > 0)
			return true;
		return false;

	}
	
	/**
	 *
	 * @param role - role could be either 1 for admin or 0 for user
	 * @param accountID - takes accont id of the user 
	 */
	public static boolean updateAdmin(int role, int accountID){
		db = new DatabaseDao();
		PreparedStatement pst = null;
		int rowCount = 0;
		try {
			conn = db.getConnection();

			pst = conn.prepareStatement("update account set accountType=? where id=? ");
			 pst.setInt(1,  role);
			 pst.setInt(2,  accountID);

			 rowCount = pst.executeUpdate();
			
			

		} catch (Exception ex) {
			System.out.println("Error accurred while updating it " + ex);
		} finally {
			if (pst != null) {
				try {
					pst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		if (rowCount > 0)
			return true;
		return false;

	}

	
	/**
	 *
	 * @param role - role could be either 1 for deleted user or 0 for exiting user
	 * @param accountID - takes accont id of the user 
	 */
	public static boolean changeStatus(int role, int accountID){
		db = new DatabaseDao();
		PreparedStatement pst = null;
		int rowCount = 0;
		try {
			conn = db.getConnection();

			pst = conn.prepareStatement("update account set deleted=? where id=? ");
			pst.setInt(1,  role);
			pst.setInt(2,  accountID);

			 rowCount = pst.executeUpdate();	

		} catch (Exception ex) {
			System.out.println("Error accurred while changing the status " + ex);
		} finally {
			if (pst != null) {
				try {
					pst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		if (rowCount > 0)
			return true;
		return false;

	}
	

	/*username search */
	public static ResultSet getUserSearchResultSet(String username) throws SQLException {
		db = new DatabaseDao();
		conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet resultSet = null;

		String sql = "SELECT username FROM account WHERE username='" + username + "'";
		try {
			ps = conn.prepareStatement(sql);
			resultSet = ps.executeQuery();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

		}
		if (resultSet.next()) {
		    if (resultSet.getString("username").equals(username)) //check the username column if the sting username exists in the row
			return resultSet;
		} else
			return null;
		
		return resultSet;
	}
	
	/*blog search */
	public static ResultSet getBlogSearchResultSet(String postTitle) throws SQLException {
		db = new DatabaseDao();
		conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet resultSet = null;

		String sql = "SELECT postTitle FROM post WHERE postTitle='" + postTitle + "'";
		try {
			ps = conn.prepareStatement(sql);
			resultSet = ps.executeQuery();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

		}
		if (resultSet.next()) {
		    if (resultSet.getString("postTitle").equals(postTitle)) 
			return resultSet;
		} else
			return null;
		
		return resultSet;
	}
}
	
	
