<%@include file="db-connect.jsp"%>

<html>
	<head>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
		<script src="https://use.fontawesome.com/f59bcd8580.js"></script>		
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.all.min.js"></script>
		<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.5/dist/sweetalert2.min.css" rel="stylesheet">		
	</head>
	<body>
<%
	String first_name = request.getParameter("first_name");
	String last_name = request.getParameter("last_name");
	String address = request.getParameter("address");
	String state = request.getParameter("state");
	String city = request.getParameter("city");
	String zip_code = request.getParameter("zip_code");
	String phone_number = request.getParameter("phone_number");
	String email_address = request.getParameter("email_address");

	ResultSet rsid = con.createStatement().executeQuery("SELECT `AUTO_INCREMENT` FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'empowher' AND TABLE_NAME = 'address_info'");
	rsid.next();
	int aid = rsid.getInt(1);
	
	PreparedStatement ps = con.prepareStatement("insert into address_info(firstName, lastName, address, state, city, pincode, phone, email) values(?,?,?,?,?,?,?,?)");
	ps.setString(1, first_name);
	ps.setString(2, last_name);
	ps.setString(3, address);
	ps.setString(4, state);
	ps.setString(5, city);
	ps.setString(6, zip_code);
	ps.setString(7, phone_number);
	ps.setString(8, email_address);
	ps.executeUpdate();
		
	ResultSet rscart = con.createStatement().executeQuery("select * from cart where cust_id="+session.getAttribute("uid"));
	
	while(rscart.next()){
		ps = con.prepareStatement("insert into orders(orderNumber, cust_id, address_id, prod_id, quantity, totalAmount, shipping) values(?,?,?,?,?,?,?)");

		String orderno = Integer.toString(100000 + (int)(Math.random() * ((999999 - 100000) + 1)));

		ResultSet rs = con.createStatement().executeQuery("select prod_id, prod_photo, prod_stock_qty, prod_shipping, category_name, prod_name, prod_price, prod_discount, prod_mfg_date, prod_months, seller.seller_id, seller_name, seller_business_name from products, category, seller where products.category_id = category.category_id and products.seller_id = seller.seller_id and prod_is_verified = 1 and prod_id="+rscart.getInt("prod_id"));
		rs.next();

		float amt = rs.getFloat("prod_price") * rscart.getInt("prod_qty");
		amt = amt - amt * rs.getFloat("prod_discount")/100;
		float shipping = rs.getInt("prod_shipping");
		
		ps.setString(1, orderno);
		ps.setString(2, session.getAttribute("uid").toString());
		ps.setInt(3, aid);
		ps.setInt(4, rscart.getInt("prod_id"));
		ps.setInt(5, rscart.getInt("prod_qty"));
		ps.setFloat(6, amt);
		ps.setFloat(7, shipping);
		ps.executeUpdate();
		
		con.createStatement().executeUpdate("delete from cart where cust_id="+session.getAttribute("uid"));
	}
%>

		<script type="text/javascript">
			Swal.fire({
				title: "Payment Success",
				text: "We have processed your order successfully. Go to My Orders section to track order status.",
				icon: "success"
			}).then(function() {
			    window.location.href = "index.jsp";
			});
		</script>
	</body>
</html>