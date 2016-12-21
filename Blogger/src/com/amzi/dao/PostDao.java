package com.amzi.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.objects.Models.*;

public class PostDao {

	private static DatabaseDao db;
	private static Connection conn = null;

	public static boolean submitPost(String title, String subject, String text, String currentTime, String username) {
		db = new DatabaseDao();
		conn = db.getConnection();
		PreparedStatement ps = null;
		int rowCount = 0;

		try {
			String sql = "INSERT INTO `blog`.`post`"
					+ "(postTitle, postSubject, postBody, postVisible, DateCreated, isMAture, deleted, accountID)"
					+ "VALUES(?, ?, ?, ?, NOW(), ?, ?, (SELECT id FROM `blog`.`account` WHERE username=?));";

			ps = conn.prepareStatement(sql);

			ps.setString(1, title);
			ps.setString(2, subject);
			ps.setString(3, text);
			ps.setString(4, "1");
			ps.setString(5, "0");
			ps.setString(6, "0");
			ps.setString(7, username);

			rowCount = ps.executeUpdate();

		} catch (Exception e) {
			System.out.println(e);
		} finally {

		}

		if (rowCount > 0)
			return true;
		return false;
	}

	public static Post getPost(int postID){
		Post post = null;

		db = new DatabaseDao();
		conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "SELECT postTitle, postSubject, postBody, DateCreated, username"+
				"FROM post"+
				"INNER JOIN account"+
				"ON account.id=accountID "+
				"WHERE post.id=?"+
				"AND postVisible = 1";
		sql+= ";";

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, postID);

			rs = ps.executeQuery();
			if (rs.getRow() != 0) {
				String title = rs.getString("postTitle");
				String subject = rs.getString("PostSubject");
				String body = rs.getString("postBody");
				String dateCreated = rs.getString("DateCreated");
				String authorUsername = rs.getString("username");

				post = new Post(title, subject, body, authorUsername, dateCreated);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

		}
		return post;
	}

	public static ResultSet getPostResultSet(){
		db = new DatabaseDao();
		conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet resultSet = null;

		String sql = "SELECT postTitle, postSubject, postBody, username, DateCreated, firstName, lastName FROM post "+
				"INNER JOIN account "+
				"ON account.id=post.accountID "+
				"AND DateCreated BETWEEN '1970-01-01 00:00:00' AND NOW()"+
				/* Other AND statements such as mature content flags, visibility, etc, can be set accordingly */
				"ORDER BY DateCreated desc;";
		try {
			ps = conn.prepareStatement(sql);
			resultSet = ps.executeQuery();


		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

		}		
		if (resultSet != null){
			return resultSet;
		} else return null;
	}
}
