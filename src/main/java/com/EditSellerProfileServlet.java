package com;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.sql.*;
 
@WebServlet("/EditSellerProfileServlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
                 maxFileSize=1024*1024*10,      // 10MB
                 maxRequestSize=1024*1024*50)   // 50MB
public class EditSellerProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession(true);
		try{
			String appPath = request.getServletContext().getRealPath("/");
	
		    Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/empowher","root","");
		
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String contact = request.getParameter("contact");
			String addr = request.getParameter("addr");
			String aboutus = request.getParameter("aboutus");
			String bname = request.getParameter("bname");
		    String sid = session.getAttribute("sid").toString();

			String sql = "SELECT * FROM seller WHERE seller_email='"+email+"' and seller_id<>"+sid;
			ResultSet rs = con.createStatement().executeQuery(sql);

			if(rs.next()) {
				out.print("<script>alert('Seller email already associated with some other account');</script>");
			} 
			else{
				PreparedStatement ps = con.prepareStatement("update seller set seller_name=?, seller_phone=?, seller_email=?, seller_business_name=?, seller_address=?, seller_about_us=? where seller_id=?");				
				ps.setString(1, name);
				ps.setString(2, contact);
				ps.setString(3, email);
				ps.setString(4, bname);
				ps.setString(5, addr);
				ps.setString(6, aboutus);
				ps.setString(7, sid);
				ps.executeUpdate();
				out.print("<script>alert('Seller profile updated successfully');</script>");
			}

		    String image1="";
		    	    
		    for (Part part : request.getParts()) {
		    	String fileName = extractFileName(part);
	
			    if(!fileName.equals("")){
			    	image1 = fileName;
			    	part.write(appPath + "images/seller/"+image1);
			    }
		    }

		    if(image1.length()>0) {
		    	con.createStatement().executeUpdate("update seller set seller_photo='"+image1+"' where seller_id="+sid);
		    }
		    
		    out.print("<script>window.location.href='seller-profile.jsp'</script>");
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
