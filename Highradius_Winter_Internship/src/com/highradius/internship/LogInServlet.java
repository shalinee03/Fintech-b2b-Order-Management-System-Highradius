package com.highradius.internship;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LogInServlet
 */
@WebServlet("/LogInServlet")
public class LogInServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
     * @see HttpServlet#HttpServlet()
     */
  public LogInServlet() {
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

    String userName = request.getParameter("username");
    String password = request.getParameter("password");
    System.out.println(userName);
    System.out.println(password);
    
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();

    try {
      Class.forName(dbDriver);
      Connection con = DriverManager.getConnection(dbURL + dbName, dbUsername, dbPassword);
      String sql = "select * from user_details";
      int flag=1;
      ResultSet res = con.createStatement().executeQuery(sql);
      //RequestDispatcher dispatcher = null;
      con.setAutoCommit(false);
      while (res.next()) {
        String uname = res.getString("username");
        String pass = res.getString("password");
        if (uname.equals(userName) && pass.equals(password)) {
        	flag=0;
	        String type = res.getString("user_level");
	        if (type.equals("Level 1")) {    
	          out.print("type1user");  
	          break;
	        }
	        else {
	        	out.print("type2user");
	        	break;
	        }
        }
        else {
        	continue;
        }
 
      } 
      if(flag==1) {
    	  out.print("");
      }
      con.close();
      //return;
    }
    catch(SQLException e) {
      e.printStackTrace();
    }
    catch(Exception e) {
      e.printStackTrace();
    }
    //return;
    
   
    
  }
  
  
  /**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
  IOException {
    doGet(request, response);
  }
}