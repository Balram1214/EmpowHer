<%@include file="db-connect.jsp"%>

<%
	if(session.getAttribute("aid")==null){
		response.sendRedirect("index.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>EmpowHer - Admin Dashboard</title>
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
    <link href="css/sb-admin.css" rel="stylesheet">
</head>
<body id="page-top">
	<%@include file="admin-nav.jsp"%>	
	<div id="wrapper">
		<%@include file="admin-sidebar.jsp"%>
        <div id="content-wrapper">
			<div class="container-fluid">
            	<p><marquee onMouseOver="this.stop()" onMouseOut="this.start()">Empowerment of Rural Women Entrepreneurs</marquee></p>
				<ol class="breadcrumb">
                	<li class="breadcrumb-item"><a href="admin-dashboard.jsp">Dashboard</a></li>
                    <li class="breadcrumb-item active">Overview</li>
                </ol>
				<div class="row">
                	<div class="col-xl-3 col-sm-6 mb-3">
                        <div class="card text-white bg-dark o-hidden h-100">
                            <div class="card-body">
                                <div class="card-body-icon">
                                    <i class="fas fa-fw fa-users"></i>
                                </div>
<%
	String result ="SELECT count(*) FROM customer";
    ResultSet rs = con.createStatement().executeQuery(result);
    rs.next();
    int users = rs.getInt(1);
%>
                                <div class="mr-5"><span class="badge badge-danger"><%=users%></span> Customers</div>
                            </div>
                            <a class="card-footer text-white clearfix small z-1" href="admin-view-customers.jsp">
                                <span class="float-left">View Details</span>
                                <span class="float-right">
                                    <i class="fas fa-angle-right"></i>
                                </span>
                            </a>
                        </div>
                    </div>
                    <div class="col-xl-3 col-sm-6 mb-3">
                        <div class="card text-white bg-dark o-hidden h-100">
                            <div class="card-body">
                                <div class="card-body-icon">
                                    <i class="fas fa-fw fa-female"></i>
                                </div>
<%
	result ="SELECT count(*) FROM seller where seller_is_active=1";
    rs = con.createStatement().executeQuery(result);
    rs.next();
    int sellers = rs.getInt(1);
%>
                                <div class="mr-5"><span class="badge badge-danger"><%=sellers%></span> Sellers</div>
                            </div>
                            <a class="card-footer text-white clearfix small z-1" href="admin-view-sellers.jsp">
                                <span class="float-left">View Details</span>
                                <span class="float-right">
                                    <i class="fas fa-angle-right"></i>
                                </span>
                            </a>
                        </div>
                    </div>
                    <div class="col-xl-3 col-sm-6 mb-3">
                        <div class="card text-white bg-dark o-hidden h-100">
                            <div class="card-body">
                                <div class="card-body-icon">
                                    <i class="fas fa-address-card"></i>
                                </div>
<%
	result ="SELECT count(*) FROM investor";
    rs = con.createStatement().executeQuery(result);
    rs.next();
    int investors = rs.getInt(1);
%>
                                <div class="mr-5"><span class="badge badge-danger"><%=investors%></span> Investors</div>
                            </div>
                            <a class="card-footer text-white clearfix small z-1" href="admin-view-investors.jsp">
                                <span class="float-left">View Details</span>
                                <span class="float-right">
                                    <i class="fas fa-angle-right"></i>
                                </span>
                            </a>
                        </div>
                    </div>
                    <div class="col-xl-3 col-sm-6 mb-3">
                        <div class="card text-white bg-dark o-hidden h-100">
                            <div class="card-body">
                                <div class="card-body-icon">
                                    <i class="fa fa-list-alt"></i>
                                </div>
<%
	result = "SELECT count(*) FROM category";
    rs = con.createStatement().executeQuery(result);
    rs.next();
    int category = rs.getInt(1);
%>
                                <div class="mr-5"><span class="badge badge-danger"><%=category%></span> Products Category</div>
                            </div>
                            <a class="card-footer text-white clearfix small z-1" href="admin-view-category.jsp">
                                <span class="float-left">View Details</span>
                                <span class="float-right">
                                    <i class="fas fa-angle-right"></i>
                                </span>
                            </a>
                        </div>
                    </div>

                    <div class="col-xl-3 col-sm-6 mb-3">
                        <div class="card text-white bg-dark o-hidden h-100">
                            <div class="card-body">
                                <div class="card-body-icon">
                                    <i class="fa fa-gift"></i>
                                </div>
<%
	result = "SELECT count(*) FROM products where prod_is_verified=0";
    rs = con.createStatement().executeQuery(result);
    rs.next();
    int products = rs.getInt(1);
%>
                                <div class="mr-5"><span class="badge badge-danger"><%=products%></span> New Products</div>
                            </div>
                            <a class="card-footer text-white clearfix small z-1" href="admin-view-new-products.jsp">
                                <span class="float-left">View Details</span>
                                <span class="float-right">
                                    <i class="fas fa-angle-right"></i>
                                </span>
                            </a>
                        </div>
                    </div>

                    <div class="col-xl-3 col-sm-6 mb-3">
                        <div class="card text-white bg-dark o-hidden h-100">
                            <div class="card-body">
                                <div class="card-body-icon">
                                    <i class="fa fa-gift"></i>
                                </div>
<%
	result = "SELECT count(*) FROM products where prod_is_verified=1";
    rs = con.createStatement().executeQuery(result);
    rs.next();
    int old_products = rs.getInt(1);
%>
                                <div class="mr-5"><span class="badge badge-danger"><%=old_products%></span> Verified Products</div>
                            </div>
                            <a class="card-footer text-white clearfix small z-1" href="admin-view-old-products.jsp">
                                <span class="float-left">View Details</span>
                                <span class="float-right">
                                    <i class="fas fa-angle-right"></i>
                                </span>
                            </a>
                        </div>
                    </div>

                    <div class="col-xl-3 col-sm-6 mb-3">
                        <div class="card text-white bg-dark o-hidden h-100">
                            <div class="card-body">
                                <div class="card-body-icon">
                                    <i class="fa fa-comment"></i>
                                </div>
<%
	result = "SELECT count(*) FROM feedback";
    rs = con.createStatement().executeQuery(result);
    rs.next();
    int feedbacks = rs.getInt(1);
%>
                                <div class="mr-5"><span class="badge badge-danger"><%=feedbacks%></span> Feedbacks</div>
                            </div>
                            <a class="card-footer text-white clearfix small z-1" href="admin-view-feedback.jsp">
                                <span class="float-left">View Details</span>
                                <span class="float-right">
                                    <i class="fas fa-angle-right"></i>
                                </span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
			<%@include file="admin-footer.jsp"%>
		</div>
	</div>
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"> </button>
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
    <script src="vendor/chart.js/Chart.min.js"></script>
    <script src="vendor/datatables/jquery.dataTables.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.js"></script>
    <script src="vendor/js/sb-admin.min.js"></script>
    <script src="vendor/js/demo/datatables-demo.js"></script>
    <script src="vendor/js/demo/chart-area-demo.js"></script>
</body>
</html>