<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.io.*,java.util.*, java.text.*, java.sql.*, com.mysql.jdbc.Driver"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%
	String getID = request.getParameter("id");	
	int id = 0;
	if(getID == null)
	{
		out.print("No parameter");
		return;
	}
	else
	{
		id = Integer.parseInt(getID);
	}
	String cat_slug = request.getParameter("theloai");
	if(cat_slug == null)
	{
		out.print("No parameter");
		return;
	}
	int offsetVal = 0;
%>
<%!			
			public class News
			{
				int id;
				String title;
				String content;
				String content_desc;
				String slug;
				String avatar;
				String external_link;
				int category;
				public News(int id, String title, String content, String content_desc, String slug, String avatar, String external_link, int category)
				{
					this.id = id;
					this.title = title;
					this.content = content;
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
				public String getContent()
				{
					return content;
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
		List<Slide> slideList = new ArrayList<Slide>();
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
			String sql ="SELECT * FROM category WHERE status = 1 AND id = ?";
			PreparedStatement pst = conn.prepareStatement(sql);
			pst.setInt(1, id);
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
				}
				while(categoryRs.next());
			}
			else
			{
				out.print("Chuyên mục không tồn tại hoặc bị ẩn");
				return;
			}
			int postNumber = 0;
			
			sql ="SELECT count(*) as postNumber FROM content WHERE status = 1 AND is_hot = 1 AND type = 0 AND category = ?";
			pst = conn.prepareStatement(sql);
			pst.setInt(1, id); 
			ResultSet contentCount = pst.executeQuery();
			if(contentCount.next() != false)
			{
				do
				{
					postNumber = contentCount.getInt("postNumber");	
				}while(contentCount.next());
			}
			else
			{
				out.print("Không có dữ liệu");
				return;
			}			
			//out.print(offsetVal);
			sql ="SELECT * FROM content WHERE status = 1 AND is_hot = 1 AND type = 0 AND category = ?";
			pst = conn.prepareStatement(sql);
			pst.setInt(1, id); 
			ResultSet contentNews = pst.executeQuery();
			if(contentNews.next() != false)
			{
				do{
					newsList.add(new News(contentNews.getInt("id"), contentNews.getString("title"), contentNews.getString("content"), contentNews.getString("content_desc"), contentNews.getString("slug"), contentNews.getString("avatar"), contentNews.getString("external_link"), contentNews.getInt("category")));
				}
				while(contentNews.next());
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
                    <!-- Danh sách tin tức -->
                    <div class="news-list">
						<% for(News items : newsList){%>
                        <!-- Tin tức 1 -->
                        <div class="news-item">
                            <img src="<%=items.getAvatar()%>" alt="<%=items.getTitle()%>" class="news-img">
                            <div class="news-content">
                                <h3 class="news-heading"><%=items.getTitle()%></h3>
                                <p class="news-desc"><%=items.getContentDesc()%></p>								
                               <p><%=items.getContent()%></p>
                            </div>
                        </div>
                        <%}%>                 
                    </div>                    
                </div>   
                <div class="clear"></div>
            </div>  
			<%if(offsetVal > 0){%>
			<div><a href="&offset=<%=offsetVal%>">Xem thêm</a></div>
			<%}%>
            <!-- End: Các tin tức -->
            
            

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