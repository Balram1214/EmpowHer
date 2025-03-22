<%@include file="db-connect.jsp"%>

<%
	if(session.getAttribute("aid")==null){
		response.sendRedirect("index.jsp");
		return;
	}

	if(request.getParameter("id")!=null){
		int id = Integer.parseInt(request.getParameter("id"));
		int status = 0;
		PreparedStatement ps = con.prepareStatement("update products set prod_is_verified=? where prod_id=?");
		ps.setInt(1, status);
		ps.setInt(2, id);
		ps.executeUpdate();
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
               		<li class="breadcrumb-item"><a href="admin-dashboard.jsp">Dashboard</a></li>
                    <li class="breadcrumb-item active">View Verified Products</li>
                </ol>
				<div class="card mb-3">
                	<div class="card-header"><i class="fas fa-gift"></i> Products List</div>
                    <div class="card-body">
						<div class="table-responsive">
                        	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                            	<thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Photo</th>
                                        <th>Category</th>
                                        <th>Name</th>
                                        <th>Price</th>
                                        <th>Mfg Date</th>
                                        <th>Validity(Months)</th>
                                        <th>Seller</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
<%
	String sql = "select prod_id, prod_photo, category_name, prod_name, prod_price, prod_mfg_date, prod_months, seller.seller_id, seller_name from products, category, seller where products.category_id = category.category_id and products.seller_id = seller.seller_id and prod_is_verified = 1";

	if(request.getParameter("sid")!=null){
		sql += " and seller.seller_id="+request.getParameter("sid");
	}
	ResultSet rs = con.createStatement().executeQuery(sql);
	
	int cnt = 1;
	while(rs.next()){
%>                                
                                    <tr>
                                        <td><%=cnt++%></td>
                                        <td><img alt="" src='images/products/<%=rs.getString("prod_photo")%>' width="150" height="150"></td>
                                        <td><%=rs.getString("category_name")%></td>
                                        <td><%=rs.getString("prod_name")%></td>
                                        <td><%=rs.getString("prod_price")%></td>
                                        <td><%=rs.getString("prod_mfg_date")%></td>
                                        <td><%=rs.getString("prod_months")%></td>
                                        <td><a href='admin-view-single-seller.jsp?id=<%=rs.getInt("seller_id")%>' class="badge badge-success"><%=rs.getString("seller_name")%></a></td>
                                        <td>
                                            <a href='admin-view-old-products.jsp?id=<%=rs.getInt("prod_id")%>' class="badge badge-danger" title='Deactivate'><i class='fa fa-times'></i></a>
                                        </td>
                                    </tr>
<%	} %>                               
                                </tbody>
							</table>
                        </div>
                    </div>
                    <div class="card-footer small text-muted">Updated at <%=new java.util.Date()%></div>
                </div>
            </div>
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
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="vendor/datatables/jquery.dataTables.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.js"></script>
    <script src="js/sb-admin.min.js"></script>
    <script src="js/datatables-demo.js"></script>
</body>
</html>