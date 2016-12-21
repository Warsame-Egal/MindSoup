<%@ page
	import="com.amzi.dao.AccountDao"%>
<%
				
//get the id number that was passed as a parameter this to jsp file.
String id = request.getParameter("id");

int  accountID = Integer.parseInt(id);

//delete the account with that id
if(AccountDao.deleteUser( accountID)){
	
}else{
	out.print("<p style=\"color:red\">Erro occured while deleting the user</p>");
}

//redirect back to the controlPanel
response.sendRedirect("controlPanel.jsp");
			
%>