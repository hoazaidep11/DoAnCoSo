<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>   
   <form class="col-lg-4 col-md-4" method="GET" action="category.jsp">
    <!-- Password input -->
    <div class="form-outline mb-4">
        <input type="text" id="form2Example2" name="name" class="form-control" />
        <label class="form-label" for="form2Example2">Tên chuyên mục</label>
    </div>
	<div class="form-outline mb-4">
        <input type="checkbox" id="form2Example21" name="status" value="1" />
        <label class="form-label" for="form2Example21">Ẩn/hiện</label>
    </div>
	<input type="hidden" name="action" value="add_item_process">
    <!-- Submit button -->
    <button type="submit" class="btn btn-success btn-block mb-4">Thực hiện</button>
    </form>
