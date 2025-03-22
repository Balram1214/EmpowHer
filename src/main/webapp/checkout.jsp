<%@include file="db-connect.jsp"%>

<%
	if(session.getAttribute("uid")==null){
		response.sendRedirect("index.jsp");
		return;
	}
%>

<html>
	<head>
		<title>Checkout</title>
		<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<link href="css/checkout.css" rel="stylesheet" id="bootstrap-css">
		<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
		<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>		
	</head>
	<body>
		<div class="container wrapper">
            <div class="row cart-head">
                <div class="container">
                <div class="row">
                    <p></p>
                </div>
                <div class="row">
                    <div style="display: table; margin: auto;">
                        <span class="step step_complete"> <a href="cart.jsp" class="check-bc">Cart</a> <span class="step_line step_complete"> </span> <span class="step_line backline"> </span> </span>
                        <span class="step step_complete"> <a href="checkout.jsp" class="check-bc">Checkout</a> <span class="step_line "> </span> <span class="step_line step_complete"> </span> </span>
                        <span class="step_thankyou check-bc step_complete">Thank you</span>
                    </div>
                </div>
                <div class="row">
                    <p></p>
                </div>
                </div>
            </div>    
            <div class="row cart-body">
                <form class="form-horizontal" method="post" action="checkout1.jsp">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 col-md-push-6 col-sm-push-6">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            Review Order <div class="pull-right"></div>
                        </div>
                        <div class="panel-body">
<%
ResultSet rscart = con.createStatement().executeQuery("select * from cart where cust_id="+session.getAttribute("uid"));
float tot = 0;
float shipping = 0;
while(rscart.next()) {
	
	ResultSet rs = con.createStatement().executeQuery("select prod_id, prod_photo, prod_stock_qty, prod_shipping, category_name, prod_name, prod_price, prod_discount, prod_mfg_date, prod_months, seller.seller_id, seller_name, seller_business_name from products, category, seller where products.category_id = category.category_id and products.seller_id = seller.seller_id and prod_is_verified = 1 and prod_id="+rscart.getInt("prod_id"));
	rs.next();
	
	float amt = rs.getFloat("prod_price") * rscart.getInt("prod_qty");
	amt = amt - amt * rs.getFloat("prod_discount")/100;
	shipping += rs.getInt("prod_shipping");
	tot += amt;
%>
                            <div class="form-group">
                                <div class="col-sm-3 col-xs-3">
                                    <img class="img-responsive" src='images/products/<%=rs.getString("prod_photo")%>' />
                                </div>
                                <div class="col-sm-6 col-xs-6">
                                    <div class="col-xs-12"><%=rs.getString("prod_name")%></div>
                                    <div class="col-xs-12"><small>Quantity:<span><%=rscart.getString("prod_qty")%></span></small></div>
                                </div>
                                <div class="col-sm-3 col-xs-3 text-right">
                                    <h6><span>&#8377;</span><%=amt%></h6>
                                </div>
                            </div>
                            <div class="form-group"><hr /></div>
<%	
	} 
%>
                            <div class="form-group">
                                <div class="col-xs-12">
                                    <strong>Subtotal</strong>
                                    <div class="pull-right"><span>&#8377;</span><span><%=tot%></span></div>
                                </div>
                                <div class="col-xs-12">
                                    <small>Shipping</small>
                                    <div class="pull-right"><span><%=shipping%></span></div>
                                </div>
                            </div>
                            <div class="form-group"><hr/></div>
                            <div class="form-group">
                                <div class="col-xs-12">
                                    <strong>Order Total</strong>
                                    <div class="pull-right"><span>&#8377;</span><span><%=tot+shipping%></span></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 col-md-pull-6 col-sm-pull-6">
                    <div class="panel panel-info">
                        <div class="panel-heading">Address</div>
                        <div class="panel-body">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <h4>Shipping Address</h4>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-6 col-xs-12">
                                    <strong>First Name:</strong>
                                    <input type="text" name="first_name" class="form-control" value="" required/>
                                </div>
                                <div class="span1"></div>
                                <div class="col-md-6 col-xs-12">
                                    <strong>Last Name:</strong>
                                    <input type="text" name="last_name" class="form-control" value="" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12"><strong>Address:</strong></div>
                                <div class="col-md-12">
                                    <input type="text" name="address" class="form-control" value="" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12"><strong>State:</strong></div>
                                <div class="col-md-12">
                                    <select name="state" class="form-control" required onchange="show(this.value)">
                                    <option value="">Select State</option>
