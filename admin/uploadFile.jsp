<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
 Boolean isLogged= (Boolean)session.getAttribute("is_logged");
if(!isLogged)
  {
    out.print("<strong>Bạn chưa đăng nhập</strong>");
	return;
  } 
%>
<!DOCTYPE html>
<html lang="en">
<head>   
  <title>Upload file</title>  
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<div class="container">

       <h3>File Upload:</h3>
      Select a file to upload: <br />
      <form action = "UploadServlet.jsp" method = "post"
         enctype = "multipart/form-data">
         <input type = "file" name = "file" size = "50" />
         <br />
         <input type = "submit" value = "Upload File" />
      </form>
</div>
</body>
</html>