<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home Page</title>
<link rel="stylesheet" href="css/Homepage.css">
<link rel="stylesheet" href="css/style.css">

</head>
<body>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>

<% 
HttpSession httpSession = request.getSession();
String guid=(String)httpSession.getAttribute("currentuser");

	int flag=0;
ResultSet rs=null;
PreparedStatement ps=null;
java.sql.Connection conn=null;
String query="select p.pid,i.quantity,p.pname,p.manufacturer,p.mfg,p.exp,p.price from product p,inventory i where p.pid=i.pid and i.sid=?";
try{
	Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","fast1234");
	ps=conn.prepareStatement(query);
	ps.setString(1,guid);
	rs=ps.executeQuery();
}

catch(Exception E)
{
	out.println(E);
}
finally {
	  	try { if (rs != null) rs.close(); } catch (Exception e) {};
	  	try { if (ps != null) ps.close(); } catch (Exception e) {};
		try { if (conn != null) conn.close(); } catch (Exception e) {};
}
%>


<div class="main">
	<div class="topbar1"></div>
	<div class="topbar2">
		<div class="container1">
			<div class="logout-btn">
				<a href="Logout.jsp">Logout</a>
			</div>
		</div>
	</div>
	</div>
	<div class="topnav">
		<a href="Homepage.jsp" style="font-weight: bold; font-style: italic;">DVALO</a>
	
		<a href="Homepage.jsp">HOME</a>
				<a href="Buy.jsp">BUY</a>
				<a href="Orders.jsp">ORDERS</a>
		  <div class="search-container">
    <form action="usersearching.jsp">
      <input type="text" placeholder="Search.." name="medname">
      <button type="submit">SUBMIT</button>
    </form>
  </div>
</div>

<div class="filler2"></div>

			<div class="card" style="margin-top: 40px;">
  				<img src="images/notfound.jpg" class="Avatar" width=300 height=234 style="padding:30px" >
  				<div class="container">
    			 <div class="space1"><b><h3>Opps Sorry!</h3></b></div>
    			 <div class="filler3"></div>
   					<div class="space"><b><h3>Medicine Not Found</h3></b></div>
   				</div>
			</div>
</body>
</html>
