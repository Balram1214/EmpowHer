<%@include file="head.jsp"%>
<body>
 	<div class="site-wrap">
		<%@include file="header.jsp"%>
    	<div class="site-blocks-cover" style="background-image: url('images/hero_1.jpg');">
      		<div class="container">
        		<div class="row">
          			<div class="col-lg-7 mx-auto order-lg-2 align-self-center">
            			<div class="site-block-cover-content text-center">
              				<h2 class="sub-title" style="color: white; font-weight: bold;">Effective Cosmetics, New Snacks Products Everyday</h2>
              				<h1 style="color: orange;">Welcome To EmpowHer</h1>
              				<p>
                				<a href="store.jsp" class="btn btn-primary">Shop Now</a>
              				</p>
            			</div>
          			</div>
        		</div>
      		</div>
    	</div>

    <div class="site-section">
      <div class="container">
        <div class="row align-items-stretch section-overlap">
          <div class="col-md-6 col-lg-4 mb-4 mb-lg-0">
            <div class="banner-wrap bg-primary h-100">
              <a href="#" class="h-100">
                <h5>Free <br> Shipping</h5>
                <p>
                  &#8377;0 charge for all your orders delivery
                  <strong>for Orders above &#8377;199.</strong>
                </p>
              </a>
            </div>
          </div>
          <div class="col-md-6 col-lg-4 mb-4 mb-lg-0">
            <div class="banner-wrap h-100">
              <a href="#" class="h-100">
                <h5>Season <br> Sale 50% Off</h5>
                <p>
                  Up to 80% off on cosmetics.

                </p>
              </a>
            </div>
          </div>
          <div class="col-md-6 col-lg-4 mb-4 mb-lg-0">
            <div class="banner-wrap bg-warning h-100">
              <a href="#" class="h-100">
                <h5>New <br> Products</h5>
                <p>
                  Explore more than 10,000 products.
                </p>
              </a>
            </div>
          </div>

        </div>
      </div>
    </div>

    <div class="site-section">
      <div class="container">
        <div class="row">
          <div class="title-section text-center col-12">
            <h2 class="text-uppercase">Products You Might Like</h2>
          </div>
        </div>

        <div class="row">
        	<%@include file="db-connect.jsp"%>
        	
        	<%
        		ResultSet rs = con.createStatement().executeQuery("select * from products order by prod_id and prod_is_verified=1");
               int i=0;
                while(rs.next()){
        	%>
            <div class="col-sm-6 col-lg-4 text-center item mb-4">
              <a href='product.jsp?prod_id=<%=rs.getInt("prod_id")%>'> <img class="rounded mx-auto d-block" style="width:20vw ; height:40vh ;" src='images/products/<%=rs.getString("prod_photo")%>' alt="Image"></a>
              <% if (rs.getString("prod_name").length()<=20) { %>
                <h5 class="text-dark"><a href='product.jsp?prod_id=<%=rs.getInt("prod_id")%>'><%=rs.getString("prod_name")%></a></h5>
              <% 
              } else {
              %>
                <h5 class="text-dark"><a href='product.jsp?prod_id=<%=rs.getInt("prod_id")%>'><%=rs.getString("prod_name").substring(0, 20) + "..." %></a></h5>
              <%
              }
              %>
              <p class="price">&#8377;<%=rs.getString("prod_price")%></p>
            </div>
          <% 
            if (i == 5) {
              break;
            }
          	i++;
          }
          %>
        </div>
        <div class="row mt-5">
          <div class="col-12 text-center">
            <a href="store.jsp" class="btn btn-primary px-4 py-3">View All Products</a>
          </div>
        </div>
      </div>
    </div>


    <div class="site-section bg-light">
      <div class="container">
        <div class="row">
          <div class="title-section text-center col-12">
            <h2 class="text-uppercase">New Products</h2>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 block-3 products-wrap">
            <div class="nonloop-block-3 owl-carousel">
        	<%
        		rs = con.createStatement().executeQuery("select * from products where prod_is_verified=1 order by prod_id desc");
               i=0;
                while(rs.next()){
        	%>
            <div class="col-sm-4 col-lg-4 text-center item mb-2">
              <a href='product.jsp?prod_id=<%=rs.getInt("prod_id")%>'> <img class="rounded mx-auto d-block" style="width:20vw ; height:40vh ;" src='images/products/<%=rs.getString("prod_photo")%>' alt="Image"></a>
              <% if (rs.getString("prod_name").length()<=20) { %>
                <h5><a href='product.jsp?prod_id=<%=rs.getInt("prod_id")%>'><%=rs.getString("prod_name")%></a></h5>
              <% 
              } else {
              %>
                <h5><a href="product.jsp?prod_id=<%=rs.getInt("prod_id")%>"><%=rs.getString("prod_name").substring(0, 20) + "..." %></a></h5>
              <%
              }
              %>
              <p class="price">&#8377;<%=rs.getString("prod_price")%></p>
            </div>
          <% 
            if (i == 5) {
              break;
            }
          	i++;
          }
          %>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="site-section">
      <div class="container">
        <div class="row">
          <div class="title-section text-center col-12">
            <h2 class="text-uppercase">Testimonials</h2>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 block-3 products-wrap">
            <div class="nonloop-block-3 no-direction owl-carousel">

              <div class="testimony">
                <blockquote>
                  <img src="images/person_1.jpg" alt="Image" class="img-fluid w-25 mb-4 rounded-circle">
                  <p>&ldquo;EmpowHer service during COVID 19 is magnificent. It gives good discounts than
                    local shops. The Web site is very simple to choose and the service is very much
                    proficient and prompt. Pretty satisfied with the service. Good Part is you need not
                    spend huge bucks on local shops which is other big relief. Way
                    to GO.&rdquo;</p>
                </blockquote>

                <p>&mdash; Mrs. Smriti Irani</p>
              </div>

              <div class="testimony">
                <blockquote>
                  <img src="images/person_2.jpg" alt="Image" class="img-fluid w-25 mb-4 rounded-circle">
                  <p>&ldquo;As an NRI for me personally EmpowHer offers a great relief in getting cosmetics
                    for my family from finger tip without any hassles all the time with very limited lead
                    time on all orders. Very happy to be a customer and surely recommend it to all those
                    require cosmetics in reasonable cost and routine basis.&rdquo;</p>
                </blockquote>

                <p>&mdash; Mrs. Sushma Swaraj</p>
              </div>

              <div class="testimony">
                <blockquote>
                  <img src="images/person_3.jpg" alt="Image" class="img-fluid w-25 mb-4 rounded-circle">
                  <p>&ldquo;Now I became customer of EmpowHer. Every time I ordering the household things on EmpowHer.
                  	It is very helpful website in online shopping for everydy products. Its delivering service is
                    very fast, and packing also very good. If by mistake any product is wrong delivered then easily
                    returns to this web-store. Its customer service is very good.&rdquo;</p>
                </blockquote>

                <p>&mdash; Mr. Amitabh Bacchan</p>
              </div>

              <div class="testimony">
                <blockquote>
                  <img src="images/person_4.jpg" alt="Image" class="img-fluid w-25 mb-4 rounded-circle">
                  <p>&ldquo;I would like to thanks EmpowHer for their brilliant Customer Service. I ordered
                    household items from EmpowHer and they delivered my products within 3 days. Keep it up the
                    good work. EmpowHer is the best household app. I recommend everyone to use EmpowHer
                    Website.&rdquo;</p>
                </blockquote>

                <p>&mdash; Mr. Narendra Modi</p>
              </div>

              <div class="testimony">
                <blockquote>
                  <img src="images/person_5.jpg" alt="Image" class="img-fluid w-25 mb-4 rounded-circle">
                  <p>&ldquo;I always buy all my cosmetics from SKICARE only. They have wide range of cosmetics from head to toe. Their body care products are amazing. Thank you.&rdquo;</p>
                </blockquote>

                <p>&mdash; Mrs. Aishwarya Rai Bacchan</p>
              </div>

            </div>
          </div>
        </div>
      </div>
      
    <div class="site-section">
      <div class="container">
        <div class="row">
          <div class="title-section text-center col-12">
            <h2 class="text-uppercase">Our Women Entrepreneurs</h2>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 block-3 products-wrap">
            <div class="nonloop-block-3 no-direction owl-carousel">

