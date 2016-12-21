<%@ page
import="com.amzi.dao.AccountDao, com.objects.Models.User"%>

<!-- Bootstrap core CSS -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="myStyle.css" type="text/css" rel="stylesheet">


<%
	String userName = (String) session.getAttribute("username");
	int id = AccountDao.getUserId(userName); 
	User loggedinUser = AccountDao.getUserDetails(id);
%>

<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar" aria-expanded="false"
				aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="home.jsp">Home</a>

		</div>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
				<li><a href="user.jsp">Profile</a></li>
				<li><a href="posts.jsp">Posts</a></li>

				<% if(loggedinUser.isAdmin()){ %>
				<li><a href="controlPanel.jsp">Control Panel</a></li>
				<% } %>
				<!--  -->

				<!-- <li><a href="search.jsp">Search</a></li>   -->
				<li><a href="logout">Logout</a></li>

			</ul>			
			<form class="nav navbar-form pull-right" role="search" action="search" method="post">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="Search" name="username" >
					<div class="input-group-btn">
						<input class="btn btn-default" type="submit" value="submit">
						<i class="glyphicon glyphicon-search"></i>
					</div>
				</div>
			</form>
			<ul class="nav navbar-nav navbar-right">
				<li><a  href="setLangToEN.jsp">EN</a></li>
				<li><a  href="setLangToFR.jsp">FR</a></li>

			</ul>
		</div>
		<!--/.nav-collapse -->
	</div>
</nav>