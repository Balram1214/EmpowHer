package com;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.sql.*;
 
@WebServlet("/EditInvestorProfileServlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
                 maxFileSize=1024*1024*10,      // 10MB
                 maxRequestSize=1024*1024*50)   // 50MB
public class EditInvestorProfileServlet extends HttpServlet {
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
		    String iid = session.getAttribute("iid").toString();

			String sql = "SELECT * FROM investor WHERE investor_email='"+email+"' and investor_id<>"+iid;
			ResultSet rs = con.createStatement().executeQuery(sql);

			if(rs.next()) {
				session.setAttribute("err", "Investor email already associated with some other account");
			} 
			else{
				PreparedStatement ps = con.prepareStatement("update investor set investor_name=?, investor_phone=?, investor_email=?, investor_business_name=?, investor_address=?, investor_about_us=? where investor_id=?");				
				ps.setString(1, name);
				ps.setString(2, contact);
				ps.setString(3, email);
				ps.setString(4, bname);
				ps.setString(5, addr);
				ps.setString(6, aboutus);
				ps.setString(7, iid);
				
				if(ps.executeUpdate()>0){
					session.setAttribute("succ", "Profile updated successfully");
				}
				else{
					session.setAttribute("err", "Something went wrong");
				}
			}

		    String image1="";
		    	    
		    for (Part part : request.getParts()) {
		    	String fileName = extractFileName(part);
	
			    if(!fileName.equals("")){
			    	image1 = fileName;
			    	part.write(appPath + "images/investor/"+image1);
			    }
		    }

		    if(image1.length()>0) {
		    	con.createStatement().executeUpdate("update investor set investor_photo='"+image1+"' where investor_id="+iid);
		    }
		    out.print("<script>window.location.href='investor-profile.jsp'</script>");
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
