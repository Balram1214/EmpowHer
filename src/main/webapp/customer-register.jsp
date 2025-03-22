<%@include file="db-connect.jsp"%>

<%
	String success="", error="";

	if(request.getParameter("submit")!=null){
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String contact = request.getParameter("contact");

		String sql = "SELECT * FROM customer WHERE cust_email='"+email+"'";
		ResultSet rs = con.createStatement().executeQuery(sql);

		if(rs.next()) {
			error = "User already registred.";
		} 
		else{
			PreparedStatement ps = con.prepareStatement("insert into customer(cust_name, cust_phone, cust_email, cust_pwd) values(?,?,?,?)");
			ps.setString(1, name);
			ps.setString(2, contact);
			ps.setString(3, email);
			ps.setString(4, password);
			if(ps.executeUpdate()>0){
				success = "You are registered successfully";
			}
			else{
				error = "Something went wrong";
			}
		}
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Customer Sign Up</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
		<script src="https://use.fontawesome.com/f59bcd8580.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.all.min.js"></script>
		<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.min.css" rel="stylesheet">
		
		<script type="text/javascript">
			function check()
			{
				pass = document.getElementById("password").value;
				rpass = document.getElementById("rpassword").value;
				if(pass != rpass)
				{
					Swal.fire({
						  title: "Password mismatch",
						  text: "Password doesn\'t match with repeat password",
						  icon: "error"
						});
					return false;
				}
				return true;
			}
		</script>	
	</head>
<body>
<%
	if(success.length()>0){
%>
		<script type="text/javascript">
			Swal.fire({
				title: "Signup Successful",
				text: "<%=success%>",
				icon: "success"
			}).then(function() {
			    window.location.href = "customer-login.jsp";
			});
		</script>	
<%
	}
	if(error.length()>0){
%>
		<script type="text/javascript">
			Swal.fire({
				title: "Signup Failed",
				text: "<%=error%>",
				icon: "error"
			});
		</script>	
<%
	}
%>
		<div class="container">
			<div class="row m-5 no-gutters shadow-lg">
				<div class="col-md-6 d-none d-md-block" style="padding: 50px;">
					<img src="images/customer-login.png" class="img-fluid" style="min-height:50%;" />
				</div>
				<div class="col-md-6 bg-white p-5">
					<h3 class="pb-3"><b>CUSTOMER SIGN UP</b></h3>
					<div class="form-style">
			            <form method="post" onsubmit="return check()">
			            	<div class="form-group"><input class="form-control" type="text" name="name" placeholder="Name" required></div>      	
			                <div class="form-group"><input class="form-control" type="email" name="email" placeholder="Email" required></div>
			            	<div class="form-group"><input class="form-control" type="text" name="contact" placeholder="Contact Number" required></div>
			                <div class="form-group"><input class="form-control" type="password" id="password" name="password" placeholder="Password" required></div>
			                <div class="form-group"><input class="form-control" type="password" id="rpassword" name="password-repeat" placeholder="Password (repeat)" required></div>
			                <div class="form-group"><button class="btn btn-success btn-block" type="submit" name="submit">Sign Up</button></div>
			                <div class="form-group">
				                You already have an account? <a class="already" href="customer-login.jsp"> Login here.</a>
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