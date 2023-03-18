<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
 Boolean isLogged = (Boolean) session.getAttribute("is_logged");
	if(isLogged == null)
	{
		out.print("<strong>Bạn chưa đăng nhập</strong>");
		out.print("<br>Click <a href='/admin/login.jsp'>vào đây</a> để đăng nhập");
		return;
	}
	else if(isLogged != true)
	{
		out.print("<strong>Bạn chưa đăng nhập</strong>");
		out.print("<br>Click <a href='/admin/login.jsp'>vào đây</a> để đăng nhập");
		return;
	} 
%>
<jsp:include page="header.jsp" /> 
<div class="col-lg-9 col-md-9">	
	<jsp:include page="repass_tpl.jsp" /> 
</div>
<jsp:include page="footer.jsp" />  

