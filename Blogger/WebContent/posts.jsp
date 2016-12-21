<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ResourceBundle"%>

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
	session.setAttribute("currentPage", "posts");

	if (session.getAttribute("language") == null) {
		session.setAttribute("language", "EN");
	}

	//set the english as deafult
	ResourceBundle lang = ResourceBundle.getBundle("Post_EN");

	//if the session language is FR switch to french, otherwise remains english as set above
	if (session.getAttribute("language").toString().equals("FR")) {
		lang = ResourceBundle.getBundle("Post_FR");
	}

	//if the user clicked change language, set to appropriate language
	if (request.getParameter("language") != null) {
		if (request.getParameter("language").equals("FR")) {

			lang = ResourceBundle.getBundle("Post_FR");
			session.setAttribute("language", "FR");
		} else {
			lang = ResourceBundle.getBundle("Post_EN");
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

	<div id="middlePost" class="container-fluid">
		<!-- Main component for a primary marketing message or call to action -->
		<div id="middle" class="jumbotron">
			<form method="post" action="post">
				<div class="row postContent">

					<div class="col-md-6">
						<h4>
							<%=lang.getString("title")%>:<input type="text" name="title"
								required="required" />
						</h4>
					</div>
					<div class="col-md-6">
						<h4>
							<%=lang.getString("subject")%>
							<select name="subject" required="required">
								<option value=""></option>
								<option value="entertainment"><%=lang.getString("entertainment")%>
								</option>
								<option value="technology"><%=lang.getString("technology")%></option>
								<option value="personal"><%=lang.getString("personal")%></option>
								<option value="science"><%=lang.getString("science")%></option>
							</select>
						</h4>
					</div>
				</div>



				<div class="row postContent">
					<p>
						<textarea name="textArea" rows="9" cols="70"
							placeholder=<%=lang.getString("text")%>></textarea>
					</p>
					<input type="submit" value=<%=lang.getString("submit")%> />
				</div>

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
