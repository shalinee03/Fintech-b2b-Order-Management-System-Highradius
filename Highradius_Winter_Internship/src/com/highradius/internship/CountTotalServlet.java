package com.highradius.internship;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import com.highradius.internship.OrderPojo;

public class CountTotalServlet {
	public static Connection getConnection(){
		Connection con=null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship","root","shalineesecret@1");
		}catch(Exception e){System.out.println(e);}
		return con;
	}

	public static int count_orders(){
		String Countrow="";
		int count_row=0;
		//List<Emp> list=new ArrayList<Emp>();
		try{

			Connection con=getConnection();
			Statement st=con.createStatement();
			String strQuery = "SELECT COUNT(*) FROM order_details";
			ResultSet rs = st.executeQuery(strQuery);
			
			while(rs.next()){
			Countrow = rs.getString(1);
			
			}
			count_row=Integer.parseInt(Countrow);
			count_row=(int)(Math.ceil(count_row/10));
			con.close();
		}catch(Exception e){System.out.println(e);}
		return count_row;
	}
}

