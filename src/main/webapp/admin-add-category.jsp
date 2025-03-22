<%@include file="db-connect.jsp"%>

<%
	if(session.getAttribute("aid")==null){
		response.sendRedirect("index.jsp");
		return;
	}

	String succ="", err=""; 

	if(request.getParameter("add_category")!=null){
		String name = request.getParameter("name");
        String desc = request.getParameter("desc");
		
		PreparedStatement ps = con.prepareStatement("INSERT into category(category_name, category_description) values(?,?)");
		ps.setString(1, name);
		ps.setString(2, desc);
			
		if(ps.executeUpdate()>0){
			succ = "Product category added successfully.";
		}
		else {
			err = "Something went wrong. Please try again";
		}
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
					<li class="breadcrumb-item"><a href="admin-dashboard">Dashboard</a></li>
					<li class="breadcrumb-item active">Add Category</li>
				</ol>
				<hr>
				<div class="card">
                	<div class="card-header">Add Category</div>
					<div class="card-body">
						<form method="POST">
                        	<div class="form-group">
                            	<label for="exampleInputEmail1"><b>Name</b></label>
                                <input type="text" required class="form-control" id="exampleInputEmail1" name="name" required>
							</div>
                            <div class="form-group">
                            	<label for="exampleInputEmail1"><b>Description</b></label>
                                <textarea class="form-control" id="exampleInputEmail1" name="desc" rows=5 required></textarea>
                            </div>
							<button type="submit" name="add_category" class="btn btn-success">Add Category</button>
						</form>
					</div>
				</div>
				<hr>
				<%@include file="admin-footer.jsp"%>
			</div>
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