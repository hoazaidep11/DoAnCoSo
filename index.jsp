<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.io.*,java.util.*, java.text.*, java.sql.*, com.mysql.jdbc.Driver"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%!
			public class News
			{
				int id;
				String title;
				String content_desc;
				String slug;
				String avatar;
				String external_link;
				int category;
				public News(int id, String title, String content_desc, String slug, String avatar, String external_link, int category)
				{
					this.id = id;
					this.title = title;
					this.content_desc = content_desc;
					this.slug = slug;
					this.avatar = avatar;
					this.external_link = external_link;
					this.category = category;
				}
				public int getId()
				{
					return id;
				}
				public String getTitle()
				{
					return title;
				}
				public String getContentDesc()
				{
					return content_desc;
				}
				public String getSlug()
				{
					return slug;
				}
				public String getAvatar()
				{
					return avatar;
				}
				public String getExternalLink()
				{
					return external_link;
				}
				public int getCategory()
				{
					return category;
				}
			}
		%>
		<%!
			public class Slide
			{
				String name;
				String image_path;
				String slogan;
				public Slide(String name, String image_path, String slogan)
				{
					this.name = name;
					this.image_path = image_path;
					this.slogan = slogan;
				}
				public String getName()
				{
					return name;
				}
				public String getImagePath()
				{
					return image_path;
				}
				public String getSlogan()
				{
					return slogan;
				}
			}
		%>
		<%
		List<String> catID = new ArrayList<>();
		List<String> catTitle = new ArrayList<>();
		List<String> catSlug = new ArrayList<>();		
		List<News> newsList = new ArrayList<News>();
		List<News> infoList = new ArrayList<News>();
		List<Slide> slideList = new ArrayList<Slide>();
		
		int catTinTucCongNgheID = 0;
		int catReviewDanhGiaSanPhamID = 0;
		int catVideoKhoi2 = 0;
		int catVideoReviewRight = 0;
		
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
			String sql ="SELECT * FROM category WHERE status = 1";
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet categoryRs = pst.executeQuery();
			String[] catItem;
			if(categoryRs.next() != false)
			{
				do{
					String cat_id = categoryRs.getString("id");
					catID.add(cat_id);
					String name = categoryRs.getString("name");
					catTitle.add(name);
					catSlug.add(categoryRs.getString("slug"));	
					if(name.equals("Tin tức công nghệ"))
					{
						catTinTucCongNgheID = Integer.parseInt(cat_id);
					}
					else if(name.equals("Review, đánh giá sản phẩm"))
					{
						catReviewDanhGiaSanPhamID = Integer.parseInt(cat_id);
					}
					else if(name.equals("Video reviews 02"))
					{
						catVideoKhoi2 = Integer.parseInt(cat_id);
					}
					else if(name.equals("Video reviews right"))
					{
						catVideoReviewRight = Integer.parseInt(cat_id);
					}
				}
				while(categoryRs.next());
			}
			
			String append_cond = "";
			for (String eachstring : catID) 
			{
				append_cond+= eachstring+"','";
			}
			append_cond = (String)append_cond.substring(0, append_cond.length() - 2);			
			
			//out.print("cat cond "+append_cond);
			sql ="SELECT * FROM content WHERE status = 1 AND is_hot = 1 AND type = 0 AND category IN('"+append_cond+")";
			pst = conn.prepareStatement(sql);
			ResultSet contentNews = pst.executeQuery();
			if(contentNews.next() != false)
			{
				do{
					newsList.add(new News(contentNews.getInt("id"), contentNews.getString("title"), contentNews.getString("content_desc"), contentNews.getString("slug"), contentNews.getString("avatar"), contentNews.getString("external_link"), contentNews.getInt("category")));
				}
				while(contentNews.next());
			}
			sql ="SELECT * FROM content WHERE status = 1 AND is_hot = 1 AND type = 1 AND category IN('"+append_cond+")";
			pst = conn.prepareStatement(sql);
			ResultSet contentInfo = pst.executeQuery();
			
			if(contentInfo.next() != false)
			{
				do{
					infoList.add(new News(contentInfo.getInt("id"), contentInfo.getString("title"), contentInfo.getString("content_desc"), contentInfo.getString("slug"), contentInfo.getString("avatar"), contentInfo.getString("external_link"), contentInfo.getInt("category")));
				}
				while(contentInfo.next());
			}
			
			sql ="SELECT * FROM slide WHERE status = 1 ORDER BY last_update DESC";
			pst = conn.prepareStatement(sql);
			ResultSet slideRs = pst.executeQuery();
			if(slideRs.next() != false)
			{
				do
				{
					slideList.add(new Slide(slideRs.getString("name"), slideRs.getString("image_path"), slideRs.getString("slogan"))); 
				}while(slideRs.next());
			}
		}
	}	
	catch(Exception e)
	{
		out.print("<h3 style='color:red'>Unable to connect to database.</h3>");
		out.print("<h3 style='color:red'>My ERROR : "+e+"</h3>");
		System.out.println("Unable to connect : "+e);
    }
		String link = "";
		%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="https://cdn1.iconfinder.com/data/icons/internet-technology-and-security-2/128/67-128.png">
    <link rel="stylesheet" href="./assets/css/main.css">
    <link rel="stylesheet" href="./assets/css/base.css">
    <link rel="stylesheet" href="./assets/fonts/themify-icons/themify-icons.css">
    <link rel="stylesheet" href="./assets/OwlCarousel2-2.3.4/dist/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="./assets/OwlCarousel2-2.3.4/dist/assets/owl.theme.default.min.css">
    <title>Technology.com</title>
