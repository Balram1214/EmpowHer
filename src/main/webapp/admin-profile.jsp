<%@include file="db-connect.jsp"%>

<%
	if(session.getAttribute("aid")==null){
		response.sendRedirect("index.jsp");
		return;
	}
	
	String succ="", err="";
	int aid = Integer.parseInt(session.getAttribute("aid").toString());
	
  	if(request.getParameter("change_profile")!=null){
  		String name = request.getParameter("name");
  		String email = request.getParameter("email");
  		String phone = request.getParameter("phone");
  		
  		PreparedStatement ps = con.prepareStatement("update admin set admin_name=?, admin_email=?, admin_phone=? where admin_id=?");
  		ps.setString(1, name);
  		ps.setString(2, email);
  		ps.setString(3, phone);
  		ps.setInt(4, aid);
  		 		
		if(ps.executeUpdate()>0){
			succ = "Profile updated successfully";
	 	}
	  	else{
	  		err = "Please Try Again Later";
	  	}				
  	}
  	
  	ResultSet rs = null;
  	if(request.getParameter("flag")!=null){
  		rs = con.createStatement().executeQuery("select * from admin where admin_id="+aid);
  		rs.next();
  	}
%>
<!DOCTYPE html>
<html lang="en">
<%@include file="admin-head.jsp"%>
<body id="page-top">
	<%@include file="admin-nav.jsp"%>
	<div id="wrapper">
    	<%@include file="admin-sidebar.jsp"%>
        <div id="content-wrapper">
             <div class="container-fluid">
             	<% if(succ.length()!=0){ %>
				    <script>
				    	Swal.fire(
				    		  'Success',
				    		  "<%=succ%>!",
				    		  'success'
				    		).then(function() {
							    window.location.href = "admin-dashboard.jsp";
							});
				    </script>
				<% } %>
             	<% if(err.length()!=0){ %>
				    <script>
					    Swal.fire({
					    	  icon: 'error',
					    	  title: 'Failed!',
					    	  text: "<%=err%>",
					    	}).then(function() {
								window.location.href = "admin-dashboard.jsp";
							});
				    </script>
				<% } %>
				<p><marquee onMouseOver="this.stop()" onMouseOut="this.start()">Empowerment of Rural Women Entrepreneurs</marquee></p>
				<ol class="breadcrumb">
                	<li class="breadcrumb-item"><a href="admin-dashboard.jsp">Dashboard</a></li>
					<li class="breadcrumb-item active">Admin Update Profile</li>
              	</ol>
                <hr>
                <div class="card col-md-12">
                	<div class="card-body">
                    	<div class="card">
                        	<h2> Change Profile</h2>
                            <div class="card-body">
								<form method="post">
                                	<div class="form-group">
                                    	<label for="exampleInputPassword1"><b>Admin Name</b></label>
                                        <input type="text" name="name" class="form-control" value='<%=rs.getString("admin_name")%>' required>
                                   	</div>
                                    <div class="form-group">
                                    	<label for="exampleInputPassword1"><b>Admin Email</b></label>
                                        <input type="email" name="email" class="form-control" value='<%=rs.getString("admin_email")%>' required>
                                   	</div>
                                    <div class="form-group">
                                    	<label for="exampleInputPassword1"><b>Admin Phone</b></label>
                                        <input type="text" class="form-control" name="phone" pattern="^[6789]\d{9}$" value='<%=rs.getString("admin_phone")%>' required>
                              		</div>
                                    <button type="submit" name="change_profile" class="btn btn-success">Submit</button>
                              	</form>
                          	</div>
                    	</div>
                	</div>
              	</div>
             </div>
             <hr>
             <%@include file="admin-footer.jsp"%>
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
                         <a class="btn btn-danger" href="admin-logout.jsp">Logout</a>
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