<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="com.highradius.internship.DataFetchServlet" %>
<%@ page import="com.highradius.internship.AddOrderServlet" %>
<%@ page import="com.highradius.internship.DatabaseConnection" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="Header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.22/sb-1.0.0/datatables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.22/sb-1.0.0/datatables.min.js"></script>
<script type="text/javascript" src="//cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script>
var totalPages=-1;
var start=0;
var limit=10;
var fetchAndRenderTable = function(start,limit){ 
	  $.ajax({
          type: "Post",
          url: "http://localhost:8181/Highradius_Winter_Internship/DataFetchServlet", //this is my servlet
          data :{'start': start,'limit' :limit , 'from' :"type1user"},
          success: function(data){      
        	  document.getElementById("startpage").innerHTML = start; //for pagination
            $.each(data, function (a, b) {
                $("#mytbl").append('<tr id="' + a + '"></tr>');
                var dataRowId = '#' + a;
                $(dataRowId).append('<input type="checkbox" class="checkbox" id="checkbox'+a+'" name="checkboxName" value=' + a + ' onClick="handleEdit()">')
                $.each(data[a], function (c, d) {
                    $(dataRowId).append('<td name="tdName" id="'+a+c+'" style="padding:10px;color:black;margin: 0px auto;">' + d + '</td>');
                   //c:column name a:row number
                });
            });
          }
      });
}

//disabling edit
var handleEdit = function() {
	var numRows = $('#mytbl tr').length-1;
	console.log(numRows);
	var numSelected = 0;
	for(var i=0; i<numRows; i++) {
		if(document.getElementById("checkbox"+i).checked) {
			numSelected += 1;
		}
	}
	if (numSelected == 1) {
		document.getElementById("mainEdit").disabled = false;
	}
	else {
		document.getElementById("mainEdit").disabled = true;
	}
}
//document ready
$(document).ready(function() {
	fetchAndRenderTable(start,limit);
	countRows();
	document.getElementById("mainEdit").disabled = true;
});
//data adding to table through add function
var addFunc = function(orderID,date,companyName,companyID,orderAmount,notes){
	
	
	$.ajax({
			url:"http://localhost:8181/Highradius_Winter_Internship/AddOrderServlet",
			type:"Post" ,
			data:{
				'orderID': $('#orderid').val(), 'date': $('#date').val(),
				'companyName': $('#companyname').val(), 'companyID': $('#companyid').val(),
				'orderAmount': $('#orderamount').val(), 'notes': $('#notes').val()
			},
			success : function(){
				$('#addModalCenter').modal('hide');
				 var tableHeaderRowCount = 1;
				 var table = document.getElementById('mytbl');
				 var rowCount = table.rows.length;
				 for (var i = tableHeaderRowCount; i <rowCount; i++) {
				     table.deleteRow(tableHeaderRowCount);	
				     }
				 fetchAndRenderTable(start,limit); 
			}

	});
}
//edit function prepopulate data 
var editFunc = function(){
	
	var a = undefined;
	var numRows = $('#mytbl tr').length-1;
	for(var i=0; i<numRows; i++) {
		if(document.getElementById("checkbox"+i).checked) {
			console.log("CHECKED", document.getElementById("checkbox"+i).value)
			a = document.getElementById("checkbox"+i).value;
			break;
		}
	}
	
	console.log(document.getElementById(a+"orderId").innerText);
	console.log(document.getElementById(a+"orderAmount").innerText);
	console.log(document.getElementById(a+"notes").innerText);
	
	//preppopulate data.......
	document.getElementById("editorderid").value = document.getElementById(a+"orderId").innerText;
	document.getElementById("editorderamount").value = document.getElementById(a+"orderAmount").innerText;
	document.getElementById("editnotes").value = document.getElementById(a+"notes").innerText;
	document.getElementById("editapprovalStatus").value = document.getElementById(a+"approvalStatus").innerText;
	document.getElementById("editapprovedby").value = document.getElementById(a+"approvedBy").innerText;
	document.getElementById("editorderid").disabled = true;
	document.getElementById("editapprovalStatus").disabled = true;
	document.getElementById("editapprovedby").disabled = true;
}
//edit function to add data table
var editFuncajax = function(){
	
	$.ajax({
			url:"http://localhost:8181/Highradius_Winter_Internship/EditOrderServlet",
			type:"Post" ,
			data:{
				'orderID': $('#editorderid').val(), 'approvedBy':$('#editapprovedby').val(),
				'approvalStatus':$('#editapprovalStatus').val(),
				'orderAmount':$('#editorderamount').val(),'notes':$('#editnotes').val()
			},
			success : function(){
				$('#editModalCenter').modal('hide');
				 var tableHeaderRowCount = 1;
				 var table = document.getElementById('mytbl');
				 var rowCount = table.rows.length;
				 for (var i = tableHeaderRowCount; i <rowCount; i++) {
				     table.deleteRow(tableHeaderRowCount);	
				     }
				 fetchAndRenderTable(start,limit);  
			}
	

	});
}
//in edit function aprroval 
var handleAprrovedBy = function(){
	if(document.getElementById("editorderamount").value<=10000)
		document.getElementById("editapprovedby").value="David Lee";
	else if(document.getElementById("editorderamount").value>10000 && document.getElementById("editorderamount").value<=50000)
		document.getElementById("editapprovedby").value="Laura Smith";
	else
		document.getElementById("editapprovedby").value="Mathew Vans";
}
//to count total rows for pagination
var countRows=function(){
	$.ajax({
		url:"http://localhost:8181/Highradius_Winter_Internship/CountServlet",
		type:"Post" ,
		success : function(data){
			totalPages=data;
			console.log(data);
			document.getElementById("totalpage").innerHTML = data;
		}
	});
}
//pagination 
 var nextFunc= function(){
	 start+=1;
	 var tableHeaderRowCount = 1;
	 var table = document.getElementById('mytbl');
	 var rowCount = table.rows.length;
	 for (var i = tableHeaderRowCount; i <rowCount; i++) {
	     table.deleteRow(tableHeaderRowCount); 
	 }
	 fetchAndRenderTable(start,limit);
 }
 var prevFunc= function(){
	 start-=1;
	 start = Math.max(start,0)
	 var tableHeaderRowCount = 1;
	 var table = document.getElementById('mytbl');
	 var rowCount = table.rows.length;
	 for (var i = tableHeaderRowCount; i <rowCount; i++) {
	     table.deleteRow(tableHeaderRowCount);
	 }
	 fetchAndRenderTable(start,limit); 
 }	
 var firstFunc= function(){
	 start=0;
	 var tableHeaderRowCount = 1;
	 var table = document.getElementById('mytbl');
	 var rowCount = table.rows.length;
	 for (var i = tableHeaderRowCount; i <rowCount; i++) {
	     table.deleteRow(tableHeaderRowCount);
	 }
	 fetchAndRenderTable(start,limit); 
 }	
 var lastFunc= function(){
	 start+=1;
	 var tableHeaderRowCount = 1;
	 var table = document.getElementById('mytbl');
	 var rowCount = table.rows.length;
	 for (var i = tableHeaderRowCount; i <rowCount; i++) {
	     table.deleteRow(tableHeaderRowCount);	
	     }
	 fetchAndRenderTable(start,limit); 
 }	
 //search function
 var search= function searchFun() {
	    var input, filter, table, tr, td, i, txtValue;
	    input = document.getElementById('search');
	    filter = input.value.toUpperCase();
	    table = document.getElementById('mytbl');
	    tr = table.getElementsByTagName('tr');
	    for (i = 0; i < tr.length; i++) {
	    td = tr[i].getElementsByTagName('td')[2];
	    if (td) {
	      txtValue = td.textContent || td.innerText;
	      if (txtValue.toUpperCase().indexOf(filter) > -1) {
	      tr[i].style.display = '';
	      } else {
	      tr[i].style.display = 'none';
	      }
	    }       
	  }
 }

