<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>searching</title>
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
	<a href="SellerHomepage.jsp" style="font-weight: bold; font-style: italic;">DVALO</a>
	
		<a href="SellerHomepage.jsp">HOME</a>
				<a href="AddProduct.html">ADD</a>
				<a href="AddInventory.jsp">RESTOCK</a>
				<a href="SellerOrders.jsp">ORDERS</a>
					  <div class="search-container">
    <form action="sellersearching.jsp">
      <input type="text" placeholder="Search.." name="medname">
      <button type="submit">SUBMIT</button>
    </form>
  </div>
</div>


<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%! String name;
%>
<%
String name= (String) request.getParameter("medname");


	
		HttpSession httpSession = request.getSession();
    	String guid=(String)httpSession.getAttribute("currentuser");
    	
    %>
    <div class="filler"></div>
    <%
   		int flag=0;
		ResultSet rs=null;
		PreparedStatement ps=null;
		java.sql.Connection conn=null;
		String query2="select p.pname from product p where p.pname=?";
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","fast1234");
			ps=conn.prepareStatement(query2);
			
			ps.setString(1,name);
		 	rs=ps.executeQuery();
		   	if(!rs.next())
		   	{
		   response.sendRedirect("mednotfoundsel.jsp");
		   	}
		   		   			
		   		
		   	
		
		}
		catch(Exception e)
		{
			out.println("error: "+e);
		}

		String query="select p.pid,i.quantity,p.pname,p.manufacturer,p.mfg,p.exp,p.price from product p,inventory i where p.pname=? and i.sid=? and p.pid=i.pid";
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","fast1234");
			ps=conn.prepareStatement(query);
			ps.setString(1,name);
			ps.setString(2,guid);
			
			
			rs=ps.executeQuery();
	
	%>
	<div class="filler2"></div>
		<div class="block">
	<%
			while(rs.next())
			{
				if(flag==4)
				{
					flag=1;
					%>
					</div>
					<div class="filler2"></div>
					<% 
				}
				else
					flag++;
			%>
			<div class="row">
 				<div class="column">
    				<div class="card">
    					<form action="UpdateInventory.jsp" method="post">
    						<img src="images/pills.png" width=180 height=200>
  							<h1><%=rs.getString("pname") %></h1>
  							<p><b>ID: </b><%=rs.getString("pid") %></p>
							<p><b>Manufacturer: </b><%=rs.getString("manufacturer") %></p>
							<p><b>Mfg Date: </b><%=rs.getDate("mfg") %></p>
							<p><b>Exp Date: </b><%=rs.getDate("exp") %></p>
							<p><b>Stock: </b><%=rs.getInt("quantity") %></p>
							<p><b>Price: </b><%=rs.getInt("price") %></p>
							<p><input type="text" name="restock" placeholder="quantity" onkeypress="return event.charCode>= 48 && event.charCode<= 57" required></p>
							<input type="hidden" name="pid" value="<%=rs.getString("pid") %>" >
 							<p></p>
 	 							
  							<button>ReStock</button>
  							
  						</form>
  							
  						<form action="deleteproduct.jsp" method="post">
  						<input type="hidden" name="pid" value="<%=rs.getString("pid") %>" >
 							<p></p>
  							<button>Delete</button>
  						
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