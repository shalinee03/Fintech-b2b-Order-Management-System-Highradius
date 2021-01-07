package com.highradius.internship;

import java.io.IOException; 
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EditOrderServlet
 */
@WebServlet("/EditOrderServlet")
public class EditOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditOrderServlet() {
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
		
		PrintWriter pw;  
		response.setContentType("text/html");
		pw=response.getWriter();
		
//		String tdName [] = request.getParameterValues("tdName");
//		
//		for ( String s : tdName) {
//			out.println(s);
//		}
		
		 System.out.println("testaddordereditfromservlet");
			try {
				 Class.forName(dbDriver); 
		    	 Connection con = DriverManager.getConnection(dbURL + dbName, 
		                                                     dbUsername,  
		                                                     dbPassword); 
		         con.setAutoCommit(false);
				 System.out.println("Connected.");
				 int orderID=Integer.parseInt(request.getParameter("orderID"));
				 //System.out.println(orderID);
				// System.out.println(request.getParameter("orderAmount"));
				 int orderAmount=Integer.parseInt(request.getParameter("orderAmount")); 
				 System.out.println(request.getParameter("orderAmount"));
				 String approvalStatus=request.getParameter("approvalStatus");
				 System.out.print("approvalStatus");
				 System.out.println(approvalStatus);
				 String approvedBy=request.getParameter("approvedBy");
				 String notes=request.getParameter("notes");
		
		  String query = "update order_details set Order_Amount = ?, Notes = ? , Approval_Status = ? , Approved_By = ? where Order_ID=?";
		  //DatabaseConnection.execQuery(sqleditorder); 
		  
		  PreparedStatement pstmt=con.prepareStatement(query);    
	         pstmt.setInt(5, orderID);    
	         pstmt.setInt(1, orderAmount);        
	         pstmt.setString(3, approvalStatus);
	         pstmt.setString(4, approvedBy);
	         pstmt.setString(2, notes);
	         int x=pstmt.executeUpdate();   
	         if(x==1)    
	            {    
	            pw.println("Values edited Successfully");    
	            }    
	        con.commit();
	        con.close();
	        
	} 
	catch(Exception e) {
		e.printStackTrace();
	}
	 pw.close();  
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
