<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<% 
String prod=(String) request.getParameter("pid");
HttpSession httpSession = request.getSession();
String guid=(String)httpSession.getAttribute("currentuser");

ResultSet rs=null;
Connection conn=null;
PreparedStatement ps1=null;
PreparedStatement ps2=null;

String query1="delete from inventory where  pid=?";
String query2="delete from product where   pid=?";

try{
	Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","fast1234");
	ps1=conn.prepareStatement(query1);
	ps2=conn.prepareStatement(query2);
	
	ps1.setString(1,prod);
	int i=ps1.executeUpdate();
	ps2.setString(1,prod);
	
	
	int j=ps2.executeUpdate();
	
	response.sendRedirect("AddInventory.jsp");
}
catch(Exception e)
{
	out.println(e);
}
finally {
	try { if (rs != null) rs.close(); } catch (Exception e) {};
	try { if (ps1 != null) ps1.close(); } catch (Exception e) {};
	try { if (ps2 != null) ps2.close(); } catch (Exception e) {};
	try { if (conn != null) conn.close(); } catch (Exception e) {};
}

%>

</body>
</html>