<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Highradius Winter Internship</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.22/sb-1.0.0/datatables.min.js"></script>
<script type="text/javascript" src="//cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<link rel="stylesheet"  href="css/index.css">
<link rel="jsp"  href="Type1User.jsp">
<link rel="jsp"  href="Type2User.jsp">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" >
<script>
var LoginAjax = function(){ 	
	 $.ajax({
        type: "Post",
        //timeout: 300000,
        url: "http://localhost:8181/Highradius_Winter_Internship/LogInServlet", //this is my login servlet
        data :{'username': $('#username').val(),'password': $('#password').val()},
        success: function(data){
        	console.log(data);
        	//alert("testing");
			if (data == "type1user") {
				alert ("Login successful");
				window.location = "Type1User.jsp" //goes to Type1jspPage	
			}       	
			else if(data == "type2user"){
				alert ("Login successful");
				window.location = "Type2User.jsp" //goes to Type2jspPage  
			}
			else if (data==null || data==""){
				 alert("oopss wrong input");
				 window.location = "login.jsp"
				 return false;   
			}
			
        }
    });
}

</script>
</head>
<body>
<div class="container">
    <div class="row content">
     <div class='nav-brand'>
                  <img src="images/hrc-logo.svg" alt='Official logo' width='200px' height='100px'>
               </div>
        <div class="col-lg-12">
            <img src="images/human-machine-hand-homepage.svg" class="img-fluid" alt="image">
           <p id="oma">ORDER MANAGEMENT APPLICATION</p>
        <div class="float-md-right">
            <h3 class="signin-text mb-3">Sign In</h3>
             <form class="">
        <p>User name</p>
            
        <input type="text" class="form-control input-sm" placeholder="Enter Username" name="username"  id="username" required><br>
        
        <p>Password</p>
            
        <input type="password"  class="form-control input-sm" placeholder="Enter Password" name="password" id="password" required >
       
        <br>
        <a class="button" onClick="LoginAjax()">Log in</a>
        
            </form>
        </div>
    </div>
</div>
</div>
</body>
</html>