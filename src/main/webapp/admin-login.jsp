<%@include file="db-connect.jsp"%>
<%
	String success="", error="";

   	if(request.getParameter("submit")!=null){
      	String email=request.getParameter("email");
      	String pass=request.getParameter("pass");
      
      	ResultSet sel=con.createStatement().executeQuery("select * from admin where admin_email='"+email+"' and admin_pwd='"+pass+"'");
      	if(sel.next()){
        	session.setAttribute("aid", sel.getString("admin_id"));
         	session.setAttribute("name", sel.getString("admin_name"));
			success = "Admin login successful";
      	}
      	else {
         	error = "Email or password is not correct";
      	}
   	}
%>

<html>
	<head>
		<title>Admin Login</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
		<script src="https://use.fontawesome.com/f59bcd8580.js"></script>	
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.all.min.js"></script>
		<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.min.css" rel="stylesheet">
	</head>

	<body>
<%
	if(success.length()>0){
%>
		<script type="text/javascript">
			Swal.fire({
				title: "Login Successful",
				text: "<%=success%>",
				icon: "success"
			}).then(function() {
			    window.location.href = "admin-dashboard.jsp";
			});
		</script>	
<%
	}
	if(error.length()>0){
%>
		<script type="text/javascript">
			Swal.fire({
				title: "Login Failed",
				text: "<%=error%>",
				icon: "error"
			});
		</script>	
<%
	}
%>

		<div class="container">
			<div class="row m-5 no-gutters shadow-lg">
				<div class="col-md-6 d-none d-md-block">
					<img src="images/admin-login.png" class="img-fluid" style="min-height:100%;" />
				</div>

				<div class="col-md-6 bg-white p-5">
					<h3 class="pb-3"><b>ADMIN LOGIN</b></h3>
					<div class="form-style">
					<form method="post" action="admin-login.jsp">
						<div class="form-group pb-3">
							<input type="email" name="email" placeholder="Email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" required>
						</div>
						<div class="form-group pb-3">
							<input type="password" name="pass" placeholder="Password" class="form-control" id="exampleInputPassword1" required>
						</div>
						<div class="form-group pb-3">
							<center><a href="admin-forgot-password.jsp">Forgot your password?</a></center>
						</div>
						<div class="pb-2">
							<button type="submit" class="btn btn-dark w-100 font-weight-bold mt-2" name="submit">Submit</button>
						</div>
					</form>
					</div>
					<div class="pt-4 text-center">
						Go Back. <a href="index.jsp">Home</a>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>


