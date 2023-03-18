<%
 Boolean isLogged= (Boolean)session.getAttribute("is_logged");
	if(isLogged == null)
	{
		 session.setAttribute("is_logged", false);
		String site = new String("login.jsp");
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", site); 
		return;
	}
	else if(!isLogged)
  {
	String site = new String("login.jsp");
	response.setStatus(response.SC_MOVED_TEMPORARILY);
	response.setHeader("Location", site); 
	return;
  } 
%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.io.*,java.util.*, java.text.*, java.sql.*, com.mysql.jdbc.Driver"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%
	String action = request.getParameter("action");
	String id = request.getParameter("id");
	String[] actionList = {"view_list", "add_item", "add_item_process", "edit_item", "edit_item_process", "delete_item"}; 	
	int n = actionList.length;
	int finded = 0;
	for(int i = 0; i < n; i++)
	{		
		if(actionList[i].equals(action))
		{
			finded = 1;
			break;
		}
	}
	if(finded < 1)
	{
		out.print("Invalid action");
		return;
	}
	String editName = "";
	String editStatus = "";
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
             if(action.equals("add_item_process"))
			{
				String name = request.getParameter("name");
				String slug;
				slug = name;				
				 String[] unicodeArt = {
                    "[(à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)]",
                    "[(è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)]",
                    "[(ì|í|ị|ỉ|ĩ)]",
                    "[(ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)]",
                    "[(ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)]",
                    "[(ỳ|ý|ỵ|ỷ|ỹ)]",
                    "[(đ)]",
                    "[(À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ)]",
                    "[(È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ)]",
                    "[(Ì|Í|Ị|Ỉ|Ĩ)]",
                    "[(Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ)]",
                    "[(Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ)]",
                    "[(Ỳ|Ý|Ỵ|Ỷ|Ỹ)]",
                    "[(Đ)]"
				 } ;
                String[] replaceArt = {
                    "a",
                    "e",
                    "i",
                    "o",
                    "u",
                    "y",
                    "d",
                    "A",
                    "E",
                    "I",
                    "O",
                    "U",
                    "Y",
                    "D"                    
				} ;
				n = unicodeArt.length;
				for(int i = 0; i < n; i++)
				{
					slug = slug.replaceAll(unicodeArt[i], replaceArt[i]);
				}
				slug = slug.replaceAll(" ", "-");
				slug = slug.toLowerCase();
				String status = request.getParameter("status");
				if(status == null)
				{
					status = "0";
				}
				int setStatus = Integer.parseInt(status);						
				java.util.Date date = new java.util.Date();
				Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String strDate = formatter.format(date);
				
				//CHECK EXITS			
				String sql ="SELECT * FROM category WHERE name=? or slug=?";
				PreparedStatement pst = conn.prepareStatement(sql);
				pst.setString(1, name);                   
				pst.setString(2, slug);
				ResultSet rs = pst.executeQuery();
				if (rs.next() == false) 
				{
					sql ="INSERT INTO category (name, slug, status, last_update) VALUES('"+name+"', '"+slug+"', '"+setStatus+"', '"+strDate+"') ";
					pst = conn.prepareStatement(sql);
					pst.execute();
					String site = new String("category.jsp?action=view_list");
					response.setStatus(response.SC_MOVED_TEMPORARILY);
					response.setHeader("Location", site); 
					return;
				}
				else
				{
					out.print("<h3 style='color:red'>Dữ liệu đã tồn tại</h3>");
					return;
				}				
			}      
            else if(action.equals("edit_item"))
			{
				if(id == null)
				{
					out.print("Thiếu tham số");	
					return;
				}
				//GET DATA FROM DATABASE
				String sql ="SELECT * FROM category WHERE id=?";
				PreparedStatement pst = conn.prepareStatement(sql);
				pst.setString(1, id);                   
				
				ResultSet rs = pst.executeQuery();
				if (rs.next() == false) 
				{
					out.print("<h3 style='color:red'>Dữ liệu không tồn tại</h3>");
					return;
				}
				else
				{
					do
					{
						editName = rs.getString("name");
						editStatus = rs.getString("status");
					}
					 while(rs.next());       
				}
			}
			if(action.equals("edit_item_process"))
			{
				String editID = (String)session.getAttribute("editCategoryID");
				if(editID == null)
				{
					out.print("Phiên làm việc đã hết");
					return;
				}
				int upd_id = Integer.parseInt(editID);
				String name = request.getParameter("name");
				String slug;
				slug = name;				
				 String[] unicodeArt = {
                    "[(à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)]",
                    "[(è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)]",
                    "[(ì|í|ị|ỉ|ĩ)]",
                    "[(ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)]",
                    "[(ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)]",
                    "[(ỳ|ý|ỵ|ỷ|ỹ)]",
                    "[(đ)]",
                    "[(À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ)]",
                    "[(È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ)]",
                    "[(Ì|Í|Ị|Ỉ|Ĩ)]",
                    "[(Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ)]",
                    "[(Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ)]",
                    "[(Ỳ|Ý|Ỵ|Ỷ|Ỹ)]",
                    "[(Đ)]"
				 } ;
                String[] replaceArt = {
                    "a",
                    "e",
                    "i",
                    "o",
                    "u",
                    "y",
                    "d",
                    "A",
                    "E",
                    "I",
                    "O",
                    "U",
                    "Y",
                    "D"                    
				} ;
				n = unicodeArt.length;
				for(int i = 0; i < n; i++)
				{
					slug = slug.replaceAll(unicodeArt[i], replaceArt[i]);
				}
				slug = slug.replaceAll(" ", "-");
				slug = slug.toLowerCase();
				String status = request.getParameter("status");
				if(status == null)
				{
					status = "0";
				}
				int setStatus = Integer.parseInt(status);						
				java.util.Date date = new java.util.Date();
				Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String strDate = formatter.format(date);
				String sql ="UPDATE category SET name = ?, slug = ?, status=?, last_update=? WHERE id = ?";
				PreparedStatement pst = conn.prepareStatement(sql);
				pst.setString(1, name);                   
				pst.setString(2, slug);
				pst.setInt(3, setStatus);                   
				pst.setString(4, strDate);
				pst.setInt(5, upd_id);
				pst.executeUpdate();
				 session.removeAttribute("editCategoryID");
				String site = new String("category.jsp?action=view_list");
				response.setStatus(response.SC_MOVED_TEMPORARILY);
				response.setHeader("Location", site); 
				return;				
			}
			if(action.equals("delete_item"))
			{
				if((id == null) || id.isEmpty())
				{
					out.print("No parameter");
					return;
				}
				String sql ="DELETE category WHERE id = ?";
				PreparedStatement pst = conn.prepareStatement(sql);
				pst.setString(1, id);  
				ResultSet rs = pst.executeQuery();
				//DELETE ALL POST
				sql ="DELETE content WHERE category = ?";
				pst = conn.prepareStatement(sql);
				pst.setString(1, id);  
				ResultSet deletePost = pst.executeQuery();				
				String site = new String("category.jsp?action=view_list");
				response.setStatus(response.SC_MOVED_TEMPORARILY);
				response.setHeader("Location", site); 
				return;				
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
<jsp:include page="header.jsp" /> 
<div class="col-lg-9 col-md-9">	
	<% 
	if(action.equals("view_list"))
	{%>
		<jsp:include page="category_list.jsp" />  
	<%}%>
	<% 
	if(action.equals("add_item"))
	{%>
		<jsp:include page="add_category_tpl.jsp" />  
	<%}%>
	<% 
	if(action.equals("edit_item"))
	{
		session.setAttribute("editCategoryID", id);
		request.setCharacterEncoding("UTF-8");
		%>
		<jsp:include page="edit_category_tpl.jsp" >  
		 <jsp:param name="name" value="<%=editName%>" />
		 <jsp:param name="status" value="<%=editStatus%>" />
		</jsp:include>
	<%}%>
</div>
<jsp:include page="footer.jsp" />  
