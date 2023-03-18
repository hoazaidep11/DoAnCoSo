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
<%@ page import = "java.io.*,java.util.*, java.text.*, java.sql.*, com.mysql.jdbc.Driver"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%
	int catNumber = 0;
	int postNumber = 0;
	int slideNumber = 0;	
	//CONNECT DATABASE
	String driverName="com.mysql.jdbc.Driver";

	String userName="root";

	String userPasswd="";

	String dbName="jsp_news";

	String tableName="user";

	String url="jdbc:mysql://localhost:3306/"+dbName+"?useUnicode=true&characterEncoding=UTF-8";
    
    try
    {
		Class.forName(driverName).newInstance();
		Connection conn=DriverManager.getConnection(url, userName, userPasswd);
        if(conn != null)
        {
			String sql ="SELECT count(*) as catNumber FROM category";
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet rs = pst.executeQuery();
			if (rs.next() != false) 
			{
				do
				{
					catNumber = rs.getInt("catNumber");					
				}
				while(rs.next());   
			}	
			
			sql ="SELECT count(*) as postNumber FROM content";
			pst = conn.prepareStatement(sql);
			rs = pst.executeQuery();
			if (rs.next() != false) 
			{
				do
				{
					postNumber = rs.getInt("postNumber");					
				}
				while(rs.next());   
			}	
			
			sql ="SELECT count(*) as slideNumber FROM slide";
			pst = conn.prepareStatement(sql);
			rs = pst.executeQuery();
			if (rs.next() != false) 
			{
				do
				{
					slideNumber = rs.getInt("slideNumber");					
				}
				while(rs.next());   
			}
		}
	}	
	catch(Exception e)
	{
		out.print("<h3 style='color:red'>Unable to connect to database.</h3>");
		out.print("<h3 style='color:red'>My ERROR : "+e+"</h3>");
		System.out.println("Unable to connect : "+e);
    }	
%>

<jsp:include page="header.jsp" /> 
<div class="col-lg-9 col-md-9">	
	<ul class="list-group">
  <li class="list-group-item d-flex justify-content-between align-items-center">
    Chuyên mục
    <span class="badge bg-primary rounded-pill"><%=catNumber%></span>
  </li>
  <li class="list-group-item d-flex justify-content-between align-items-center">
    Bài viết
    <span class="badge bg-primary rounded-pill"><%=postNumber%></span>
  </li>
  <li class="list-group-item d-flex justify-content-between align-items-center">
    Slide
    <span class="badge bg-primary rounded-pill"><%=slideNumber%></span>
  </li>
</ul>
</div>
<jsp:include page="footer.jsp" />  