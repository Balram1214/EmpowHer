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
               		<li class="breadcrumb-item"><a href="admin-dashboard.jsp">Dashboard</a></li>
                    <li class="breadcrumb-item active">Manage Feedbacks</li>
                </ol>
				<div class="card mb-3">
                	<div class="card-header"><i class="fas fa-comments"></i> Received Feedbacks</div>
                    <div class="card-body">
						<div class="table-responsive">
                        	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                            	<thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Name</th>
                                        <th>Contact</th>
                                        <th>Email</th>
                                        <th>Message</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
<%
	String sql = "select * from feedback where f_status='Published'";
	ResultSet rs = con.createStatement().executeQuery(sql);
	int cnt = 1;
	while(rs.next()){
%>                                
								<tbody>
                                    <tr>
                                        <td><%=cnt++%></td>
                                        <td><%=rs.getString("f_uname")%></td>
                                        <td><%=rs.getString("f_phone")%></td>
                                        <td><%=rs.getString("f_email")%></td>
                                        <td><%=rs.getString("f_content")%></td>
										<td><span class="btn btn-outline-success"><i class="fa fa-cogs"></i> <%=rs.getString("f_status")%></span></td>                                    </tr>
                                </tbody>
<%	} %>                               
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