</script>

 
<style type="text/css">
.table {
    margin: 0 auto;
    width: 80%;
}
.tableSearch{
margin-left: 10px;
}
</style>
<style>
a {
  text-decoration: none;
  display: inline-block;
  padding: 8px 16px;
}

a:hover {
  background-color: #ddd;
  color: black;
}

.previous {
  background-color: #f1f1f1;
  color: black;
}

.next {
  background-color: #4CAF50;
  color: white;
}
.paginationbuttonclass{
border-radius: 4px;
background-color: #f2f8fa;
color: black;
border: 2px solid #008CBA;
}
.paginationbuttonclass:hover {
  background-color:#f0b55d;
  color: white;
}
.customCheckbox > input[type=customCheckbox] {
  visibility: hidden;
}

.customCheckbox {
  position: relative;
  display: block;
  width: 80px;
  height: 26px;
  margin: 0 auto;
  background: #FFF;
  border: 1px solid #2E2E2E;
  border-radius: 2px;
  -webkit-border-radius: 2px;
  -moz-border-radius: 2px;
}

.customCheckbox:after {
  position: absolute;
  display: inline;
  right: 10px;
  content: 'no';
  color: #E53935;
  font: 12px/26px Arial, sans-serif;
  font-weight: bold;
  text-transform: capitalize;
  z-index: 0;
}

.customCheckbox:before {
  position: absolute;
  display: inline;
  left: 10px;
  content: 'yes';
  color: #43A047;
  font: 12px/26px Arial, sans-serif;
  font-weight: bold;
  text-transform: capitalize;
  z-index: 0;
}

tr:nth-child(even) {
  background-color: white;
}

tr:nth-child(even) {
  background-color: #dbf0f9;
}

.table-hover tbody tr:hover td, .table-hover tbody tr:hover th {
  background-color: #fce6b3;
}

