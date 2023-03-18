<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>   
<%	
	int status = 0;
	String getStatus = request.getParameter("status");
	status = Integer.parseInt(getStatus);
%> 
   <form class="col-lg-4 col-md-4" method="GET" action="slide.jsp">
    <!-- Password input -->
    <div class="form-outline mb-4">
        <input type="text" id="form2Example2" name="name" value="<%=request.getParameter("name")%>" class="form-control" required />
        <label class="form-label" for="form2Example2">Tên ảnh</label>
    </div>
	<div class="form-outline mb-4">
        <input type="text" id="slogan" name="slogan" value="<%=request.getParameter("slogan")%>" class="form-control" />
        <label class="form-label" for="slogan">Slogan</label>
    </div>
	<div class="form-outline mb-4">
        <input type="text" id="image_path" name="image_path" value="<%=request.getParameter("image_path")%>" class="form-control" required />
        <label class="form-label" for="image_path">Đường dẫn ảnh</label>
    </div>
	<div class="form-outline mb-4">
        <input type="text" id="obj_url" name="obj_url" value="<%=request.getParameter("obj_url")%>" class="form-control" />
        <label class="form-label" for="obj_url">Trang đích</label>
    </div>
	<div class="form-outline mb-4">
        <input type="checkbox" id="form2Example21" name="status" value="1" <%=((status > 0) ? "checked" : "")%> />
        <label class="form-label" for="form2Example21">Ẩn/hiện</label>
    </div>
	<input type="hidden" name="action" value="edit_item_process">
    <!-- Submit button -->
    <button type="submit" class="btn btn-success btn-block mb-4">Thực hiện</button>
    </form>
