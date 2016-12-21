<%@page import="com.amzi.dao.AccountDao"%>
<%@page import="com.objects.Models.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ResourceBundle"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ include file="auth.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!-- Bootstrap core CSS -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="myStyle.css" type="text/css" rel="stylesheet">

<%
	//this will be used in SetLangToEN and SetLangToFR.jsp.
	session.setAttribute("currentPage", "controlPanel");
	if (session.getAttribute("language") == null) {
		session.setAttribute("language", "EN");
	}
	//set the english as deafult
	ResourceBundle lang = ResourceBundle.getBundle("CP_EN");
	//if the session language is FR switch to french, otherwise remains english as set above
	if (session.getAttribute("language").toString().equals("FR")) {
		lang = ResourceBundle.getBundle("CP_FR");
	}
	//if the user clicked change language, set to appropriate language
	if (request.getParameter("language") != null) {
		if (request.getParameter("language").equals("FR")) {
			lang = ResourceBundle.getBundle("CP_FR");
			session.setAttribute("language", "FR");
		} else {
			lang = ResourceBundle.getBundle("CP_EN");
			session.setAttribute("language", "EN");
		}
	}
%>

<title><%=lang.getString("CPTitle")%></title>
</head>
<body>
	<%@ include file="auth_navbar.jsp"%>

	<div class="container-fluid">
		<!-- Main component for a primary marketing message or call to action -->
		<div id="top" class="jumbotron">
			<h1 class="text-center">Mind Soup</h1>
			<br></br>
			<h3 class="text-center"><%=lang.getString("CPTitle")%></h3>
		</div>
	</div>
	<!-- /container -->

	<div class="container-fluid content-main">
		<div class="jumbotron container-fluid">

		<h3><%=lang.getString("ListTitle")%></h3>

			<%
				ArrayList<User> userList = AccountDao.getAllUsers();
				if (userList != null) {
					
					
			%>
			
			<script>
			function NotmakeAdmin() {
				alert("You disabled this person from being admin.");
			}
			
			function makeAdmin(){
				window.alert("You enabled this person to become admin.");
			}
			
			function enablePerson(){
				alert("You enabled this person.");
			}
			
			function disablePerson(){
				alert("You disabled this person.");
			}
			
			function deleteuser(){
				window.alert("You deleted this person");
			}
			</script>
			
			
			<% 
				String enable = "enable";
				String disable = "disable";
			%>

			<table class="table table-hover table-responsive">
				<tr>
					<th><%=lang.getString("THUserName")%></th>
					<th><%=lang.getString("THAdministrator")%></th>
					<th><%=lang.getString("THStatus")%></th>
				</tr>

				<%
					for (User u : userList) {
				%>


				<tr align="left">
					<td style="vertical-align: middle;"><a
						href="bloggerProfile.jsp?userName=<%=u.getUserName()%>"> <%=u.getUserName()%></a>
						<%=u.getFirstName() + " " + u.getLastName()%></td>

					<!-- Make This person Admin or not Admin -->
					<td style="vertical-align: middle;">
						<%
							if (!u.isAdmin()) {
						%>
						<form
							action="makeItAdmin.jsp?id=<%=u.getId()%>&adminRole=<%=enable%>"
							method="post">
							<%="<button type=\"submit\" class=\"btn btn-success\" value=\"enable\" id=\"admin_enable\" onclick=\"makeAdmin()\" >"
										+ lang.getString("Btn-Enable") + "</button>"%>
						</form>
						 <%} else {%>
						<form
							action="makeItAdmin.jsp?id=<%=u.getId()%>&adminRole=<%=disable%>"
							method="post">
							<%="<button type=\"submit\" class=\"btn btn-warning\" value=\"disable\" id=\"admin_disable\" onclick=\"NotmakeAdmin()\" >"
										+ lang.getString("Btn-Disable") + "</button>"%>
						</form> 
						<% } %>
					</td>


					<td style="vertical-align: middle;">
						<%
							if (u.isDeleted()) {
						%>
						<form
							action="disable&EnableUser.jsp?id=<%=u.getId()%>&adminRole=<%=enable%>"
							method="post">
							<%="<button type=\"submit\" class=\"btn btn-success\" value=\"enable\" id=\"delete_enable\" onclick=\"enablePerson()\" >"
										+ lang.getString("Btn-Enable") + "</button>"%>
						</form> 
						<% } else {  %>
						<form
							action="disable&EnableUser.jsp?id=<%=u.getId()%>&adminRole=<%=disable%>"
							method="post">

							<%="<button type=\"submit\" class=\"btn btn-warning\" value=\"disable\" id=\"delete_disable\"  onclick=\"disablePerson()\" >"
										+ lang.getString("Btn-Disable") + "</button>"%>

						</form> 
						<% }%>
					</td>
					<td> 
						<form action="deleteUser.jsp?id=<%=u.getId()%>" method="post">

							<button type="submit" id="delete" class="btn btn-danger"
								value="erase"  onclick="deleteuser()" ><%=lang.getString("Btn-DeleteForever")%></button>
							<!-- Delete Button - will delete for ever. -->

						</form>

					</td>

				</tr>

				<%
					} //END FOR LOOP
				%>

			</table>

			<%
				} else {
			%>

			<p class="list-group-item">Whoops. <br/><%=lang.getString("error")%></p>
			<% } // END OF IF/ELSE %>
		</div>
	</div>
<%@ include file="footer.jsp"%>
</body>
</html>