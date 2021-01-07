package com.highradius.internship;
import java.sql.Connection;  
 
import java.sql.*;
import java.sql.DriverManager; 
import java.sql.SQLException;
import java.sql.Statement;




public class DatabaseConnection {
	static Connection con;
	protected static void initializeDatabase() 
	        throws SQLException, ClassNotFoundException 
	          { 
	        // Initialize all the information regarding 
	        // Database Connection 
	        String dbDriver = "com.mysql.jdbc.Driver"; 
	        String dbURL = "jdbc:mysql:// localhost:3306/"; 
	        String dbName = "winter_internship"; 
	        String dbUsername = "root"; 
	        String dbPassword = "shalineesecret@1"; 
	        
	        try { 
	        Class.forName(dbDriver); 
	        con = DriverManager.getConnection(dbURL + dbName, 
	                                                     dbUsername,  
	                                                     dbPassword); 
	       
			con.setAutoCommit(false);
			System.out.println("Connected.");
	        }catch (SQLException e){
	    		e.printStackTrace();
	    	}
	    }
	
	public static int execUpdate(String sql) {
		int returnValue =0;
		try { 
			Statement st = con.createStatement();
			returnValue = st.executeUpdate(sql);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return returnValue;
	}
	public static ResultSet execQuery(String sql) {
		ResultSet res = null;
		try {
			Statement st = con.createStatement();
				res = st.executeQuery(sql);
			}
		catch (SQLException e){
				e.printStackTrace();
			}
		
		return res;
		
	
	}
	 
}

