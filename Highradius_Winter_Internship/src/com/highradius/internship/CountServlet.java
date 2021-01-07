package com.highradius.internship;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CountServlet
 */
@WebServlet("/CountServlet")
public class CountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CountServlet() {
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
	      String Countrow="";
	 		 int count_row=0;

		try {
			Class.forName(dbDriver); 
	    	 Connection con = DriverManager.getConnection(dbURL + dbName, 
	                                                     dbUsername,  
	                                                     dbPassword); 
	    	 con.setAutoCommit(false);
	    			 		Statement st=con.createStatement();
				String strQuery = "SELECT COUNT(Order_ID) as count_id FROM order_details";
				ResultSet rs = st.executeQuery(strQuery);
				
				while(rs.next()){
				Countrow = rs.getString("count_id");
				System.out.println("Countrow");

				System.out.println(Countrow);
				}
				count_row=Integer.parseInt(Countrow);
				count_row=(int)(Math.ceil(count_row/10))+1;
				con.close();
				PrintWriter out = response.getWriter();
				out.print(count_row);
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
