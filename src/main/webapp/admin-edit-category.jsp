<%@include file="db-connect.jsp"%>

<%
	if(session.getAttribute("aid")==null){
		response.sendRedirect("index.jsp");
		return;
	}

	String succ="", err=""; 

	if(request.getParameter("edit_category")!=null){
		int id = Integer.parseInt(request.getParameter("id"));
		String name = request.getParameter("name");
        String desc = request.getParameter("desc");
		
		PreparedStatement ps = con.prepareStatement("update category set category_name=?, category_description=? where category_id=?");
		ps.setString(1, name);
		ps.setString(2, desc);
		ps.setInt(3, id);
			
		if(ps.executeUpdate()>0){
			succ = "Product category updated successfully.";
		}
		else {
			err = "Something went wrong. Please try again";
		}
	}       
	
	ResultSet rs = null;
	if(request.getParameter("id")!=null){
		rs = con.createStatement().executeQuery("select * from category where category_id="+request.getParameter("id"));
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
							    window.location.href = "admin-manage-category.jsp";
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
							    window.location.href = "admin-manage-category.jsp";
							});
				    </script>
				<% } %>
				<p><marquee onMouseOver="this.stop()" onMouseOut="this.start()">Empowerment of Rural Women Entrepreneurs</marquee></p>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="admin-manage-category.jsp">Category List</a></li>
					<li class="breadcrumb-item active">Edit Category</li>
				</ol>
				<hr>
				<div class="card">
                	<div class="card-header">Edit Category</div>
					<div class="card-body">
						<form method="POST">
                        	<div class="form-group">
                            	<label for="exampleInputEmail1"><b>ID</b></label>
                                <input type="text" required class="form-control" id="exampleInputEmail1" name="id" value='<%=rs.getInt("category_id")%>' readOnly>
							</div>
                        	<div class="form-group">
                            	<label for="exampleInputEmail1">Name</label>
                                <input type="text" required class="form-control" id="exampleInputEmail1" name="name" value='<%=rs.getString("category_name")%>' required>
							</div>
                            <div class="form-group">
                            	<label for="exampleInputEmail1">Description</label>
                                <textarea class="form-control" id="exampleInputEmail1" name="desc" rows=5 required><%=rs.getString("category_description")%></textarea>
                            </div>
							<button type="submit" name="edit_category" class="btn btn-success">Update Category</button>
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