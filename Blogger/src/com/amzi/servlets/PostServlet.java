package com.amzi.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.amzi.dao.PostDao;

public class PostServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;


	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		String username = (String) request.getSession().getAttribute("username"); 

		String title = request.getParameter("title");
		String subject = request.getParameter("subject");
		String text = request.getParameter("textArea");

		java.util.Date dob = new java.util.Date(); 
		// picker is implemented
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String currentTime = sdf.format(dob);

		if (PostDao.submitPost(title, subject, text, currentTime, username)) {
			out.print("<p style=\"color:yellow\">You have succesfully posted... </p>");
			response.sendRedirect("home.jsp");
		}
		out.close();
	}

}