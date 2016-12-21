package com.amzi.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.amzi.dao.AccountDao;

public class DeleteUserServlet extends HttpServlet {

		private static final long serialVersionUID = 1L;

		public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

			response.setContentType("text/html");
			PrintWriter out = response.getWriter();

			String username = (String) request.getSession().getAttribute("username");

			AccountDao.getUserId(username);
			response.sendRedirect("controlPanel.jsp");

			out.close();
		}

	}

