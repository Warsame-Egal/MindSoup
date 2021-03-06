package com.amzi.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseDao {

	private static String url = "jdbc:mysql://localhost:3306/";
	private static String dbName = "blog";
	private static String driver = "com.mysql.jdbc.Driver";
	private static String userName = "root";
	private static String password = "borama123";
	private static Connection conn = null;

	public DatabaseDao() {
		try {
			if (conn == null || conn.isValid(0)) {
				Class.forName(driver).newInstance();
				conn = DriverManager.getConnection(url + dbName, userName, password);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	public static boolean endConnection() {
		if (conn != null) {
			try {
				conn.close();
				return true;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return false;
	}

	public Connection getConnection() {
		return conn;
	}
}
