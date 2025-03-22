<div class="site-navbar py-2">
    <div class="search-wrap">
        <div class="container">
            <a href="#" class="search-close js-search-close"><span class="icon-close2"></span></a>
            <form action="store.jsp" method="GET">
                <input type="text" name="search" class="form-control" placeholder="Search keyword and hit enter...">
            </form>
        </div>
    </div>
    <div class="container">
        <div class="d-flex align-items-center justify-content-between">
            <div class="logo">
                <div class="site-logo">
                    <a href="index.jsp" class="js-logo-clone">EmpowHer</a>
                </div>
            </div>
            <div class="main-nav d-none d-lg-block">
                <nav class="site-navigation text-right text-md-center" role="navigation">
                    <ul class="site-menu js-clone-nav d-none d-lg-block">
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="store.jsp">Store</a></li>
                        <li><a href="#category">Category</a></li>
                        <li><a href="about.jsp">About</a></li>
                        <li><a href="contact.jsp">Contact</a></li>
                <% if(session.getAttribute("uid")==null &&
                		session.getAttribute("uid")==null &&
                		session.getAttribute("uid")==null &&
                		session.getAttribute("uid")==null){%>
                		<li><a href="login.jsp">Login</a></li>
                <%}%>
                <% if(session.getAttribute("uid")!=null){%>
		                <li><a href="view-profile.jsp">Profile</a></li>
		                <li><a href="track-orders.jsp">My Orders</a></li>
                <%}%>
                        
                    </ul>
                </nav>
            </div>
<%@page import="java.sql.*" %>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/empowher","root","");
%>            
            <div class="icons">
                <a href="#" class="icons-btn d-inline-block js-search-open"><span class="icon-search"></span></a>
                <%
                	if(session.getAttribute("uid")!=null){
                		ResultSet cartcount = con2.createStatement().executeQuery("select count(*) from cart where cust_id="+session.getAttribute("uid"));
                		cartcount.next();
                		int count = cartcount.getInt(1);
                		
                %>
                <a href="cart.jsp" class="icons-btn d-inline-block bag">
                    <span class="icon-shopping-bag"></span>
					<span class="number"><%=count%></span>
                </a>
                <a href='logout.jsp' class=' icons-btn d-inline-block '><span class='icon-sign-out'></span></a>                
                <%
                    } 
                %>
                <a href="" class="site-menu-toggle js-menu-toggle ml-3 d-inline-block d-lg-none"><span class="icon-menu"></span></a>
            </div>
        </div>
    </div>
</div>