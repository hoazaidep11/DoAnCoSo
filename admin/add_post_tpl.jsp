<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%> 
<script>
var ROOT_URL = "post.jsp";
var act = "add_item_process";
</script>
<%
	String catID[]  = (String[])session.getAttribute("selectCatID");
	String catTitle[] = (String[])session.getAttribute("selectCatTitle");	
	
%>
   <form  class="col-lg-9 col-md-9" method="GET" action="post.jsp">
		<div class="mb-4 mt-4">
			<label for="title" class="form-label">Tiêu đề:</label>
			<input type="text" class="form-control" id="title" placeholder="Tiêu đề" name="title" required>
		</div>
		<div class="mb-4 mt-4">
			<label for="desc" class="form-label">Mô tả:</label>
			<textarea class="form-control" rows="5"  id="desc" placeholder="Mô tả" name="desc"></textarea>
		</div>
		<div class="mb-3 mt-3">
			<label for="avatar" class="form-label">Ảnh đại diện:</label>
			<input type="text" class="form-control" id="avatar" placeholder="Link ảnh đại diện" name="avatar">
		</div>
		<div class="mb-3 mt-3">
			<label for="external_link" class="form-label" title="Click vào đây sẽ nhảy sang trang liên kết">Link liên kết:</label>
			<input type="text" class="form-control" id="external_link" placeholder="Link ảnh đại diện" name="external_link">
		</div>
		<div class="mb-3 mt-3">
			<label for="key_word" class="form-label">Key word</label>
			<input type="text" class="form-control" id="key_word" placeholder="SEO KEY WORD" name="key_word">
		</div>
		<div class="mb-3 mt-3">
			<label for="meta_desc" class="form-label">META DESC</label>
			<input type="text" class="form-control" id="meta_desc" placeholder="SEO META DESC" name="meta_desc">
		</div>
		<div class="mb-3 mt-3">
			<label for="meta_desc" class="form-label">Loại</label>
			<select class="form-control" id="type" name="type" required>
				<option value=""></option>
				<option value="0">Tin tức</option>
				<option value="1">Bài viết</option>
			</select>
		</div>
		<%! int i;%>
	
		<div class="mb-3 mt-3">
			<label for="meta_desc" class="form-label">Chuyên mục</label>
			<select class="form-control" id="category" name="category" required>
				<option value=""></option>
				<% for(i = 0; i < catID.length; i++){%>
				<% out.println("<option value='"+catID[i]+"'>"+catTitle[i]+"</option>"); %>
				<%}%>
			</select>
		</div>
		<div class="mb-3 mt-3">
			<label for="status" class="form-label">Trạng thái</label>
			<select class="form-control" id="status" name="status" required>
				<option value=""></option>
				<option value="0">Ẩn</option>
				<option value="1">Hiện</option>
			</select>
		</div>
		<div class="mb-3 mt-3">
			<label for="is_hot" class="form-label" title="Hiện ở trang chủ">Nổi bật</label>
			<select class="form-control" id="is_hot" name="is_hot" required>
				<option value=""></option>
				<option value="0">Bình thường</option>
				<option value="1">Nổi bật</option>
			</select>
		</div>
		<div class="mb-3 mt-3">
			<label for="content" class="form-label">Nội dung</label>
			<textarea name="content" id="content" class="tct form-control" value=""></textarea>
		</div>
		<div id="rs_msg" style="font-weight: 700"></div>
		<button id="save_post" type="submit" class="btn btn-success btn-block mb-4">Thực hiện</button>
    </form>


<script src="js/tinymce/tinymce.min.js"></script>  
<script src="js/editor.js"></script> 