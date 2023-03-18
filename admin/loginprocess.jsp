<%!
 public static String encrypt(String x) throws Exception {
    java.security.MessageDigest d = null;
    d = java.security.MessageDigest.getInstance("SHA-1");
    d.reset();
    d.update(x.getBytes());
    return byteToHex(d.digest());
  }
private static String byteToHex(final byte[] hash)
{
    Formatter formatter = new Formatter();
    for (byte b : hash)
    {
        formatter.format("%02x", b);
    }
    String result = formatter.toString();
    formatter.close();
    return result;
}  
%>
<%
 Boolean isLogged= (Boolean)session.getAttribute("is_logged");
if(isLogged)
  {
      out.print("Bạn đã đăng nhập trước đó (!) click <a href='logout.jsp'>vào đây</a> để đăng xuất");
    return;
  } 
%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*, com.mysql.jdbc.Driver"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%
    String id = request.getParameter("id");
    String passWord = request.getParameter("password");
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
             
                    String sql ="SELECT * FROM user WHERE user_name=? and pass_word=?";
                    PreparedStatement pst = conn.prepareStatement(sql);
                    pst.setString(1, id);                   
                    pst.setString(2, encrypt(passWord));
                    ResultSet rs = pst.executeQuery();
                    if (rs.next() == false) 
                    {
                       out.println("<h3 style='color:red'>Sai ID hoặc mật khẩu</h3>"); 
                    }
                     else {
                       session.setAttribute("is_logged", true);
                        String site = new String("index.jsp");
                        response.setStatus(response.SC_MOVED_TEMPORARILY);
                        response.setHeader("Location", site);  
                        /*out.print("<table border='1'>");
                    out.print("<thead><tr><th>ID</th><th>PASSWORD</th></tr></thead>");
                    out.print("<tbody>");
                        do {                  
                            out.print("<tr><td>"+rs.getString("user_name")+"</td><td>"+rs.getString("pass_word")+"</td></tr>");
                        }
                    while(rs.next());                    
                    out.print("</tbody>");
                    out.print("</table>");*/
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