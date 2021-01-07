package com.highradius.internship;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RejectServlet
 */
@WebServlet("/RejectServlet")
public class RejectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RejectServlet() {
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
			try {
				 Class.forName(dbDriver); 
		    	 Connection con = DriverManager.getConnection(dbURL + dbName, 
		                                                     dbUsername,  
		                                                     dbPassword); 
		         con.setAutoCommit(false);
		         System.out.println("Connected in approve servlet.");
				 int orderID=Integer.parseInt(request.getParameter("orderID"));
				 System.out.println(orderID);
				 
				 String query = "update order_details set  Approval_Status ='Rejected' where Order_ID=?";
				  
				  PreparedStatement pstmt=con.prepareStatement(query);    
			         pstmt.setInt(1, orderID);    
			         int x=pstmt.executeUpdate();   
			         if(x==1)    
			            {    
			            pw.println("Values rejected Successfully");    
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
