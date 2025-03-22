<%@include file="db-connect.jsp" %>

<%
	String success="", error="";

	if(request.getParameter("submit")!=null){
		String email = request.getParameter("email");
		String pass = request.getParameter("pass");
	
		ResultSet rs = con.createStatement().executeQuery("select * from investor where investor_email = '"+email+"' and investor_pwd = '"+pass+"' and investor_is_active=1");
	
		if(rs.next()){
			session.setAttribute("iid", rs.getString(1));
			session.setAttribute("name", rs.getString(2));
			success = "Investor login successful";
		}
		else{
			error = "Login failed. Invalid login id/password.";
		}
	}
%>
<html>
	<head>
		<title>Investor Login</title>
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
			    window.location.href = "investor-dashboard.jsp";
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
					<img src="images/investor-login.png" class="img-fluid" style="min-height:100%;" />
				</div>
				<div class="col-md-6 bg-white p-5">
					<h3 class="pb-3"><b>INVESTOR LOGIN</b></h3>
					<div class="form-style">
						<form method="post">
							<div class="form-group pb-3">
								<input type="email" placeholder="Email" name="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" required>
							</div>
							<div class="form-group pb-3">
								<input type="password" placeholder="Password" name="pass" class="form-control" id="exampleInputPassword1" required>
							</div>
							<div class="form-group pb-3">
								<div><center><a href="investor-forgot-password.jsp">Forget Password?</a></center></div>
							</div>
							<div class="pb-2">
								<button type="submit" class="btn btn-dark w-100 font-weight-bold mt-2" name="submit">Submit</button>
							</div>
						</form>
					</div>
					<div class="pt-4 text-center">
						Don't have account?. <a href="investor-register.jsp">Create Account</a>
					</div>
					<div class="pt-4 text-center">
						Go Back. <a href="index.jsp">Home</a>
					</div>
					
				</div>
			</div>
		</div>
	</body>
</html>

