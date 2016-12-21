<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--   include file="languageSet.jsp"%-->
<%@ include file="auth.jsp"%>
<%@ page
	import="com.objects.Models.User, com.amzi.dao.AccountDao, java.util.Date, java.util.ResourceBundle, java.util.Locale"%>

<html>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Thee above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!-- Bootstrap core CSS -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="myStyle.css" type="text/css" rel="stylesheet">


<%
	session.setAttribute("currentPage", "user");
	if (session.getAttribute("language") == null) {
		session.setAttribute("language", "EN");
	}
	//set the english as deafult
	ResourceBundle lang = ResourceBundle.getBundle("UserProfile_EN");
	//if the session language is FR switch to french, otherwise remains english as set above
	if (session.getAttribute("language").toString().equals("FR")) {
		lang = ResourceBundle.getBundle("UserProfile_FR");
	}
	//if the user clicked change language, set to appropriate language
	if (request.getParameter("language") != null) {
		if (request.getParameter("language").equals("FR")) {
			lang = ResourceBundle.getBundle("UserProfile_FR");
			session.setAttribute("language", "FR");
		} else {
			lang = ResourceBundle.getBundle("UserProfile_EN");
			session.setAttribute("language", "EN");
		}
	}
%>




<title>Profile</title>
</head>
<body>
	<%@ include file="auth_navbar.jsp"%>

	<div class="container-fluid">
		<!-- Main component for a primary marketing message or call to action -->
		<div id="top" class="jumbotron">
			<h1 class="text-center"><%=lang.getString("projectName")%></h1>
			<br></br>
			<h3 class="text-center"><%=lang.getString("desc")%></h3>
		</div>
	</div>
	<!-- /container -->

	<div class="container-fluid">
		<div id="middle" class="jumbotron text-center">
			<%
				String username = (String) session.getAttribute("username");
			%>

			<h2>
				<%=lang.getString("username") %> :
				<%=username%></h2>


			<%
				int userid = AccountDao.getUserId(username); //works
				//returns a user
				User user = AccountDao.getUserDetails(userid); 
				//get all the details for that specific user
				String userNAme = user.getUserName();
				String firstName = user.getFirstName();
				String lastName = user.getLastName();
				String email = user.getEmail();
				String password = user.getPassword(); 
				Date dob = user.getDob();
				Date createdDate = user.getCreatedDate();
			%>




			<form>
				<table>
					<tr>
						<td><label> <%=lang.getString("firstname")%>:
						</label></td>
						<td><%=firstName%></td>
					</tr>
					<tr>
						<td><label><%=lang.getString("lastname")%>:</label></td>
						<td><%=lastName%></td>
					</tr>
					<tr>
						<td><label><%=lang.getString("username")%>:</label></td>
						<td><%=username%></td>
					</tr>
					<tr>
						<td><label><%=lang.getString("email")%>:</label></td>
						<td><%=email%></td>
					</tr>
					<tr>
						<td><label><%=lang.getString("pass")%>:</label></td>
						<td>----------</td>
					</tr>
					<tr>
						<td><label><%=lang.getString("dob")%>:</label></td>
						<td><%=dob%></td>
					</tr>
					<tr>
						<td><label><%=lang.getString("createdDate")%>:</label></td>
						<td><%=createdDate%></td>
					</tr>

				</table>


			</form>



		</div>
	</div>

	<div class="panel-footer">
		<div id="bottom" class="jumbotron text-center">
			<h5>mindsoup@gmail.com</h5>
			<br />
			<h5>Copyright weTheFamily.com</h5>
		</div>
	</div>


</body>
</html>