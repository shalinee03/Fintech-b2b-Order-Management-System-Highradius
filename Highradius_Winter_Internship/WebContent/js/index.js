
function clickHandler(){
	fetch('http://localhost:8080/1604020/dummy.do?name=Devi')
	  .then(response => response.json())
	  .then(json => {
		      document.getElementById("nameid").innerHTML = "After Fetching My Name is "+	json.name;
			  document.getElementById("requester").innerHTML = "That's Nice";
			  



			  function login()
			  {
				  var uname = document.getElementById("email").value;
				  var pwd = document.getElementById("pwd1").value;
				  var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
				  if(uname =='')
				  {
					  alert("please enter user name.");
				  }
				  else if(pwd=='')
				  {
					  alert("enter the password");
				  }
				  else if(!filter.test(uname))
				  {
					  alert("Enter valid email id.");
				  }
				  else if(pwd.length < 6 || pwd.length > 6)
				  {
					  alert("Password min and max length is 6.");
				  }
				  else
				  {
			  alert('Thank You for Login & You are Redirecting to Campuslife Website');
			//Redirecting to other page or webste code or you can set your own html page.
				 window.location = "http://www.campuslife.co.in";
					  }
			  }		
			  
	  }
	  );
	 
}
