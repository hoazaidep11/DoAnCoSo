<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*, com.mysql.jdbc.Driver"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%
	//CONNECT DATABASE
    String driverName="com.mysql.jdbc.Driver";

        String userName="root";

        String userPasswd="";

        String dbName="jsp_news";

        String tableName="user";

        String url="jdbc:mysql://localhost:3306/"+dbName;
    
    try
    {
       Class.forName(driverName).newInstance();
		Connection conn=DriverManager.getConnection(url, userName, userPasswd);
        if(conn != null)
        {
             
                    String sql ="SELECT * FROM category ORDER BY last_update DESC";
                    PreparedStatement pst = conn.prepareStatement(sql);                   
                    ResultSet rs = pst.executeQuery();
                    if (rs.next() == false) 
                    {
                       out.println("<h3 style='color:red'>Chưa có dữ liệu</h3>"); 
                    }
                     else {
                       session.setAttribute("is_logged", true);
                        String site = new String("index.jsp");
                        response.setStatus(response.SC_MOVED_TEMPORARILY);
                        response.setHeader("Location", site);  
                        out.print("<h3>Danh sách chuyên mục</h3><table border='1' class='table table-bordered'>");
                    out.print("<thead><tr><th>ID</th><th>Tên</th><th>Alias</th><th>Trạng thái</th><th>Cập nhật</th><th>Quản trị</th></tr></thead>");
                    out.print("<tbody>");
						String linkCommand = "";
                        do {                  
                            linkCommand = "<a href='category.jsp?action=edit_item&id="+rs.getString("id")+"' title='Sửa' class='text text-warning'><i class='bi bi-pencil'></i></a>";
							linkCommand += "<a href='category.jsp?action=delete_item&id="+rs.getString("id")+"' title='Xóa' class='text text-danger'><i class='bi bi-x'></i></a>";
							out.print("<tr><td>"+rs.getString("id")+"</td><td>"+rs.getString("name")+"</td><td>"+rs.getString("slug")+"</td><td>"+rs.getString("status")+"</td><td>"+rs.getString("last_update")+"</td><td>"+linkCommand+"</td></tr>");
                        }
                    while(rs.next());                    
                    out.print("</tbody>");
                    out.print("</table>");
                    }
        }
          else
      {
           out.print("<h3 style='color:yellow'>Unable to connect to database.</h3>");
      }
    }
   catch(Exception e){
               out.print("<h3 style='color:red'>Unable to connect to database.</h3>");
                out.print("<h3 style='color:red'>My ERROR : "+e+"</h3>");
                System.out.println("Unable to connect : "+e);
            }
%>