<%@include file="db-connect.jsp"%>

<%
	if(session.getAttribute("iid")==null){
		response.sendRedirect("index.jsp");
		return;
	}
	
	String succ="", err="";
	
  	if(request.getParameter("submit")!=null){
		int sid = Integer.parseInt(session.getAttribute("iid").toString());
		int rid = Integer.parseInt(request.getParameter("rid"));
  		String subject = request.getParameter("subject");
  		String msg = request.getParameter("msg");
  		
  		PreparedStatement ps = con.prepareStatement("insert into messages1(sender_id, receiver_id, subject, message_date, message_content) values(?,?,?,current_date,?)");
  		ps.setInt(1, sid);
  		ps.setInt(2, rid);
  		ps.setString(3, subject);
  		ps.setString(4, msg);
  		
		if(ps.executeUpdate()>0){
			succ = "Message sent successfully";
		}
	  	else{
	  		err = "Please Try Again Later";
	  	}				
  	}
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
             	<% if(succ.length()!=0){ %>
				    <script>
				    	Swal.fire(
				    		  'Success',
				    		  "<%=succ%>!",
				    		  'success'
				    		).then(function() {
							    window.location.href = "investor-view-sellers.jsp";
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
							    window.location.href = "investor-view-sellers.jsp";
							});
				    </script>
				<% } %>
				<p><marquee onMouseOver="this.stop()" onMouseOut="this.start()">Empowerment of Rural Women Entrepreneurs</marquee></p>
				<ol class="breadcrumb">
                	<li class="breadcrumb-item"><a href="investor-dashboard.jsp">Dashboard</a></li>
					<li class="breadcrumb-item active">Investor Send Message</li>
              	</ol>
                <hr>
                <div class="card col-md-12">
                	<div class="card-body">
                    	<div class="card">
                        	<h2> Send Message</h2>
                            <div class="card-body">
								<form method="post">
									<input type="hidden" name="rid" value='<%=request.getParameter("id")%>'>
                                	<div class="form-group">
                                    	<label for="exampleInputPassword1">Subject</label>
                                        <input type="text" name="subject" class="form-control" required>
                                   	</div>
                                    <div class="form-group">
                                    	<label for="exampleInputPassword1">Message</label>
                                    	<textarea rows="5" cols="50" class="form-control" name="msg" required></textarea>
                                   	</div>
                                    <button type="submit" name="submit" class="btn btn-success">Send</button>
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