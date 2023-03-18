<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
        <form class="col-lg-4 col-md-4" method="GET" action="repassprocess.jsp">
		<h3>Đổi mật khẩu</h3>
    <!-- Password input -->
    <div class="form-outline mb-4">
        <input type="password" id="form2Example2" name="password" class="form-control" />
        <label class="form-label" for="form2Example2">Mật khẩu cũ</label>
    </div>
	<div class="form-outline mb-4">
        <input type="password" id="form2Example21" name="new_password" class="form-control" />
        <label class="form-label" for="form2Example21">Mật khẩu mới</label>
    </div>
	<div class="form-outline mb-4">
        <input type="password" id="form2Example22" name="new_password_conf" class="form-control" />
        <label class="form-label" for="form2Example22">Nhập lại mật khẩu mới</label>
    </div>
    <!-- Submit button -->
    <button type="submit" class="btn btn-success btn-block mb-4">Thực hiện</button>
    </form>