<%
	ResultSet rsstate = con.createStatement().executeQuery("select distinct state_name from city_state");
	while(rsstate.next()){
%>
									<option value='<%=rsstate.getString("state_name")%>'><%=rsstate.getString("state_name")%></option>
<% 
	}
%>                                    
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12"><strong>City:</strong></div>
                                <div class="col-md-12" id="result">
                                    <select name="city" class="form-control" required>
                                    <option value="">Select City</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12"><strong>Zip / Postal Code:</strong></div>
                                <div class="col-md-12">
                                    <input type="text" name="zip_code" class="form-control" value="" required pattern="^[123456789]\d{5}$"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12"><strong>Phone Number:</strong></div>
                                <div class="col-md-12"><input type="text" name="phone_number" class="form-control" value="" required pattern="^[6789]\d{9}$"/></div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12"><strong>Email Address:</strong></div>
                                <div class="col-md-12"><input type="email" name="email_address" class="form-control" value="" required/></div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-info">
                        <div class="panel-heading"><span><i class="glyphicon glyphicon-lock"></i></span> Secure Payment</div>
                        <div class="panel-body">
                            <div class="form-group">
                                <div class="col-md-12"><strong>Card Type:</strong></div>
                                <div class="col-md-12">
                                    <select id="CreditCardType" name="CreditCardType" class="form-control" required>
                                        <option value="Visa">Visa</option>
                                        <option value="MasterCard">MasterCard</option>
                                        <option value="American Express">American Express</option>
                                        <option value="Discover">Discover</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12"><strong>Credit Card Number:</strong></div>
                                <div class="col-md-12"><input type="text" class="form-control" name="car_number" value="" placeholder="xxxx-xxxx-xxxx-xxxx" required pattern="^\d{4}-\d{4}-\d{4}-\d{4}$"/></div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12"><strong>Card CVV:</strong></div>
                                <div class="col-md-12"><input type="password" class="form-control" name="car_code" value="" placeholder="xxx" maxlength="3" required pattern="^\d{3}$"/></div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <strong>Expiration Date</strong>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                    <select class="form-control" name="exp_month" required>
                                        <option value="">Month</option>
                                        <option value="01">01</option>
                                        <option value="02">02</option>
                                        <option value="03">03</option>
                                        <option value="04">04</option>
                                        <option value="05">05</option>
                                        <option value="06">06</option>
                                        <option value="07">07</option>
                                        <option value="08">08</option>
                                        <option value="09">09</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                </select>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                    <select class="form-control" name="exp_year" required>
                                        <option value="">Year</option>
                                        <option value="2024">2024</option>
                                        <option value="2025">2025</option>
                                        <option value="2024">2026</option>
                                        <option value="2025">2027</option>
                                        <option value="2024">2028</option>
                                        <option value="2025">2029</option>
                                        <option value="2024">2030</option>
                                        <option value="2025">2031</option>
                                        <option value="2024">2032</option>
                                        <option value="2025">2033</option>
                                        <option value="2024">2034</option>
                                        <option value="2025">2035</option>
                                </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <span>Pay secure using your credit card.</span>
                                </div>
                                <div class="col-md-12">
                                    <ul class="cards">
                                        <li class="visa hand">Visa</li>
                                        <li class="mastercard hand">MasterCard</li>
                                        <li class="amex hand">Amex</li>
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <button type="submit" class="btn btn-primary btn-submit-fix">Place Order</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </form>
            </div>
            <div class="row cart-footer"></div>
    	</div>
	</body>
</html>

<script>
	function show(sname){
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				document.getElementById("result").innerHTML = this.responseText;
			}
		};
		xmlhttp.open("GET", "getcity.jsp?s=" + sname, true);
		xmlhttp.send();
	}
</script>