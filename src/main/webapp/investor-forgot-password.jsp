<%@include file="db-connect.jsp"%>
<%
	String success="", error="";

   	if(request.getParameter("submit")!=null){
      	String email = request.getParameter("email");
      	String phone = request.getParameter("phone");
      	String pass = request.getParameter("pass");
      	String cpass = request.getParameter("cpass");
      
      	ResultSet sel=con.createStatement().executeQuery("select * from investor where investor_email='"+email+"' and investor_phone	='"+phone+"'");
      	if(sel.next()){
      		
      		con.createStatement().executeUpdate("update investor set investor_pwd='"+pass+"' where investor_email='"+email+"'");
			success = "Investor password reset successful";
      	}
      	else {
         	error = "Email or phone not found";
      	}
   	}
%>

<html>
	<head>
		<title>investor Reset Password</title>
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
				title: "Password reset successful",
				text: "<%=success%>",
				icon: "success"
			}).then(function() {
			    window.location.href = "investor-login.jsp";
			});
		</script>	
<%
	}
	if(error.length()>0){
%>
		<script type="text/javascript">
			Swal.fire({
				title: "Password reset failed",
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
					<img src="images/investor-login.png" class="img-fluid" style="min-height:100%;" />
				</div>

				<div class="col-md-6 bg-white p-5">
					<h3 class="pb-3"><b>INVESTOR RESET PASSWORD</b></h3>
					<div class="form-style">
					<form method="post" onsubmit="return valid()">
						<div class="form-group pb-3">
							<input type="email" name="email" placeholder="Email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" required>
						</div>
						<div class="form-group pb-3">
							<input type="text" name="phone" placeholder="Phone" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" required>
						</div>
						<div class="form-group pb-3">
							<input type="password" name="pass" placeholder="New Password" class="form-control" id="pass" required>
						</div>
						<div class="form-group pb-3">
							<input type="password" name="cpass" placeholder="Confirm Password" class="form-control" id="cpass" required>
						</div>
						<div class="pb-2">
							<button type="submit" class="btn btn-dark w-100 font-weight-bold mt-2" name="submit">Reset Password</button>
						</div>
					</form>
					</div>
					<div class="pt-4 text-center">
						Go Back. <a href="index.jsp">Home</a>
					</div>
				</div>
			</div>
		</div>

		<script type="text/javascript">
			function valid(){
				pass = document.getElementById("pass").value;
				cpass = document.getElementById("cpass").value;
				
				if(pass!=cpass){
					Swal.fire({
						title: "Password reset failed",
						text: "Password & confirm password not matching",
						icon: "error"
					}).then(function() {
					    window.location.href = "admin-forgot-password.jsp";
					});
					return false;
				}
				
				return true;
			}
		</script>
	</body>
</html>