.form-control:focus {
   border-color: #f0d086 !important;
   box-shadow: 0 0 0 0.2rem #f0d086 !important;
    } 
.bottomborder{
 border-style: solid;
  border-bottom-color: #f0d086;
}

</style>

<title>type1</title>

<!-- Editable table --> 
</head>
<body>

<!-- ADD Modal -->
<div class="modal fade" id="addModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Add Order</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form   id="addorderform">
      <div class="modal-body">
		  <div class="form-group">
		    <label>Order ID</label>
		    <input type="text" name="orderID" class="form-control" id="orderid"  placeholder="Enter Order ID" required>
		  </div>
		  	  <div class="form-group">
		    <label>Date</label>
		    <input type="text" name="date" class="form-control" id="date"   placeholder="Enter Date" required>
		  </div>
		  	  <div class="form-group">
		    <label>Company Name</label>
		    <input type="text" name="companyName" class="form-control" id="companyname"  placeholder="Enter Company Name" required>
		  </div>
		  	  <div class="form-group">
		    <label>Company ID</label>
		    <input type="text" name="companyID" class="form-control" id="companyid"  placeholder="Enter Company ID" required>
		  </div>
		  	  <div class="form-group">
		    <label>Order Amount</label>
		    <input type="text" name="orderAmount" class="form-control" id="orderamount"  placeholder="Enter Amount" required >
		  </div>
		  	  <div class="form-group">
		    <label>Notes</label>
		    <input type="text" name="notes" class="form-control" id="notes"  placeholder="Enter Notes" >
		  </div>
      </div>
      <div class="modal-footer">
        <button type="submit" name="addorder" class="btn btn-warning btn btn-primary btn-lg text-center" onclick="addFunc()">ADD</button>
      </div>
      </form>
    </div>
  </div>
</div>

<!-- EDIT Modal -->
<div class="modal fade" id="editModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Edit Order</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      <form  id="editorderform">
      <div class="modal-body">
		  <div class="form-group">
		    <label>Order ID</label>
		    <input type="text" name="orderID" class="form-control" id="editorderid" placeholder="Enter Order ID" required>
		  </div>
		  	  <div class="form-group">
		    <label>Order Amount</label>
		    <input type="text" name="orderAmount" class="form-control" id="editorderamount" placeholder="Enter Amount" onchange="handleAprrovedBy()" required>
		  </div>
		  <div class="form-group">
		    <label>Approved by</label>
		    <input type="text" name="approvedBy" class="form-control" id="editapprovedby" placeholder="Approved By">
		  </div>
		  <div class="form-group">
		    <label>Approval status</label>
		    <input type="text" name="approvalStatus" class="form-control" id="editapprovalStatus" placeholder="Approval Status">
		  </div>
		  	  <div class="form-group">
		    <label>Notes</label>
		    <input type="text" name="notes" class="form-control" id="editnotes" placeholder="Enter Notes">
		  </div>
      </div>
      <div class="modal-footer">
        <button type="submit" name="editorder" class="btn btn-warning btn btn-primary btn-lg text-center" onClick="editFuncajax()">submit</button>
      </div>
      </form>
    </div>
  </div>
</div>

<span>
  <div id="table" class="table-editable table table-hover table table-sm table table-bordered" style="width:100%" >
                <button type="button" class="btn btn-warning btn btn-primary btn-lg" data-toggle="modal" data-target="#addModalCenter"  > 
                  Add
                </button> 

                <button type="button" id="mainEdit" class="btn btn-warning btn btn-primary btn-lg" data-toggle="modal" data-target="#editModalCenter" onClick="editFunc()"> 
                  Edit
                </button>  
  <span class="table-add float-right ">
  <input class="form-control" type="text" placeholder="Search" aria-label="Search" id="search" onkeyup="search()">
  </span> 
 
      <table class="table table-bordered table-responsive-sm text-center " id='mytbl' style="width:100%" >
      <tr>  
      <th></th>
      <th>orderDate</th>
      <th>ApprovedBy</th>
      <th>orderID</th>
      <th>CompanyName</th>
      <th>CompanyID</th>
      <th>OrderAmount</th>
      <th>ApprovalStatus</th>
      <th>Notes</th>
      </tr>
      </table>
      <footer>
      
 <div class="pagination">
<button type="button" class="paginationbuttonclass" id="first" onclick="firstFunc()"> 
           <<       
</button> 

<button type="button" class="paginationbuttonclass" id="prev" onclick="prevFunc()"> 
                 <
</button>&nbsp
<p>Page</p>&nbsp&nbsp
<p id="startpage"></p>&nbsp&nbsp
<p>of</p>&nbsp&nbsp
<p id="totalpage"></p>&nbsp
<button type="button" class="paginationbuttonclass" id="next" onclick="nextFunc()"> 
                 >
</button> 
<button type="button" class="paginationbuttonclass" id="last" onclick="lastFunc()"> 
         >>         
</button> 

</div>
</footer>     
    </div>
</span>
</body>
</html>