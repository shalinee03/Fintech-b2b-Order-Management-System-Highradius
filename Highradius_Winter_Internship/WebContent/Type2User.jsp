<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script>
//adding data to table
var start=0;
var limit=10;
var fetchAndRenderTable = function(start,limit){ 
	 $.ajax({
         type: "Post",
         url: "http://localhost:8181/Highradius_Winter_Internship/DataFetchServlet", //this is my servlet
         data :{'start': start,'limit' :limit , 'from' :"type2user"},
         success: function(data){      
        	 document.getElementById("startpage").innerHTML = start; //for pagination
           $.each(data, function (a, b) {
               $("#mytbl").append('<tr id="' + a + '"></tr>');
               var dataRowId = '#' + a;
               $(dataRowId).append('<input type="checkbox" class="checkbox" id="checkbox'+a+'" name="checkboxName" value=' + a + ' onClick="handleApproveRejectDisable()" >')
               $.each(data[a], function (c, d) {
                   $(dataRowId).append('<td name="tdName" id="'+a+c+'" style="padding:10px;color:black;margin: 0px auto;">' + d + '</td>');
                  //c:column name a:row number
               });
           });
         }
     });
}
//document or page ready
$(document).ready(function() {
	fetchAndRenderTable(start,limit);   
	document.getElementById("approveid").disabled = true;
	document.getElementById("rejectid").disabled = true;

});

//disabling approve reject
var handleApproveRejectDisable = function() {
	var numRows = $('#mytbl tr').length-1;
	console.log(numRows);
	var numSelected = 0;
	for(var i=0; i<numRows; i++) {
		if(document.getElementById("checkbox"+i).checked) {
			numSelected += 1;
		}
	}
	if (numSelected == 1) {
		document.getElementById("approveid").disabled = false;
		document.getElementById("rejectid").disabled = false;
	}
	else {
		document.getElementById("approveid").disabled = true;
		document.getElementById("rejectid").disabled = true;
	}	
}
//count row for pagination
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
	 for (var i = tableHeaderRowCount; i < rowCount; i++) {
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
	 for (var i = tableHeaderRowCount; i < rowCount; i++) {
	     table.deleteRow(tableHeaderRowCount);
	 }
	 fetchAndRenderTable(start,limit); 
 }	
 var firstFunc= function(){
	 start=0;
	 var tableHeaderRowCount = 1;
	 var table = document.getElementById('mytbl');
	 var rowCount = table.rows.length;
	 for (var i = tableHeaderRowCount; i < rowCount; i++) {
	     table.deleteRow(tableHeaderRowCount);
	 }
	 fetchAndRenderTable(start,limit); 
 }	
 var lastFunc= function(){
	 start+=1;
	 var tableHeaderRowCount = 1;
	 var table = document.getElementById('mytbl');
	 var rowCount = table.rows.length;
	 for (var i = tableHeaderRowCount; i < rowCount; i++) {
	     table.deleteRow(tableHeaderRowCount);
	 }
	 fetchAndRenderTable(start,limit); 
 }	
 //searching
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
//approve fetching row value incheckbox click
 var approveFunc = function(){
		
		var a = undefined;
		var numRows = $('#mytbl tr').length-1;
		for(var i=0; i<numRows; i++) {
			if(document.getElementById("checkbox"+i).checked) {
				console.log("CHECKED", document.getElementById("checkbox"+i).value)
				a = document.getElementById("checkbox"+i).value;
				break;
			}
		}
 }
//reject fetching value in checkbox click
var rejectFunc = function(){
				
	var a = undefined;
	var numRows = $('#mytbl tr').length-1;
	for(var i=0; i<numRows; i++) {
		if(document.getElementById("checkbox"+i).checked) {
		console.log("CHECKED", document.getElementById("checkbox"+i).value)
		a = document.getElementById("checkbox"+i).value;
		break;
			}
		}
}
//approval chnages through servlet
var approveAjax = function(){
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
	$.ajax({
			url:"http://localhost:8181/Highradius_Winter_Internship/ApproveServlet",
			type:"Post" ,
			data:{
				'orderID':document.getElementById(a+"orderId").innerText,
			},
			success : function(){
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
//changes through servlet
var rejectAjax = function(){
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
	$.ajax({
			url:"http://localhost:8181/Highradius_Winter_Internship/RejectServlet",
			type:"Post" ,
			data:{
				'orderID':document.getElementById(a+"orderId").innerText,
			},
			success : function(){
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

tr:nth-child(even) {
  background-color: white;
}

tr:nth-child(even) {
  background-color: #dbf0f9;
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
.form-control:focus {
        border-color: #f0d086 !important;
        box-shadow: 0 0 0 0.2rem #f0d086 !important;
    }
    
.table-hover tbody tr:hover td, .table-hover tbody tr:hover th {
  background-color: #fce6b3;
}
</style>

<title>type1</title>

<!-- Editable table --> 
</head>
<body>

<span>
  <div id="table" class="table-editable table table-hover table table-sm" style="width:100%">
                <button type="button" class="btn btn-warning btn btn-primary btn-lg" onClick="approveAjax() ;" id="approveid"> 
                 Approve
                </button> 
           
                <button type="button" class="btn btn-warning btn btn-primary btn-lg" onClick="rejectAjax()" id="rejectid"> 
                 Reject
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