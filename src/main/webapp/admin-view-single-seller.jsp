<%@include file="db-connect.jsp"%>

<%
	if(session.getAttribute("aid")==null){
		response.sendRedirect("index.jsp");
		return;
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
				<p><marquee onMouseOver="this.stop()" onMouseOut="this.start()">Empowerment of Rural Women Entrepreneurs</marquee></p>
               	<ol class="breadcrumb">
                	<li class="breadcrumb-item"><a href="admin-view-sellers.jsp">Sellers</a></li>
                	<li class="breadcrumb-item active">View Seller</li>
                </ol>
				<hr>
                <div class="card">
                	<div class="card-header">View Seller</div>
					<div class="card-body">
<%
	int uid = Integer.parseInt(request.getParameter("id"));
	PreparedStatement ps = con.prepareStatement("select * from seller where seller_id=?");
	ps.setInt(1, uid);
	ResultSet rs = ps.executeQuery();
	rs.next();
%>
						<table width="100%">
						<tr>
							<td width="30%"><img alt="" src='images/seller/<%=rs.getString("seller_photo")%>' width="350" height="350"> </td>
							<td>
								<form>
		                            <div class="form-group">
		                                 <label for="exampleInputEmail1"><b>ID</b></label>
		                                 <input type="text" value='<%=rs.getString("seller_id")%>' required class="form-control" id="exampleInputEmail1" name="u_fname" readOnly>
		                            </div>
		                            <div class="form-group">
		                                 <label for="exampleInputEmail1"><b>Name</b></label>
		                                 <input type="text" value='<%=rs.getString("seller_name")%>' required class="form-control" id="exampleInputEmail1" name="u_fname" readOnly>
		                            </div>
		                            <div class="form-group">
		                                 <label for="exampleInputEmail1"><b>Business Name</b></label>
		                                 <input type="text" value='<%=rs.getString("seller_business_name")%>' required class="form-control" id="exampleInputEmail1" name="u_fname" readOnly>
		                            </div>
		                            <div class="form-group">
		                                 <label for="exampleInputEmail1"><b>Phone</b></label>
		                                 <input type="text" value='<%=rs.getString("seller_phone")%>' required class="form-control" id="exampleInputEmail1" name="u_fname" readOnly>
		                            </div>
		                            <div class="form-group">
		                                 <label for="exampleInputEmail1"><b>Email</b></label>
		                                 <input type="text" value='<%=rs.getString("seller_email")%>' required class="form-control" id="exampleInputEmail1" name="u_fname" readOnly>
		                            </div>
		                            <div class="form-group">
		                                 <label for="exampleInputEmail1"><b>Address</b></label>
		                                 <input type="text" value='<%=rs.getString("seller_address")%>' required class="form-control" id="exampleInputEmail1" name="u_fname" readOnly>
		                            </div>
		                            <div class="form-group">
		                                 <label for="exampleInputEmail1"><b>About Us</b></label>
		                                 <input type="text" value='<%=rs.getString("seller_about_us")%>' required class="form-control" id="exampleInputEmail1" name="u_fname" readOnly>
		                            </div>
		                            <div class="form-group">
		                                 <label for="exampleInputEmail1"><b>Status</b></label>
		                                 <input type="text" value='<%=rs.getInt("seller_is_active")==0?"Inactive":"Active"%>' required class="form-control" id="exampleInputEmail1" name="u_fname" readOnly>
		                            </div>
								</form>							
							</td>
						</tr>
						</table>
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