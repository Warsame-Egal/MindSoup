package com.amzi.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.amzi.dao.AccountDao;

public class SearchTitleServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		String postTitle = request.getParameter("postTitle");

		try {
			if (AccountDao.getUserSearchResultSet(postTitle) != null) {
				request.setAttribute("postTitle", postTitle); //set the attributes
				request.getRequestDispatcher("user.jsp").forward(request, response); //forwared the responce and attributes to search.jsp
			}
			else if (AccountDao.getUserSearchResultSet(postTitle) == null) {
				request.getRequestDispatcher("home.jsp").forward(request, response);

}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		out.close();
	}
}
