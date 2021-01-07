package com.highradius.internship;
import com.google.gson.Gson;    
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.highradius.internship.OrderPojo;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * implementation class DataFetchServlet
 */
@WebServlet("/DataFetchServlet")
public class DataFetchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DataFetchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		  String dbDriver = "com.mysql.jdbc.Driver"; 
	      String dbURL = "jdbc:mysql:// localhost:3306/"; 
	      String dbName = "winter_internship"; 
	      String dbUsername = "root"; 
	      String dbPassword = "shalineesecret@1"; 
		try {
			Class.forName(dbDriver); 
	    	 Connection con = DriverManager.getConnection(dbURL + dbName, 
	                                                     dbUsername,  
	                                                     dbPassword); 
	          con.setAutoCommit(false);
			  System.out.println("Connected.");
		 PrintWriter out = response.getWriter();
		 int start=Integer.parseInt(request.getParameter("start"));
		 int limit=Integer.parseInt(request.getParameter("limit"));
		 String from=request.getParameter("from");
		 int offset = start * limit;
		 //String userType = request.getParameter("from");
		 System.out.println("testfromdatafetch");
		 String sql=null;
		//get all order details
		 //if (userType=="type1user") 
		 System.out.printf("FROM: ");
		 System.out.println(from);
		 if(from.equals("type1user")) {
			 System.out.println("1");
			 sql = "select * from order_details limit " +Integer.toString(offset)+", "+Integer.toString( limit);
		 }
		 else if(from.equals("type2user")) {
			 System.out.println("2");
			 sql = "select * from order_details where Order_Amount>10000 limit " +Integer.toString(offset)+", "+Integer.toString( limit);
		 }
			 	
 
		System.out.println(sql);
		ResultSet res = con.createStatement().executeQuery(sql);
		List<OrderPojo> result=new ArrayList<OrderPojo>();
		
		Gson gson= new Gson();	
			while(res.next()) {
				OrderPojo obj=new OrderPojo();
				obj.setApprovalStatus(res.getString("Approval_Status"));
				obj.setOrderId(res.getInt("Order_ID"));
				obj.setCustomerName(res.getString("Customer_Name"));
				obj.setCustomerId(res.getInt("Customer_ID"));
				obj.setOrderAmount(res.getInt("Order_Amount"));
				obj.setApprovedBy(res.getString("Approved_By"));
				obj.setNotes(res.getString("Notes"));
				obj.setOrderDate(res.getDate("Order_Date"));	
				
				result.add(obj);	
			}
			con.close();
			System.out.println("test");
			System.out.println(result);
			 String json_response = gson.toJson(result);
		        response.setContentType("application/json;charset=UTF-8");
		        request.setAttribute("jsonString", json_response);
		        out.println(json_response);
		}
		catch (Exception e) {
			e.printStackTrace();
			}
		
		//add order
		
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}