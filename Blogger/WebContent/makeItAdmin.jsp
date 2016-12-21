<%@ page
	import="com.amzi.dao.AccountDao"%>
<%
				
//get the id and adminRole that passed as a parameter this to jsp file.
String id = request.getParameter("id");
String adminRole = request.getParameter("adminRole");

int  accountID = Integer.parseInt(id);

/*
* Role - Pass 1 for admin or 0 for user
*/
if(adminRole.equals("enable")){
	
	if(AccountDao.updateAdmin(1, accountID)){
	}else {
		out.print("<p style=\"color:red\">Erro occured while updating</p>");
	}
		
		
}else if(adminRole.equals("disable")){
	if(AccountDao.updateAdmin(0, accountID)){
 	}else {
		out.print("<p style=\"color:red\">Erro occured while updating</p>");
	}	
}


//redirect back to the controlPanel
response.sendRedirect("controlPanel.jsp");
			
%>