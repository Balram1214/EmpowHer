<%@page import="java.util.*"%>
<%@include file="head.jsp"%>
<%@include file="db-connect.jsp"%>

<%
	if(session.getAttribute("uid")==null){
		response.sendRedirect("index.jsp");
		return;
	}
	if(request.getParameter("delete")!=null){
		con.createStatement().executeUpdate("delete from cart where id="+request.getParameter("delete"));
	}
%>

<body>
  <div class="site-wrap">
	<%@include file="header.jsp"%>
    <div class="bg-light py-3">
      <div class="container">
        <div class="row">
          <div class="col-md-12 mb-0">
            <a href="index.jsp">Home</a> <span class="mx-2 mb-0">/</span>
            <strong class="text-black">Cart</strong>
          </div>
        </div>
      </div>
    </div>

    <div class="site-section">
      <div class="container">
        <div class="row mb-5">
          <form action="cart.jsp" class="col-md-12" method="post">
            <div class="site-blocks-table">
              <table class="table table-bordered">
                <thead>
                  <tr>
                    <th class="product-thumbnail">Image</th>
                    <th class="product-name">Product</th>
                    <th class="product-price">Price</th>
                    <th class="product-quantity">Discount(%)</th>
                    <th class="product-quantity">Quantity</th>
                    <th class="product-quantity">Shipping</th>
                    <th class="product-total">Total</th>
                    <th class="product-remove">Remove</th>
                  </tr>
                </thead>
                <tbody>
                  <%
                  ResultSet rs1 = con.createStatement().executeQuery("select count(*) from cart where cust_id="+session.getAttribute("uid"));
                  rs1.next();
                  int n = rs1.getInt(1);
                  if (n>0) {
                	  ResultSet rscart = con.createStatement().executeQuery("select * from cart where cust_id="+session.getAttribute("uid"));
                	  float tot = 0;
                	  
                    while(rscart.next()) {
                    	
                    	ResultSet rs = con.createStatement().executeQuery("select prod_id, prod_photo, prod_stock_qty, prod_shipping, category_name, prod_name, prod_price, prod_discount, prod_mfg_date, prod_months, seller.seller_id, seller_name, seller_business_name from products, category, seller where products.category_id = category.category_id and products.seller_id = seller.seller_id and prod_is_verified = 1 and prod_id="+rscart.getInt("prod_id"));
              			rs.next();
              			
              			float amt = rs.getFloat("prod_price") * rscart.getInt("prod_qty");
              			amt = amt - amt * rs.getFloat("prod_discount")/100 +rs.getInt("prod_shipping");
              			tot += amt;
                  %>
                        <tr>
                          <td class="product-thumbnail"><img src='images/products/<%=rs.getString("prod_photo")%>' alt="Image" class="img-fluid"></td>
                          <td class="product-name"><h2 class="h5 text-black"><%=rs.getString("prod_name")%></h2></td>
                          <td>&#8377; <%=rs.getString("prod_price")%></td>
                          <td><%=rs.getString("prod_discount")%></td>
                          <td><%=rscart.getInt("prod_qty")%></td>
                          <td>&#8377; <%=rs.getString("prod_shipping")%></td>
                          <td>&#8377; <%=amt%></td>
                          <td><a href='cart.jsp?delete=<%=rscart.getInt(1)%>' class="btn btn-primary height-auto btn-sm" onclick="return confirm('Delete from cart?')">Delete</a></td>
                        </tr>
                        <%} %>
                </tbody>
              </table>
            </div>
          </form>
        </div>

        <div class="row">
          <div class="col pl-5">
            <div class="row justify-content-end">
              <div class="col">
                <div class="row">
                  <div class="col-md-12 text-center border-bottom mb-5">
                    <h3 class="text-black h4 text-uppercase">Cart Totals</h3>
                  </div>
                </div>
                <div class="row mb-3">
                  <div class="col-md-6">
                    <span class="text-black"></span>
                  </div>

                  <div class="col-md-6 text-right">
                    <%                    
                    	rscart = con.createStatement().executeQuery("select * from cart where cust_id="+session.getAttribute("uid"));
                    	while(rscart.next()) {
                        	ResultSet rs = con.createStatement().executeQuery("SELECT * FROM products WHERE prod_id="+rscart.getInt("prod_id"));
                  			rs.next();
                  			
                  			float amt = rs.getFloat("prod_price") * rscart.getInt("prod_qty");
                  			amt = amt - amt * rs.getFloat("prod_discount")/100;
                  			amt = amt + rs.getFloat("prod_shipping");                 
                    %>
                        <strong class="text-black">&#8377; <%=amt%></strong> <br>
                    <%
                      }
                    %>
                  </div>

                </div>
                <div class="row mb-5">
                  <div class="col-md-6">
                    <span class="text-black font-weight-bold">Total</span>
                  </div>
                  <div class="col-md-6 text-right font-weight-bold">
                    <strong class="text-black">&#8377; <%=tot%></strong>
                  </div>
                </div>

                <div class="row">
                  <div class="col-md-6">
                    <button class="btn btn-outline-primary btn-lg btn-block" onclick="window.location='store.jsp'">Continue Shopping</button>
                  </div>
                  <br> <br>
                  <div class="col-md-6">
                    <button class="btn btn-primary btn-lg btn-block" onclick="window.location='checkout.jsp'">Proceed To Checkout</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  <%


                  } else {
  %>
    <h1 style="text-align: center; color:black; ">Your Cart is empty</h1>
    <img style="width:46rem; margin-left: 330px; margin-bottom:20px;" src="images/nocart.png" alt="">
  <%
                  }
  %>
  <%@include file="footer.jsp"%>
  </div>
</body>

</html>