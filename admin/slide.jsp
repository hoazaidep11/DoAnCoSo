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
	String editSlogan = "";
	String editImagePath = "";
	String editObjUrl = "";
	
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
				if(name == null)
				{
					out.print("Tên không được bỏ trống");
					return;
				}
				String slogan = request.getParameter("slogan");	
				String image_path = request.getParameter("image_path");	
				if(image_path == null)
				{
					out.print("Đường dẫn ảnh không được bỏ trống");
					return;
				}
				String obj_url = request.getParameter("obj_url");	
				if(obj_url == null)
				{
					obj_url = "";
				}
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
				String sql ="SELECT * FROM slide WHERE name=?";
				PreparedStatement pst = conn.prepareStatement(sql);				
				pst.setString(1, name);  
				ResultSet rs = pst.executeQuery();
				if (rs.next() == false) 
				{
					sql ="INSERT INTO slide (name, slogan, status, image_path, obj_url, last_update) VALUES('"+name+"', '"+slogan+"', '"+setStatus+"', '"+image_path+"', '"+obj_url+"', '"+strDate+"') ";
					pst = conn.prepareStatement(sql);
					pst.execute();
					String site = new String("slide.jsp?action=view_list");
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
				String sql ="SELECT * FROM slide WHERE id=?";
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
						editSlogan = rs.getString("slogan");
						editImagePath = rs.getString("image_path");
						editObjUrl = rs.getString("obj_url");
					}
					 while(rs.next());       
				}
			}
			if(action.equals("edit_item_process"))
			{
				String editID = (String)session.getAttribute("editSlideID");
				if(editID == null)
				{
					out.print("Phiên làm việc đã hết");
					return;
				}
				int upd_id = Integer.parseInt(editID);
				String name = request.getParameter("name");	
				if(name == null)
				{
					out.print("Tên không được bỏ trống");
					return;
				}
				String slogan = request.getParameter("slogan");	
				String image_path = request.getParameter("image_path");	
				if(image_path == null)
				{
					out.print("Đường dẫn ảnh không được bỏ trống");
					return;
				}
				String obj_url = request.getParameter("obj_url");
				if(obj_url == null)
				{
					obj_url = "";
				}
				String status = request.getParameter("status");
				if(status == null)
				{
					status = "0";
				}
				int setStatus = Integer.parseInt(status);						
				java.util.Date date = new java.util.Date();
				Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String strDate = formatter.format(date);
				String sql ="UPDATE slide SET name = ?, slogan = ?, image_path=?, obj_url=?, status=?, last_update=? WHERE id = ?";
				
				//out.print(upd_id+" "+sql);
				
				PreparedStatement pst = conn.prepareStatement(sql);
				pst.setString(1, name);                   
				pst.setString(2, slogan);
				pst.setString(3, image_path);
				pst.setString(4, obj_url);
				pst.setInt(5, setStatus);                   
				pst.setString(6, strDate);
				pst.setInt(7, upd_id);
				pst.executeUpdate();
				 session.removeAttribute("editSlideID");
				String site = new String("slide.jsp?action=view_list");
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
				String sql ="DELETE slide WHERE id = ?";
				PreparedStatement pst = conn.prepareStatement(sql);
				pst.setString(1, id);  
				ResultSet rs = pst.executeQuery();							
				String site = new String("slide.jsp?action=view_list");
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
		<jsp:include page="slide_list.jsp" />  
	<%}%>
	<% 
	if(action.equals("add_item"))
	{%>
		<jsp:include page="add_slide_tpl.jsp" />  
	<%}%>
	<% 
	if(action.equals("edit_item"))
	{
		session.setAttribute("editSlideID", id);
		request.setCharacterEncoding("UTF-8");
		%>
		<jsp:include page="edit_slide_tpl.jsp" >  
		 <jsp:param name="name" value="<%=editName%>" />
		 <jsp:param name="status" value="<%=editStatus%>" />
		<jsp:param name="obj_url" value="<%=editObjUrl%>" />
		 <jsp:param name="slogan" value="<%=editSlogan%>" />
		 <jsp:param name="image_path" value="<%=editImagePath%>" />  
		</jsp:include>
	<%}%>
</div>
<jsp:include page="footer.jsp" />  
