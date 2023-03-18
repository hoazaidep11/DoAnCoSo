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
	//String[] fields = {"title", "desc", "slug", "meta_desc", "key_word",  "external_link", "avatar", "postType", "category", "content"};
	String[] edit_fields = {"title", "content_desc", "meta_desc", "external_link", "key_word", "status",  "avatar", "type", "category", "content", "is_hot", "slug"};
	Map<String, String> editData = new HashMap<String, String>();
	List<String> catID = new ArrayList<>();
	List<String> catTitle = new ArrayList<>();
	String errorMsg = "";
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
				String title = request.getParameter("title");
				if(title == null)
				{
					title = "";
					errorMsg += "Tiêu đề không được bỏ trống<br>";
				}
				String slug;
				slug = title;
				slug = slug.replaceAll("\"", "");
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
				String desc = request.getParameter("desc");
				 
				if(desc == null)
				{
					desc = "";
				}
				String avatar = request.getParameter("avatar");
				if(avatar == null)
				{
					avatar = "";
				}
				String meta_desc = request.getParameter("meta_desc");
				if(meta_desc == null)
				{
					meta_desc = "";
				}
				String key_word = request.getParameter("key_word");
				if(key_word == null)
				{
					key_word = "";
				}
				String status = request.getParameter("status");
				if(status == null)
				{
					status = "0";
				}
				String content = request.getParameter("content");
				if(content == null)
				{
					content = "";
					errorMsg += "Nội dung không được bỏ trống<br>";
				}
				String external_link =  request.getParameter("external_link");
				if(external_link == null)
				{
					external_link = "";
				}
				String category =  request.getParameter("category");				
				if(category == null)
				{					
					category = "0";
					errorMsg += "Chuyên mục không được bỏ trống<br>";
					
				}	
				String postType =  request.getParameter("type");
				if(postType == null)
				{
					postType = "0";
					errorMsg += "Loại bài viết không được bỏ trống<br>";
				}
				String isHot =  request.getParameter("is_hot");
				if(isHot == null)
				{
					isHot = "0";					
				}
				if(!errorMsg.isEmpty())
				{
					out.print(errorMsg);
					return;
				}
				errorMsg = "";
				int setStatus = Integer.parseInt(status);						
				java.util.Date date = new java.util.Date();
				Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String strDate = formatter.format(date);
				//CHECK EXITS			
				String sql ="SELECT * FROM content WHERE title=? or slug=?";
				PreparedStatement pst = conn.prepareStatement(sql);
				pst.setString(1, title);                   
				pst.setString(2, slug);
				ResultSet rs = pst.executeQuery();
				if (rs.next() == false) 
				{
					sql ="INSERT INTO content (title, content_desc, slug, external_link, content, category, avatar, type, key_word, meta_desc, status, time_add, last_update, is_hot) VALUES('"+title+"', '"+desc+"', '"+slug+"', '"+external_link+"', '"+content+"', '"+category+"', '"+avatar+"', '"+postType+"', '"+key_word+"', '"+meta_desc+"', '"+setStatus+"', '"+strDate+"', '"+strDate+"', '"+isHot+"') ";
					//out.print(sql);
					pst = conn.prepareStatement(sql);
					int rowID = pst.executeUpdate();
					if(rowID > 0)
					{
						out.print("Thành công");
					}
					
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
				String sql ="SELECT * FROM category WHERE status=1";
				PreparedStatement pst = conn.prepareStatement(sql);				
				ResultSet categoryList = pst.executeQuery();
				if (categoryList.next() != false) 
                {
					do
					{
						catID.add(categoryList.getString("id"));
						catTitle.add(categoryList.getString("name"));
					}
					while(categoryList.next());
				}
				//GET DATA FROM DATABASE
				sql ="SELECT * FROM content WHERE id=?";
				pst = conn.prepareStatement(sql);
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
						int edt  = 0;
						int ed_number = edit_fields.length;
						for(edt = 0; edt < ed_number; edt++)
						{
							editData.put(edit_fields[edt], rs.getString(edit_fields[edt]));
						}
					}
					 while(rs.next());       
				}
			}
			
			if(action.equals("add_item"))
			{
				String sql ="SELECT * FROM category WHERE status=1";
				PreparedStatement pst = conn.prepareStatement(sql);				
				ResultSet categoryList = pst.executeQuery();
				if (categoryList.next() != false) 
                {
					do
					{
						catID.add(categoryList.getString("id"));
						catTitle.add(categoryList.getString("name"));
					}
					while(categoryList.next());
				}
			}
			
			if(action.equals("edit_item_process"))
			{
				String editID = (String)session.getAttribute("editPostID");
				if(editID == null)
				{
					out.print("Phiên làm việc đã hết");
					return;
				}
				int upd_id = Integer.parseInt(editID);
				String title = request.getParameter("title");
				if(title == null)
				{
					title = "";
					errorMsg += "Tiêu đề không được bỏ trống<br>";
				}
				String slug =  request.getParameter("slug");
				if(slug == null)
				{					
					slug = "";
					slug = title;	
					slug = slug.replaceAll("\"", "");
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
				}
				
				String desc = request.getParameter("desc");
				 
				if(desc == null)
				{
					desc = "";
				}
				String avatar = request.getParameter("avatar");
				if(avatar == null)
				{
					avatar = "";
				}
				String meta_desc = request.getParameter("meta_desc");
				if(meta_desc == null)
				{
					meta_desc = "";
				}
				String key_word = request.getParameter("key_word");
				if(key_word == null)
				{
					key_word = "";
				}
				String status = request.getParameter("status");
				if(status == null)
				{
					status = "0";
				}
				String content = request.getParameter("content");
				if(content == null)
				{
					content = "";
					errorMsg += "Nội dung không được bỏ trống<br>";
				}
				String external_link =  request.getParameter("external_link");
				if(external_link == null)
				{
					external_link = "";
				}
				String category =  request.getParameter("category");				
				if(category == null)
				{					
					category = "0";
					errorMsg += "Chuyên mục không được bỏ trống<br>";
					
				}	
				String postType =  request.getParameter("type");
				if(postType == null)
				{
					postType = "0";
					errorMsg += "Loại bài viết không được bỏ trống<br>";
				}
				String isHot =  request.getParameter("is_hot");
				if(isHot == null)
				{
					isHot = "0";					
				}
				
				if(!errorMsg.isEmpty())
				{
					out.print(errorMsg);
					return;
				}
				errorMsg = "";
				int setStatus = Integer.parseInt(status);						
				java.util.Date date = new java.util.Date();
				Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String strDate = formatter.format(date);
				String sql ="UPDATE content SET title=?, content_desc =?, slug=?, external_link=?, content=?, category=?, avatar=?, type=?, key_word=?, meta_desc=?, status=?, is_hot=?, slug=?, last_update =? WHERE id = ?";
				PreparedStatement pst = conn.prepareStatement(sql);
				pst.setString(1, title);                   
				pst.setString(2, desc);
				pst.setString(3, slug);
				pst.setString(4, external_link);
				pst.setString(5, content);
				pst.setString(6, category);
				pst.setString(7, avatar);
				pst.setString(8, postType);
				pst.setString(9, key_word);
				pst.setString(10, meta_desc);
				pst.setInt(11, setStatus); 
				pst.setString(12, isHot);
				pst.setString(13, slug);
				pst.setString(14, strDate);
				pst.setInt(15, upd_id);
				int rowAffected = pst.executeUpdate();
				if(rowAffected > 0)
				{
					session.removeAttribute("editPostID");
					out.print("Cập nhật thành công");
				}
				return;				
			}
			if(action.equals("delete_item"))
			{
				
				if((id == null) || id.isEmpty())
				{
					out.print("No parameter");
					return;
				}
				String sql ="DELETE content WHERE id = ?";
				PreparedStatement pst = conn.prepareStatement(sql);
				pst.setString(1, id);  
				ResultSet rs = pst.executeQuery();							
				String site = new String("post.jsp?action=view_list");
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
		<jsp:include page="post_list.jsp" />  
	<%}%>
	<% 
	if(action.equals("add_item"))
	{
		String selectCatID[] = {}; 
		selectCatID = catID.toArray(selectCatID);
		String selectCatTitle[] = {};
		selectCatTitle = catTitle.toArray(selectCatTitle);
		session.setAttribute("selectCatID", selectCatID);
		session.setAttribute("selectCatTitle", selectCatTitle);
		%>
		<jsp:include page="add_post_tpl.jsp" /> 		
	<%}%>
	<% 
	if(action.equals("edit_item"))
	{
		session.setAttribute("editPostID", id);
		String selectCatID[] = {}; 
		selectCatID = catID.toArray(selectCatID);
		String selectCatTitle[] = {};
		selectCatTitle = catTitle.toArray(selectCatTitle);
		session.setAttribute("selectCatID", selectCatID);
		session.setAttribute("selectCatTitle", selectCatTitle);
		for (Map.Entry<String, String> entry : editData.entrySet()) 
		{			
			request.setAttribute(entry.getKey(), entry.getValue());
		}		
		request.setCharacterEncoding("UTF-8");
		%>
		<jsp:include page="edit_post_tpl.jsp" /> 
		
	<%}%>
</div>
<jsp:include page="footer.jsp" />  