</head>
<body>
    <div id="main">
        <!-- Đầu trang -->
        <div id="header">
            <ul id="menu">
                <li><a href="#">Trang chủ</a></li>
                <li><a href="#news">Tin tức</a></li>
                <li><a href="#content">Bài viết</a></li>
                <li><a href="#info">Thông tin liện hệ</a></li>
            </ul>
        </div>
        <!-- Ảnh chuyển động -->
        <div class="slider owl-carousel owl-theme">
            <!-- Slider 1 -->
			<%for(Slide items:slideList){%>
            <div class="slider-item slider-item-one">
                <div class="wraper">
                    <div class="slider-item-text">
                        <h2 class="slider-item-name"><%=items.getName()%></h2>
                        <p class="slider-item-slogan"><%=items.getSlogan()%></p>
                    </div>
                </div>
            </div>
			<%}%>
        </div>
		
		
        <!-- Nội dung trang web -->
        <div id="contact" >
            <!-- Begin: Các tin tin về công nghệ mới nhất được cập nhật hàng tuần -->
            <div id="news" class="news-section">
                <div class="contact-section">
                    <h2 class="section-heading">Tin Tức</h2>
                    <p class="section-sub-heading">Tin tức công nghệ</p>
                    <!-- Danh sách tin tức -->
                    <div class="news-list">
						<% for(News items : newsList){%>
                        <!-- Tin tức 1 -->
                        <div class="news-item">
                            <img src="<%=items.getAvatar()%>" alt="<%=items.getTitle()%>" class="news-img">
                            <div class="news-content">
                                <h3 class="news-heading"><%=items.getTitle()%></h3>
                                <p class="news-desc"><%=items.getContentDesc()%></p>
								<%
									link = items.getExternalLink();
									if(link.isEmpty() || link == null)
									{
										link = "post.jsp?title="+items.getSlug()+"&id="+items.getId();
									}
								%>
                                <a href="<%=link%>" class="news-inf-btn">Tìm hiểu thêm</a>
                            </div>
                        </div>
                        <%}%>                 
                    </div>                    
                </div>   
                <div class="clear"></div>
            </div>  
            <!-- End: Các tin tức -->
            
            <!-- =================================================================================== -->
            
            <!-- Begin: Bài viết,bài đánh giá về sản phẩm, review -->
            <div id="content" class="contact-section-review">
                <div class="contact-section">
                    <h2 class="section-heading">Video</h2>
                    <p class="section-sub-heading">Review, đánh giá sản phẩm</p>
                        <!-- Khối 1 -->
                        <div class="contact-section-review01">
                            <!-- Danh sách bài viết 1: bên trái -->
                            <div class="contact-section-reviewlist">  
								<%for(News items: infoList){%>
								<%if(items.getCategory() == catReviewDanhGiaSanPhamID){%>
								<%
									link = items.getExternalLink();
									if(link.isEmpty() || link == null)
									{
										link = "post.jsp?title="+items.getSlug()+"&id="+items.getId();
									}
								%>
                                <!-- Bài viết 1 -->
                                <a class="review-item" href="<%=link%>">
                                    <h3 class="review-heading"><%=items.getTitle()%></h3>
                                    <p class="review-text"><%=items.getContentDesc()%></p><br><hr>
                                </a>
                                <%}}%>
                            </div>
                        </div>
                        <!-- Khối 2 -->
                        <div class="contact-section-review02">
						<%for(News items: infoList){%>
								<%if(items.getCategory() == catVideoKhoi2){%>
								<%
									link = items.getExternalLink();
									if(link.isEmpty() || link == null)
									{
										link = "post.jsp?title="+items.getSlug()+"&id="+items.getId();
									}
								%>
                            <a href="<%=link%>">
                            <img class="img-logo" src="<%=items.getAvatar()%>" alt="<%=items.getTitle()%>">
                            </a>
						 <%}}%>	
                        </div>
                        <!-- Khối 3 -->
                        <div class="contact-section-review03">
                            <!-- Danh sách bài viết 2: bên tay phải -->
                            <div class="contact-section-reviewlist">   
								<%for(News items: infoList){%>
								<%if(items.getCategory() == catVideoReviewRight){%>
								<%
									link = items.getExternalLink();
									if(link.isEmpty() || link == null)
									{
										link = "post.jsp?title="+items.getSlug()+"&id="+items.getId();
									}
								%>
                                <!-- Bài viết 5 -->
                                <a class="review-item" href="<%=link%>">
                                    <h3 class="review-heading"><%=items.getTitle()%></h3>
                                    <p class="review-text"><%=items.getContentDesc()%></p><br><hr>
                                </a>
                               <%}}%>	
                            </div>
                        </div>
                </div>
            </div>
            <!-- End: Bài viết -->

            <!-- =================================================================================== -->  

            <!-- Begin: Các thông tin liên hệ và nhận các phản hồi -->
            <div id="info" class="row contact-information">
                <div class="contact-section">
                    <h2 class="section-heading">Thông tin liên hệ</h2>
                    <p class="section-sub-heading">Tiếp nhận các thông tin phản hồi từ đọc giả</p>
                        <div class="info">
                            <div class="col info-list">
                                <p><i class="ti-location-pin"></i>Hồ Chí Minh City</p>
                                <p><i class="ti-mobile"></i>Phone +84 0333.513.669</p>
                                <p><i class="ti-email"></i>hhqteam.cntt@gmail.com</p>
                            </div>
                            <!-- <div class="col col-half contact-form">
                                <form action="">
                                    <div class="row">
                                        <div class="col col-half">
                                            <input type="text" name="" placeholder="Họ tên" required id="" class="form-control">
                                        </div>
        
                                        <div class="col col-half">
                                            <input type="email" name="" placeholder="Email" required id="" class="form-control">
                                        </div>
                                    </div>
                                    <div class="row mt-8">
                                        <div class="col col-full">
                                            <input type="text" name="" placeholder="Lời nhắn cho Admin" required id="" class="form-control">
                                        </div>
                                    </div>
                                    <input class="form-submit-btn mt-16" type="submit" value="Gửi">
                                </form>
                            </div>
                        </div> -->
                </div>
            </div>  
            <!-- End: Các thông tin liên hệ -->
        </div>
        <!-- End: Nội dung trang web -->

        <!-- =================================================================================== -->

        <!-- Begin: Bản đồ công nghệ thế giới -->
        <div class="map-section">
            <img src="./assets/img/Map/Map01.jpg" alt="Ảnh bản đồ công nghệ trên thế giới">
            <div class="map-text">
                <h4 class="map-text-heading">KẾT NỐI CÔNG NGHỆ<br>TECHNOLOGY CONNECTION</h4>
            </div>
        </div>
        <!-- End: Bản đồ -->

        <!-- =================================================================================== -->

        <!-- Begin: Cuối trang -->
        <div id="footer">
            <div class="socials-list">
                <a href=""><i class="ti-facebook"></i></a>
                <a href=""><i class="ti-linkedin"></i></a>
                <a href=""><i class="ti-twitter-alt"></i></a>
                <a href=""><i class="ti-youtube"></i></a>
            </div>
            <p class="copyright">Powered by <a href="">hhqteam</a></p>
        </div>
        <!-- End: Cuối trang -->
    </div>
</body>
<!-- link các file javascript trong thư viên owlcarousel -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="./assets/OwlCarousel2-2.3.4/dist/owl.carousel.min.js"></script>
<script>
    // gọi hàm
    $(document).ready(function(){
    $(".owl-carousel").owlCarousel();});
    //responsive cho web 
    $('.owl-carousel').owlCarousel({
    loop:true,
    margin:10,
    nav:true,
    autoplay:true,
    autoplayTimeout:4000,
    responsive:{
        0:{
            items:1
        },
        600:{
            items:1
        },
        1000:{
            items:1
        }
    }
    })
</script>
</html>