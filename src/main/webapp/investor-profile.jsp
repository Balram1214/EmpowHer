<%@include file="db-connect.jsp"%>

<%
	if(session.getAttribute("iid")==null){
		response.sendRedirect("index.jsp");
		return;
	}
	
	int iid = Integer.parseInt(session.getAttribute("iid").toString());	
  	ResultSet rs = con.createStatement().executeQuery("select * from investor where investor_id="+iid);
	rs.next();
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
             	<% if(session.getAttribute("succ")!=null){ %>
				    <script>
				    	Swal.fire(
				    		  'Success',
				    		  "<%=session.getAttribute("succ")%>!",
				    		  'success'
				    		).then(function() {
							    window.location.href = "investor-dashboard.jsp";
							});
				    </script>
				<% } %>
             	<% if(session.getAttribute("err")!=null){ %>
				    <script>
					    Swal.fire({
					    	  icon: 'error',
					    	  title: 'Failed!',
					    	  text: "<%=session.getAttribute("err")%>",
					    	}).then(function() {
								window.location.href = "investor-dashboard.jsp";
							});
				    </script>
				<% } %>
				<p><marquee onMouseOver="this.stop()" onMouseOut="this.start()">Empowerment of Rural Women Entrepreneurs</marquee></p>
				<ol class="breadcrumb">
                	<li class="breadcrumb-item"><a href="investor-dashboard.jsp">Dashboard</a></li>
					<li class="breadcrumb-item active">Investor Update Profile</li>
              	</ol>
                <hr>
                <div class="card col-md-12">
                	<div class="card-body">
                    	<div class="card">
                        	<h2> Change Profile</h2>
                            <div class="card-body">
								<form method="post" action="EditInvestorProfileServlet" enctype="multipart/form-data">
                                	<div class="form-group">
                                    	<label for="exampleInputPassword1"><b>Profile Photo</b></label>
                                    	<img alt="" src='images/investor/<%=rs.getString("investor_photo")%>' width=100 height=100>
                                        <input type="file" name="imgpic" class="form-control">
                                   	</div>								
                                	<div class="form-group">
                                    	<label for="exampleInputPassword1"><b>Investor Name</b></label>
                                        <input type="text" name="name" class="form-control" value='<%=rs.getString("investor_name")%>' required>
                                   	</div>
                                    <div class="form-group">
                                    	<label for="exampleInputPassword1"><b>Investor Email</b></label>
                                        <input type="email" name="email" class="form-control" value='<%=rs.getString("investor_email")%>' required>
                                   	</div>
                                    <div class="form-group">
                                    	<label for="exampleInputPassword1"><b>Investor Phone</b></label>
                                        <input type="text" class="form-control" name="contact" pattern="^[6789]\d{9}$" value='<%=rs.getString("investor_phone")%>' required>
                              		</div>
                                    <div class="form-group">
                                    	<label for="exampleInputPassword1"><b>Investor Business Name</b></label>
                                        <input type="text" class="form-control" name="bname" value='<%=rs.getString("investor_business_name")%>' required>
                              		</div>
                                    <div class="form-group">
                                    	<label for="exampleInputPassword1"><b>Investor Address</b></label>
                                        <input type="text" class="form-control" name="addr" value='<%=rs.getString("investor_address")%>' required>
                              		</div>
                                    <div class="form-group">
                                    	<label for="exampleInputPassword1"><b>Investor About Us</b></label>
                                    	<textarea class="form-control" rows="4" cols="50" name="aboutus" required><%=rs.getString("investor_about_us")%></textarea>
                              		</div>
                                    <button type="submit" name="change_profile" class="btn btn-success">Submit</button>
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
<%
	session.removeAttribute("succ");
	session.removeAttribute("err");
%>                                    			
