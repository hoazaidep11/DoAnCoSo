<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%> 
<script>
var ROOT_URL = "post.jsp";
var act = "edit_item_process";
</script>
<%
	String catID[]  = (String[])session.getAttribute("selectCatID");
	String catTitle[] = (String[])session.getAttribute("selectCatTitle");	
	String selectedCat = (String)request.getAttribute("category");
	String postType = (String)request.getAttribute("type");
	String status = (String)request.getAttribute("status");
	String is_hot = (String)request.getAttribute("is_hot");
%>
   <form class="col-lg-9 col-md-9" method="GET" action="post.jsp">
		<div class="mb-4 mt-4">
			<label for="title" class="form-label">Tiêu đề:</label>
			<input type="text" class="form-control" value="<%=request.getAttribute("title")%>" id="title" placeholder="Tiêu đề" name="title" required>
		</div>		
		<div class="mb-4 mt-4">
			<label for="desc" class="form-label">Mô tả:</label>
			<textarea class="form-control" rows="5"  id="desc" placeholder="Mô tả" name="desc"><%=request.getAttribute("content_desc")%></textarea>
		</div>
		<div class="mb-3 mt-3">
			<label for="avatar" class="form-label">Ảnh đại diện:</label>
			<input type="text" class="form-control" id="avatar" value="<%=request.getAttribute("avatar")%>" placeholder="Link ảnh đại diện" name="avatar">
		</div>
		<div class="mb-3 mt-3">
			<label for="external_link" class="form-label" title="Click vào đây sẽ nhảy sang trang liên kết">Link liên kết:</label>
			<input type="text" class="form-control" value="<%=request.getAttribute("external_link")%>" id="external_link" placeholder="Link ảnh đại diện" name="external_link">
		</div>
		<div class="mb-3 mt-3">
			<label for="key_word" class="form-label">Key word</label>
			<input type="text" class="form-control" value="<%=request.getAttribute("key_word")%>" id="key_word" placeholder="SEO KEY WORD" name="key_word">
		</div>
		<div class="mb-3 mt-3">
			<label for="meta_desc" class="form-label">META DESC</label>
			<input type="text" class="form-control" value="<%=request.getAttribute("meta_desc")%>" id="meta_desc" placeholder="SEO META DESC" name="meta_desc">
		</div>
		
		<div class="mb-3 mt-3">
			<label for="meta_desc" class="form-label">Loại</label>
			<select class="form-control" id="type" name="type" required>
				<option value=""></option>
				<option value="0" <%=(postType.equals("0") ? "selected" : "")%>>Tin tức</option>
				<option value="1" <%=(postType.equals("1") ? "selected" : "")%>>Bài viết</option>
			</select>
		</div>
		<%! int i;%>
	
		<div class="mb-3 mt-3">
			<label for="meta_desc" class="form-label">Chuyên mục</label>
			<select class="form-control" id="category" name="category" required>
				<option value=""></option>
				<% for(i = 0; i < catID.length; i++){%>
				<option value="<%=catID[i]%>" <%=(catID[i].equals(selectedCat) ? "selected" : "")%>><%=catTitle[i]%></option>
				<%}%>
			</select>
		</div>
		<div class="mb-3 mt-3">
			<label for="status" class="form-label">Trạng thái</label>
			<select class="form-control" id="status" name="status" required>
				<option value=""></option>
				<option value="0" <%=(status.equals("0") ? "selected" : "")%>>Ẩn</option>
				<option value="1" <%=(status.equals("1") ? "selected" : "")%>>Hiện</option>
			</select>
		</div>
		<div class="mb-3 mt-3">
			<label for="is_hot" class="form-label" title="Hiện ở trang chủ">Nổi bật</label>
			<select class="form-control" id="is_hot" name="is_hot" required>
				<option value=""></option>
				<option value="0" <%=(is_hot.equals("0") ? "selected" : "")%>>Bình thường</option>
				<option value="1" <%=(is_hot.equals("1") ? "selected" : "")%>>Nổi bật</option>
			</select>
		</div>
		<div class="mb-3 mt-3">
			<label for="content" class="form-label">Nội dung</label>
			<textarea name="content" id="content" class="tct form-control" value=""><%=request.getAttribute("content")%></textarea>
		</div>
		<div id="rs_msg" style="font-weight: 700"></div>
		<button id="save_post" type="submit" class="btn btn-success btn-block mb-4">Thực hiện</button>
    </form>
<script src="js/tinymce/tinymce.min.js"></script>  
<script src="js/editor.js"></script> 