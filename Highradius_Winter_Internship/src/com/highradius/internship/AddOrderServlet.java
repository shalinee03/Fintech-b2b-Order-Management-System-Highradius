package com.highradius.internship;

import java.io.IOException;    
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Connection; 
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * implementation class AddOrderServlet
 */
@WebServlet("/AddOrderServlet")
public class AddOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddOrderServlet() {
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
		
     
//         catch (SQLException e){
// 		 e.printStackTrace();
// 	}
//       	catch(Exception e) {
//       		e.printStackTrace();
//       	}
        
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		PrintWriter pw;  
		response.setContentType("text/html");
		pw=response.getWriter();
		// PrintWriter out = response.getWriter();
		
		
		
 
		 System.out.println("testaddorderdatafromservlet");
		try {
			 Class.forName(dbDriver); 
	    	 Connection con = DriverManager.getConnection(dbURL + dbName, 
	                                                     dbUsername,  
	                                                     dbPassword); 
	         con.setAutoCommit(false);
			  System.out.println("Connected.");
			 int orderID=Integer.parseInt(request.getParameter("orderID"));
			 System.out.println(orderID);
			 SimpleDateFormat formatter=new SimpleDateFormat("MMM dd, yyyy");
			 java.util.Date d=formatter.parse(request.getParameter("date"));
			 java.sql.Date date=new java.sql.Date(d.getTime());
			 System.out.print(date);
			 String companyName=request.getParameter("companyName");
			 int companyID=Integer.parseInt(request.getParameter("companyID"));
			 int orderAmount=Integer.parseInt(request.getParameter("orderAmount")); 
			 String notes=request.getParameter("notes");
			 String approvedBy = null;
			 if(orderAmount<=10000) {
				 approvedBy="David Lee";
			 }
			 else if(orderAmount>10000 && orderAmount<=50000) {
				 approvedBy = "Laura Smith";
			 }
			 else {
				 approvedBy= "Mathew Vans";
			 }
			 String query="Insert into order_details(Order_ID,Customer_Name,Customer_ID,Order_Amount,Approval_Status,Approved_By,Notes,Order_Date) values (?,?,?,?,?,?,?,?);"; 
			    
		         PreparedStatement pstmt=con.prepareStatement(query);    
		         pstmt.setInt(1, orderID);    
		         pstmt.setString(2, companyName);    
		         pstmt.setInt(3,companyID);    
		         pstmt.setInt(4, orderAmount); 
		         pstmt.setString(6,approvedBy); 
		         if(approvedBy=="David Lee")
		        	 pstmt.setString(5,"Approved");
		         else
		        	 pstmt.setString(5,"Awaiting Approval");
		           
		         pstmt.setString(7,notes);
		         pstmt.setDate(8,date);
		         int x=pstmt.executeUpdate();   
		         if(x==1)    
		            {    
		            pw.println("Values Inserted Successfully");    
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