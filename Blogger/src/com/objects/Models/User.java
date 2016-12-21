package com.objects.Models;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class User {

	private int id;
	private String firstName;
	private String lastName;
	private String userName;
	private String password;
	private Date createdDate;
	private Date dob ;
	private String email;
	private boolean emailVisible;
	private boolean admin;
	private boolean deleted;

	public User(String userName, String pass, String email){
		this.userName = userName;
		this.password =pass;
		this.email = email;
	}



	public User(String firstName, String lastName, String userName, String password, Date createdDate, Date dob,
			String email, boolean emailVisible, boolean admin, boolean deleted) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.userName = userName;
		this.password = password;
		this.createdDate = createdDate;
		this.dob = dob;
		this.email = email;
		this.emailVisible = emailVisible;
		this.admin = admin;
		this.deleted = deleted;
	}


	public User(ResultSet rs) throws SQLException{
		proccessRow(rs);
	}

	private void proccessRow(ResultSet rs) throws SQLException {

		id = rs.getInt("id");
		firstName = rs.getString("firstName");
		lastName = rs.getString("lastName");
		userName = rs.getString("username");
		password = rs.getString("password");
		createdDate = rs.getDate("createdDate");
		dob = rs.getDate("dob");
		email = rs.getString("email");
		emailVisible = rs.getBoolean("emailVisible");
		admin = rs.getBoolean("accountType");
		deleted = rs.getBoolean("deleted");

	}

	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getFirstName() {
		return firstName;
	}


	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}


	public String getLastName() {
		return lastName;
	}


	public void setLastName(String lastName) {
		this.lastName = lastName;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public Date getCreatedDate() {
		return createdDate;
	}


	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}


	public Date getDob() {
		return dob;
	}


	public void setDob(Date dob) {
		this.dob = dob;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getUserName() {
		return userName;
	}



	public void setUserName(String userName) {
		this.userName = userName;
	}



	public boolean isEmailVisible() {
		return emailVisible;
	}



	public void setEmailVisible(boolean emailVisible) {
		this.emailVisible = emailVisible;
	}



	public boolean isAdmin() {
		return admin;
	}



	public void setAdmin(boolean admin) {
		this.admin = admin;
	}



	public boolean isDeleted() {
		return deleted;
	}



	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}



	public String toString(){
		StringBuilder builder =  new StringBuilder();

		builder.append("The id is ").append(id).append("\n")
		.append("The firstName is ").append(firstName).append("\n")
		.append("The lastName is ").append(lastName).append("\n")
		.append("The userName is ").append(userName).append("\n")
		.append("The password is ").append(password).append("\n")
		.append("The createdDate is ").append(createdDate.toString()).append("\n")
		.append("The dob is ").append(dob.toString()).append("\n")
		.append("The email").append(email);

		return builder.toString();

	}


}