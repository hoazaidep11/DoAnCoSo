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
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*, com.mysql.jdbc.Driver"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%
    
    String passWord = request.getParameter("password");
    String new_password = request.getParameter("new_password");
    String new_password_conf = request.getParameter("new_password_conf");
    if(passWord.isEmpty() || new_password.isEmpty() || new_password_conf.isEmpty())
    {
        out.print("Bạn chưa điền đủ dữ liệu");
        return;
    }
    if(!new_password.equals(new_password_conf))
    {
        out.print("Mật khẩu mới không khớp trường 'xác nhận mật khẩu mới' ");
        return;
    }
    if(new_password.length() < 8)
    {
        out.print("Mật khẩu mới phải có ít nhất 8 ký tự");
        return;
    }
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
                    pst.setString(1, "admin");                   
                    pst.setString(2, encrypt(passWord));
                    ResultSet rs = pst.executeQuery();
                    if (rs.next() == false) 
                    {
                       out.println("<h3 style='color:red'>Mật khẩu cũ bị sai</h3>"); 
                    }
                     else {
                        sql ="UPDATE user SET pass_word=? WHERE user_name=? and pass_word=?";
                        pst = conn.prepareStatement(sql);
                        pst.setString(1, encrypt(new_password));
                        pst.setString(2, "admin");                   
                        pst.setString(3, encrypt(passWord));
                        int upd = pst. executeUpdate();                       
                        if (upd < 1) 
                        {
                            out.println("<h3 style='color:red'>Lỗi cập nhật dữ liệu</h3>"); 
                        }
                        else
                        {
                             out.println("<h3 style='color:green'>Chúc mừng click <a href='index.jsp'>vào đây</a> để quay lại</h3>"); 
                        }
                        /*String site = new String("index.jsp");
                        response.setStatus(response.SC_MOVED_TEMPORARILY);
                        response.setHeader("Location", site);  */

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