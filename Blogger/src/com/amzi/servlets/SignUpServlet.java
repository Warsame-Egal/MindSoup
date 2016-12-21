package com.amzi.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.amzi.dao.AccountDao;

/**
 * Servlet implementation class SignUpServlet
 */
public class SignUpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		// get all the info from the user
		String fN = request.getParameter("firstName");
		String lN = request.getParameter("lastName");
		String email = request.getParameter("email");
		String userName = request.getParameter("userName");
		String password = request.getParameter("password");

		java.util.Date dob = new java.util.Date(); // Will change once date
		// picker is implemented
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String currentTime = sdf.format(dob);
		// Can move the above code into the sign-up method itself if necessary

		HttpSession session = request.getSession(false);
		if (session != null) {
			if (AccountDao.signUp(fN, lN, email, userName, password, currentTime)) {
				session.setAttribute("username", userName);
				RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
				rd.forward(request, response);
			} else {
				out.print("<p style=\"color:red\">Sorry couldn't create an account. Username and/or email already in use</p>");
				RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
				rd.include(request, response);
			}
		}
		out.close();

	}
}
