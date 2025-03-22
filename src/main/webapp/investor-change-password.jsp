<%@include file="db-connect.jsp"%>

<%
	if(session.getAttribute("iid")==null){
		response.sendRedirect("index.jsp");
		return;
	}
	
	String succ="", err="";
	
  	if(request.getParameter("change_pwd")!=null){
		int iid = Integer.parseInt(session.getAttribute("iid").toString());
  		String opass = request.getParameter("opass");
  		String npass = request.getParameter("npass");
  		String cpass = request.getParameter("cpass");
  		
  		PreparedStatement ps = con.prepareStatement("select * from investor where investor_pwd=? and investor_id=?");
  		
  		ps.setString(1, opass);
  		ps.setInt(2, iid);
  		
  		ResultSet rs = ps.executeQuery();
  		
  		if(rs.next()){
			if(npass.equals(cpass)){
	  			ps = con.prepareStatement("UPDATE investor SET investor_pwd = ? WHERE investor_id = ?");
	  	  		ps.setString(1, npass);
	  	  		ps.setInt(2, iid);

	  	  		if(ps.executeUpdate()>0){
	  	    		succ = "Password Changed";
	  	       	}
	  	        else{
	  	          	err = "Please Try Again Later";
	  	       	}				
			}
			else{
				err = "New password and confirm password doesn't match";
			}
  		}
  		else{
  			err = "Invalid current password";	
  		}
  	}
%>
<!DOCTYPE html>
<html lang="en">
<%@include file="investor-head.jsp"%>
<body id="page-top">
	<%@include file="investor-nav.jsp"%>
	<div id="wrapper">
    	<%@include file="investor-sidebar.jsp"%>
        <div id="content-wrapper">
             <div class="container-fluid">
             	<% if(succ.length()!=0){ %>
				    <script>
				    	Swal.fire(
				    		  'Success',
				    		  "<%=succ%>!",
				    		  'success'
				    		);
				    </script>
				<% } %>
             	<% if(err.length()!=0){ %>
				    <script>
					    Swal.fire({
					    	  icon: 'error',
					    	  title: 'Failed!',
					    	  text: "<%=err%>",
					    	})
				    </script>
				<% } %>
				<p><marquee onMouseOver="this.stop()" onMouseOut="this.start()">Empowerment of Rural Women Entrepreneurs</marquee></p>
				<ol class="breadcrumb">
                	<li class="breadcrumb-item"><a href="investor-dashboard.jsp">Dashboard</a></li>
					<li class="breadcrumb-item active">Investor Update Password</li>
              	</ol>
                <hr>
                <div class="card col-md-12">
                	<div class="card-body">
                    	<div class="card">
                        	<h2> Change Password</h2>
                            <div class="card-body">
								<form method="post">
                                	<div class="form-group">
                                    	<label for="exampleInputPassword1">Old Password</label>
                                        <input type="password" name="opass" class="form-control" required>
                                   	</div>
                                    <div class="form-group">
                                    	<label for="exampleInputPassword1">New Password</label>
                                        <input type="password" name="npass" class="form-control" required>
                                   	</div>
                                    <div class="form-group">
                                    	<label for="exampleInputPassword1">Confirm New Password</label>
                                        <input type="password" class="form-control" name="cpass" required>
                              		</div>
                                    <button type="submit" name="change_pwd" class="btn btn-success">Submit</button>
                              	</form>
                          	</div>
                    	</div>
                	</div>
              	</div>
             </div>
             <hr>
             <%@include file="investor-footer.jsp"%>
		</div>
    	<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>
        <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        	<div class="modal-dialog" role="document">
            	<div class="modal-content">
                	<div class="modal-header">
                    	<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                   	</div>
                    <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                    <div class="modal-footer">
                         <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                         <a class="btn btn-danger" href="investor-logout.jsp">Logout</a>
                    </div>
               	</div>
           	</div>
		</div>
	</div>
	<script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="vendor/datatables/jquery.dataTables.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.js"></script>
    <script src="js/sb-admin.min.js"></script>
    <script src="js/datatables-demo.js"></script>
    <script src="js/chart-area-demo.js"></script>
</body>
</html>