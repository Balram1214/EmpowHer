package com;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.sql.*;
 
@WebServlet("/AddProductServlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
                 maxFileSize=1024*1024*10,      // 10MB
                 maxRequestSize=1024*1024*50)   // 50MB
public class AddProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession(true);
		try{
			String appPath = request.getServletContext().getRealPath("/");
	
		    Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/empowher","root","");
		
		    String cid = request.getParameter("cid");    
		    String name = request.getParameter("name");    
		    String price = request.getParameter("price");
		    String disc = request.getParameter("disc");
		    String shipping = request.getParameter("shipping");
		    String months = request.getParameter("months");
		    String qty = request.getParameter("qty");
		    String sid = session.getAttribute("sid").toString();

		    String image1="";
		    	    
		    for (Part part : request.getParts()) {
		    	String fileName = extractFileName(part);
	
			    if(!fileName.equals("")){
			    	image1 = fileName;
			    	part.write(appPath + "images/products/"+image1);
			    }
		    }

		    PreparedStatement ps = con.prepareStatement("insert into products(category_id, prod_name, prod_price, prod_discount, prod_photo, prod_stock_qty, prod_shipping, seller_id) values(?, ?, ?, ?, ?, ?, ?, ?)");
		    ps.setString(1, cid);
		    ps.setString(2, name);
		    ps.setString(3, price);
		    ps.setString(4, disc);
		    ps.setString(5, image1);
		    ps.setString(6, qty);
		    ps.setString(7, shipping);
		    ps.setString(8, sid);
		    
		    ps.executeUpdate();
		    out.print("<script>alert('Product Added Successfully');</script>");
		    out.print("<script>window.location.href='seller-manage-products.jsp'</script>");
		}
		catch(Exception e){
			out.println("<h4>"+e+"</h4>");
		}	
    }
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length()-1);
            }
        }
        return "";
    }
}
