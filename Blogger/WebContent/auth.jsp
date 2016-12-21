<%@ page import="javax.servlet.*,javax.servlet.http.*"%>

<%
	if (request.getSession().getAttribute("username") == null)
		response.sendRedirect("./index.jsp");
%>
