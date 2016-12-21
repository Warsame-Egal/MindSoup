<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ResourceBundle"%>

<%@ include file="auth.jsp"%>
<%@ page
	import="com.objects.Models.Post, com.amzi.dao.AccountDao, java.sql.ResultSet, java.text.SimpleDateFormat, java.util.ResourceBundle"%>
<%@page import="com.amzi.dao.AccountDao"%>
<%@page import="com.objects.Models.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ResourceBundle"%>

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
	session.setAttribute("currentPage", "search");
	
	if (session.getAttribute("language") == null) {
		session.setAttribute("language", "EN");
	}

	//set the english as deafult
	ResourceBundle lang = ResourceBundle.getBundle("SearchEgine_EN");

	//if the session language is FR switch to french, otherwise remains english as set above
	if (session.getAttribute("language").toString().equals("FR")) {
		lang = ResourceBundle.getBundle("SearchEgine_FR");
	}

	//if the user clicked change language, set to appropriate language
	if (request.getParameter("language") != null) {
		if (request.getParameter("language").equals("FR")) {

			lang = ResourceBundle.getBundle("SearchEgine_FR");
			session.setAttribute("language", "FR");
		} else {
			lang = ResourceBundle.getBundle("SearchEgine_EN");
			session.setAttribute("language", "EN");
		}
	}
%>


<title>Search</title>
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
		<h3>
		<% if(request.getAttribute("UserN").equals("empty")/* && request.getAttribute("title").equals("empty")*/){ %>
			<%=lang.getString("notFound")%>
		<%}else { %>
			<%=lang.getString("result")%><br/><br/>
				
				<%if(!request.getAttribute("UserN").equals("empty")){ %>
					<!-- Print just the account. -->
					<%=lang.getString("foundAccount")%> 
					<a href="user.jsp"><%=request.getAttribute("UserN")%></a>
				
				<% } else if(!request.getAttribute("title").equals("empty")){ %>
					<!-- Print just the title. -->	
					<%=lang.getString("foundTitle")%> 
					<a href="user.jsp"><%=request.getAttribute("postTitle")%></a> 
		<%  }
				}%>
		</h3>
		
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