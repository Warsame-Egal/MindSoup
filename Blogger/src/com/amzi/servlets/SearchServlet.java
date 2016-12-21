package com.amzi.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.amzi.dao.AccountDao;

public class SearchServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		String username = request.getParameter("username");

		try {
			if (AccountDao.getUserSearchResultSet(username) != null) {
				request.setAttribute("UserN", username); //set the attributes
				request.getRequestDispatcher("search.jsp").forward(request, response); //forwared the responce and attributes to search.jsp
			}
			else if (AccountDao.getUserSearchResultSet(username) == null) {
				request.setAttribute("UserN", "empty");
				request.getRequestDispatcher("search.jsp").forward(request, response);

			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		out.close();
	}
}