<%
	session.removeAttribute("aid");
	session.removeAttribute("sid");
	session.removeAttribute("uid");
	session.removeAttribute("iid");
	session.invalidate();
	response.sendRedirect("index.jsp");
%>