<%
	ResultSet rsseller = con.createStatement().executeQuery("select * from seller");
	while(rsseller.next()){
%>

              <div class="testimony">
                <blockquote>
                  <img src='images/seller/<%=rsseller.getString("seller_photo")%>' alt="Image" class="img-fluid w-25 mb-4 rounded-circle">
                  <h2><a href='store.jsp?seller=<%=rsseller.getString("seller_id")%>' title="Click to view products"><%=rsseller.getString("seller_business_name")%></a></h2>
                  <p>&ldquo;<%=rsseller.getString("seller_about_us") %>&rdquo;</p>
                </blockquote>

                <p>&mdash; <%=rsseller.getString("seller_name") %></p>
              </div>

<%	} %>
            </div>
          </div>
        </div>
      </div>
      

    <div class="site-section" id="category">
      <div class="container">
        <div class="row">
          <div class="title-section text-center col-12">
            <h2 class="text-uppercase">Shop by category</h2>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 block-3 products-wrap">
            <div class="nonloop-block-3 no-direction owl-carousel">

<%
	ResultSet rscategory = con.createStatement().executeQuery("select * from category");
	while(rscategory.next()){
%>

              <div class="testimony">
                <blockquote>
                  <h2><a href='store.jsp?cat=<%=rscategory.getString("category_id")%>' title="Click to view products"><%=rscategory.getString("category_name")%></a></h2>
                  <p>&ldquo;<%=rscategory.getString("category_description") %>&rdquo;</p>
                </blockquote>
              </div>

<%	} %>
            </div>
          </div>
        </div>
      </div>

      
    </div>
	<%@include file="footer.jsp"%>
  </div>
</body>
</html>