<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	 <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Quản trị website" />
	<meta NAME="Keywords" CONTENT="">
	<link rel="shortcut icon" href="/admincp-icon.png"/>﻿
	<title>Quản trị website</title>
	<script  src="js/jquery.min.js"></script>	 
	<!--[if lt IE 9]>			
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
			<script src="js/respond.min.js"></script>
		<![endif]-->
</head>
<body>
<nav class="navbar navbar-fixed-top navbar-expand-sm bg-dark">
  
      <div class="container">
         <a class="navbar-brand" href="index.jsp" style="margin-top: -5px;">
            <img alt="admin" src="admin_panel-icon.png" height="32px" class="rounded-pill">
          </a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar">
				<span class="navbar-toggler-icon"></span>
		</button>
		
        <div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav me-auto">
				<li class="nav-item"><a href="/index.jsp" class="current" target="_blank"><span>Trang Chủ</span></a></li>
			</ul> 
			<ul class="nav justify-content-end">
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#">
								<span>Admin</span>
								<span class="caret"></span>
							</a>
					<ul class="dropdown-menu" style="margin-left: -30px">
						
								<li class="dropdown-item"><a title="Cập nhật thông tin" href="repass.jsp"><i class="bi bi-person-check-fill" style="margin-right: 5px"></i> Đổi mật khẩu</a></li>
								
								<li class="dropdown-item"><a title="Đăng xuất" href="logout.jsp"><i class="bi bi-power" style="margin-right: 5px"></i> Đăng xuất</a></li>
					</ul>
				</li>
				
			</ul>
         
        </div><!-- /.nav-collapse -->
        
        
      </div><!-- /.container -->
</nav>
<div class="container">
	<div class="row" style="margin-top: 15px">
		<div class="col-lg-3 col-md-3">
			<div class="panel-heading" style="background-color: #222; color: #9d9d9d; border-color: #101010"> <!--Group Chuyên Mục -->
				  <h4 class="panel-title">
					<a  data-bs-toggle="collapse"  href="#collapse_cat"><i style="color: #fff" class="bi bi-folder2 icon_space"></i><span > Chuyên Mục</span></a>					
				  </h4>
				</div>
				
				<div id="collapse_cat" class="panel-collapse collapse show">
				  <ul class="list-group panel-body">
						<li class="list-group-item"><i  class="bi bi-plus-lg icon_space"></i><a href="category.jsp?action=add_item">Thêm mới</a></li>
						<li class="list-group-item"><i class="bi bi-list icon_space"></i><a href="category.jsp?action=view_list">Danh Sách</a></li>					
					
				  </ul>				 
				</div> <!-- END Group Chuyên Mục -->
				<div class="panel-heading" style="background-color: #222; color: #9d9d9d; border-color: #101010"> <!--Group BÀI VIẾT -->
				  <h4 class="panel-title">
					<a  data-bs-toggle="collapse"  href="#collapse_post"><i style="color: #fff" class="bi bi-book icon_space"></i><span > Bài Viết</span></a>
				  </h4>
				</div>
				
				<div id="collapse_post" class="panel-collapse collapse show">
				  <ul class="list-group panel-body">
						<li class="list-group-item"><i  class="bi bi-plus-lg icon_space"></i><a href="post.jsp?action=add_item">Thêm mới</a></li>
						<li class="list-group-item"><i class="bi bi-list icon_space"></i><a href="post.jsp?action=view_list">Danh sách</a></li>
				  </ul>				 
				</div> <!--END Group BÀI VIẾT -->

				<div class="panel-heading"  style="background-color: #222; color: #9d9d9d; border-color: #101010"> <!--Group Album -->
				  <h4 class="panel-title">
					<a  data-bs-toggle="collapse"  href="#collapse_album"><i style="color: #fff" class="bi bi-images icon_space"></i><span > Slide ảnh</span></a>
				  </h4>
				</div>
				
				<div id="collapse_album" class="panel-collapse collapse show">
					<ul class="list-group panel-body">
						<li class="list-group-item"><a href="slide.jsp?action=add_item"><i  class="bi bi-plus-lg icon_space"></i>Thêm Mới</a></li>
						<li class="list-group-item"><a href="slide.jsp?action=view_list"><i  class="bi bi-list icon_space"></i>Danh Sách</a></li>
					</ul>				 
				</div> <!--End group Album -->	
		</div>		
		