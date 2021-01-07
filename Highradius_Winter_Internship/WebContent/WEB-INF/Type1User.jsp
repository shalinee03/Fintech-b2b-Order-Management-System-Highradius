<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*;" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Order Dashboard</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" >
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"  ></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"  ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" ></script>
</head>
<body>
<table class="table table-bordered">
<tr>
	<th>Order_ID</th>
	<th>Customer_Name</th>
	<th>Customer_ID</th>
	<th>Order_Amount</th>
	<th>Approval_Status</th>
	<th>Approved_By</th>
	<th>Notes</th>
	<th>Order_Date</th></tr>

	<%
	try
	{
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection conn=DriverManager.getConnection("jdbc:mysql:// localhost:3306/");
		String Query="Select * from  order_details ";
		Statement stm=conn.createStatement();
		ResultSet rs=stm.executeQuery(Query);
		while(rs.next())
		{
			%><tr>
			<td><%=rs.getInt("Order_ID") %></td>
			<td><%=rs.getString("Customer_Name") %></td>
			<td><%=rs.getInt("Customer_ID") %></td>
			<td><%=rs.getInt("Order_Amount") %></td>
			<td><%=rs.getString("Approval_Status") %></td>
			<td><%=rs.getString("Approved_By") %></td>
			<td><%=rs.getString("Notes") %></td>
			<td><%=rs.getDate("Order_Date") %></td>
			</tr>
			<% 
		}
				
	}
	catch(Exception ex)
	{
		out.println("Exception:"+ex.getMessage());
		ex.printStackTrace();
	}
	%>


</table>
</body>
</html>