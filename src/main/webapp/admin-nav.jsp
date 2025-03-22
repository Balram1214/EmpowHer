<nav class="navbar navbar-expand navbar-dark bg-dark static-top">
	<a class="navbar-brand mr-1" href="admin-dashboard.jsp">EmpowHer</a>
	<button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button>
	<form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
   	</form>
	<ul class="navbar-nav ml-auto ml-md-0">
		<li class="nav-item dropdown no-arrow">
	    	<a style="display: flex;" class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	        	<i class="fas fa-user-circle fa-fw"></i>
	            <h6 style="margin-top: -2px;">EmpowHer</h6>
			</a>
	        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
	        	<a class="dropdown-item" href="admin-profile.jsp?flag=1"><i class="fa fa-user" aria-hidden="true"></i> Profile</a>
	            <div class="dropdown-divider"></div>
	        	<a class="dropdown-item" href="admin-change-password.jsp"><i class="fa fa-cog" aria-hidden="true"></i> Setting</a>
	            <div class="dropdown-divider"></div>
	            <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal"><i class="fa fa-power-off" aria-hidden="true"></i> Logout</a>
			</div>
		</li>
	</ul>
</nav>