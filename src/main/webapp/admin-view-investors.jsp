<%@include file="db-connect.jsp"%>

<%
	if(session.getAttribute("aid")==null){
		response.sendRedirect("index.jsp");
		return;
	}

	if(request.getParameter("id")!=null){
		int id = Integer.parseInt(request.getParameter("id"));
		int status = Integer.parseInt(request.getParameter("status"))==0?1:0;
		PreparedStatement ps = con.prepareStatement("update investor set investor_is_active=? where investor_id=?");
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
                    <li class="breadcrumb-item active">View Investors</li>
                </ol>
				<div class="card mb-3">
                	<div class="card-header"><i class="fas fa-address-card"></i> Registered Investors</div>
                    <div class="card-body">
						<div class="table-responsive">
                        	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                            	<thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Name</th>
                                        <th>Contact</th>
                                        <th>Email</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
<%
	String sql = "select * from investor";
	ResultSet rs = con.createStatement().executeQuery(sql);
	int cnt = 1;
	while(rs.next()){
%>                                
                                    <tr>
                                        <td><%=cnt++%></td>
                                        <td><%=rs.getString("investor_name")%></td>
                                        <td><%=rs.getString("investor_phone")%></td>
                                        <td><%=rs.getString("investor_email")%></td>
                                        <td><%=rs.getInt("investor_is_active")==0?"Inactive":"Active"%></td>
                                        <td>
                                            <a href='admin-view-single-investor.jsp?id=<%=rs.getInt("investor_id")%>' class="badge badge-success" title="View"><i class="fa fa-eye"></i></a>
                                            <a href='admin-view-investors.jsp?id=<%=rs.getInt("investor_id")%>&status=<%=rs.getInt("investor_is_active")%>' class="badge badge-danger" title='<%=rs.getInt("investor_is_active")==0?"Activate":"Deactivate"%>'><%=rs.getInt("investor_is_active")==0?"<i class='fa fa-check'>":"<i class='fa fa-times'>"%></i></a>
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
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">�</button>
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
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>  
    
  	<script> 
		$(document).ready(function () { 
      		$('#dataTable').DataTable(); 
    	});  
  	</script> 
</body>
</html>