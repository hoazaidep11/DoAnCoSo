<%
 Boolean isLogged= (Boolean)session.getAttribute("is_logged");
	if(isLogged == null)
	{
		 session.setAttribute("is_logged", false);
	}
	else if(isLogged)
	  {
		String site = new String("index.jsp");
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", site); 
		return;
	  } 
%>
<!DOCTYPE html>
<html lang="en">
<head>
   <%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
  <title>Đăng nhập trang quản trị</title>  
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1"> 
</head>
<body>
<div class="h-100 container m-auto p-5" >

        <form  class="col-lg-4 col-md-4 p-4 m-auto" method="GET" action="loginprocess.jsp" style="border:1px solid #ddd; padding: 4px">
		<h3>Vào trang quản trị</h3>
    <!-- Email input -->
    <div class="form-outline mb-4">
        <input type="text" id="form2Example1" name="id" class="form-control" required />
        <label class="form-label" for="form2Example1">ID</label>
    </div>

    <!-- Password input -->
    <div class="form-outline mb-4">
        <input type="password" id="form2Example2" name="password" class="form-control" required />
        <label class="form-label" for="form2Example2">Mật khẩu</label>
    </div>
    <!-- Submit button -->
    <button type="submit" class="btn btn-primary btn-block mb-4 w-100">Đăng nhập</button>
    </form>
</div>
<footer >
	<div class="footer container-fluid bg-dark" style="height: 60px; color: #fff; padding: 20px; right: 0; left: 0;">
		<div style="text-align: center">
			Copyright &copy; 2022
		</div>			
	</div>
</footer>
<script  src="css/bootstrap5/bootstrap.bundle.min.js" ></script>
<link rel="stylesheet" href="css/bootstrap5/bootstrap.min.css" >
<link rel="stylesheet" href="css/bootstrap5/bootstrap-icons.css">
</body>
</html>