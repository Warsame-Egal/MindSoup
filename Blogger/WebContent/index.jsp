<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	if (request.getSession().getAttribute("username") != null)
		response.sendRedirect("./home.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Login Application</title>
<link href="myStyle.css" type="text/css" rel="stylesheet">


</head>
<body class="image">
	<div id="image">
		<div id="header">
			<h1>Log Into Mindsoup Blog</h1>
			<br />
		</div>
		<form action="login" method="post">
			<div class="Signin">
				<fieldset style="width: 300px">
					<legend>Sign In </legend>
					<table>
						<tr>
							<td>User ID</td>
							<td><input type="text" name="username" required="required" /></td>
						</tr>
						<tr>
							<td>Password</td>
							<td><input type="password" name="userpass"
								required="required" /></td>
						</tr>
						<tr>
							<td><input type="submit" value="login" /></td>
						</tr>
					</table>
				</fieldset>
			</div>
		</form>


		<form action="signUp" method="post">
			<div class="SignUp">
				<fieldset style="width: 300px">
					<legend>Sign Up </legend>
					<table>
						<tr>
							<td>First Name</td>
							<td><input type="text" name="firstName" required="required" /></td>
						</tr>
						<tr>
							<td>Last Name</td>
							<td><input type="text" name="lastName" required="required" /></td>
						</tr>
						<tr>
							<td>Email</td>
							<td><input type="text" name="email" required="required" /></td>
						</tr>
						<tr>
							<td>User Name</td>
							<td><input type="text" name="userName" required="required" /></td>
						</tr>
						<tr>
							<td>Password</td>
							<td><input type="password" name="password"
								required="required" /></td>
						</tr>
						<tr>
							<td><input type="submit" value="Create Account"
								class="click button" /></td>
						</tr>
					</table>
				</fieldset>
			</div>
		</form>
	</div>
</body>
</html>