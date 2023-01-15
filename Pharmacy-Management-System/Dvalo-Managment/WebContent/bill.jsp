<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Orders</title>
<link rel="stylesheet" href="css/Homepage.css">
<link rel="stylesheet" href="css/Buy.css">

<link rel="stylesheet" href="css/style.css">

</head>
<body>
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
	<div class="active">
	<%@ page import="java.sql.*" %>
	<%@ page import="javax.sql.*" %>
	<%
	HttpSession httpSession = request.getSession();
    String gid=(String)httpSession.getAttribute("currentuser");
    %>
    
    <div class="filler"></div>
    
    <%
    int flag=0;
    Connection conn=null;
    ResultSet rs=null;
    PreparedStatement ps=null;
	try{
			String q1= "select * from drugdatabase.orders where uid = ? order by oid desc limit 1";
		Class.forName("com.mysql.jdbc.Driver");
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","fast1234");
		ps=conn.prepareStatement(q1);
		ps.setString(1,gid);
		rs=ps.executeQuery();
		%>
		<%while(rs.next()) 
		{ %>
	<h2> Thanks for buying </h2>
				<div class ="print-container">
			
			<div class="card">
			
  				<img src="images/bill.png" class="Avatar" width=234 height=234>
  				<div class="container">
    			 <div class="space1"><b><%=rs.getString("uid") %></b></div>
    			 <div class="filler3"></div>
    				<div class="space"><b>PRODUCT-ID: </b><%=rs.getInt("pid") %></div>
   				 
   					<div class="space"><b>PRICE: </b><%=rs.getInt("price") %></div>
   					<div class="space"><b>QUANTITY: </b><%=rs.getInt("quantity") %></div>
   					<div class="space"><b>ORDER DATE/TIME: </b><%=rs.getTimestamp("orderdatetime") %></div>
                     </div>
  				
  				<form action="Orders.jsp" method="post">
  					<p></p>
  					<button onclick="window.print()">PRINT</button>
  					</form>
  	</div>
			</div>
	  		
  <% 		
	}
		%>
		
		
		</div>			
		<% 
		}
	catch(Exception e)
	{
		out.println("error: "+e);
	}
		finally {
		    try { if (rs != null) rs.close(); } catch (Exception e) {};
		    try { if (ps != null) ps.close(); } catch (Exception e) {};
		    try { if (conn != null) conn.close(); } catch (Exception e) {};
	}
	%>
</body>
</html>