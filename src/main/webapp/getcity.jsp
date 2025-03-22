<%@include file="db-connect.jsp"%>

<select name="city" class="form-control" required>
<option value="">Select City</option>
<%
	ResultSet rscity = con.createStatement().executeQuery("select * from city_state where state_name='"+request.getParameter("s")+"'");
	while(rscity.next()){
%>
<option value='<%=rscity.getString("city_name")%>'><%=rscity.getString("city_name")%></option>
<%
	}
%>
</select>