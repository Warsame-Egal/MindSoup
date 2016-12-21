<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.objects.Models.Post, com.amzi.dao.PostDao, java.sql.ResultSet, java.text.SimpleDateFormat, java.util.ResourceBundle"%>

<%@ include file="auth.jsp"%>

<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!-- Bootstrap core CSS -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="myStyle.css" type="text/css" rel="stylesheet">

<%
	//this will be used in SetLangToEN and SetLangToFR.jsp.
	session.setAttribute("currentPage", "home");

	if (session.getAttribute("language") == null) {
		session.setAttribute("language", "EN");
	}

	//set the english as deafult
	ResourceBundle lang = ResourceBundle.getBundle("Home_EN");

	//if the session language is FR switch to french, otherwise remains english as set above
	if (session.getAttribute("language").toString().equals("FR")) {
		lang = ResourceBundle.getBundle("Home_FR");
	}

	//if the user clicked change language, set to appropriate language
	if (request.getParameter("language") != null) {
		if (request.getParameter("language").equals("FR")) {

			lang = ResourceBundle.getBundle("Home_FR");
			session.setAttribute("language", "FR");
		} else {
			lang = ResourceBundle.getBundle("Home_EN");
			session.setAttribute("language", "EN");
		}
	}
%>


<title>HomePage <%=session.getAttribute("username")%></title>
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

	<div class="container">
		<div class="row">


			<div>

				<!-- Blog Post Content Column -->
				<div class="col-lg-8">

					<%
						ResultSet rs = null;
						rs = PostDao.getPostResultSet();
						if (rs != null) {
							while (rs.next()) {
					%>
					<!-- Blog Post -->

					<!-- Title -->
					<h1><%=rs.getString(1)%></h1>

					<!-- Author -->
					<p class="lead">
						
						<%=lang.getString("postedBy")%>
						<% String fullName =  rs.getString(6)  + "  "+ rs.getString(7);%>
					 	<a href="bloggerProfile.jsp?userName=<%=rs.getString(4) %>"> <%=fullName%> </a>   

					</p>

					<hr>

					<!-- Date/Time/category -->
					<p>
						<span class="glyphicon glyphicon-time"></span>
						<%=lang.getString("postedOn")%>
						<%=rs.getDate(5)%>.
						<%=lang.getString("in")%>
						<%=rs.getString(2)%>
						<%=lang.getString("category")%></p>

					<hr>


					<!-- Post Content -->
					<p class="lead">
						<%=rs.getString(3)%>
						<!-- May need to translate this one too -->
					</p>

					<hr>

					<%
						}
						} else {
					%>
					<p class="list-group-item"><%=lang.getString("error")%></p> 
					<%
						}
					%>

				</div>
			</div>
		</div>
	</div>

	<div class="panel-footer">
		<div id="bottom" class="jumbotron text-center">
			<h5>mindsoup@gmail.com</h5>
			<br />
			<h5>Copyright MindSoup.com</h5>
		</div>
	</div>
</body>
</html>
