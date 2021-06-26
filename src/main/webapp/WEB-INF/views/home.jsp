<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AirTnT</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<!--basic-->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
	<link href='<c:url value='/resources/layout/styles/layout.css'/>' rel="stylesheet" type="text/css" media="all">
	<!--loginModal-->
	<link href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="/resources/css/modal.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<!-- JAVASCRIPTS -->
	<!-- <script src="layout/scripts/jquery.min.js"></script>
	<script src="layout/scripts/jquery.backtotop.js"></script>
	<script src="layout/scripts/jquery.mobilemenu.js"></script> -->
</head>
<body>
	<c:set var="isLogin" value="false"/>
	<c:if test="${not empty member_id && not empty member_name}"><c:set var="isLogin" value="true"/></c:if>
	
<div class="bgded overlay padtop" style="background-image:url('<c:url value='/resources/img/main3.jpg'/>');">
  <!-- ################################################################################################ -->
  <!-- ################################################################################################ -->
  <!-- ################################################################################################ -->
  <header id="header" class="hoc clear" style="padding-right: 10vh;">
    <div id="logo" class="fl_left"> 
      <!-- ################################################################################################ -->
      <h1><a href="index">AirTnT</a></h1>
      <!-- ################################################################################################ -->
    </div>
    <nav id="mainav" class="fl_right" > 
      <!-- ################################################################################################ -->
      <ul class="clear">
        <li class="active"><a href="host/guide_home">호스트 되기</a></li>
        <c:if test="${!isLogin}">
        <li><a class="drop" href="#">로그인 하기</a>
          <ul>
            <li><a href="#LoginModal" class="trigger-btn" data-toggle="modal">로그인</a></li>
            <li><a href="#SignUpModal" class="trigger-btn" data-toggle="modal">회원가입</a></li>
            <li><a href="help">도움말</a></li>
          </ul>
          </c:if>
        <c:if test="${isLogin}">
        <li><a class="drop" href="#">MyPages</a>
          <ul>
            <li><a href="tour">여행</a></li>
            <li><a href="wishList">위시리스트</a></li>
            <li><a href="pages/sidebar-right.html">호스트 되기</a></li>
            <li><a href="mypage">계정</a></li>
            <li><a href="help">도움말</a></li>
            <li><a href="logout">로그아웃</a></li>
          </ul>
          </c:if>
        </li>
      </ul>
      <!-- ################################################################################################ -->
    </nav>
  </header>
  <!-- ################################################################################################ -->
  <!-- ################################################################################################ -->
  <!-- ################################################################################################ -->
  <div id="pageintro" class="hoc clear d-flex justify-content-center" style="padding-top: 5vh; padding-bottom: 50vh;"> 
    <!-- ################################################################################################ -->
        <nav class="navbar navbar-light">
		  <div class="container-fluid">
		    <form class="d-flex" action="<c:url value='/property/search'/>" method="post">
		      <input name="addressKey" class="form-control me-2" type="search" placeholder="위치" aria-label="Search">
		      <button  class="btn btn-outline-primary" type="submit" style="background-color:#01546b; border: 0px;">Search</button>
		    </form>
		  </div>
		</nav>
    <!-- ################################################################################################ -->
  </div>
  <!-- ################################################################################################ -->
</div>
<!-- End Top Background Image Wrapper -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<div class="wrapper row3">
  <main class="hoc container clear"> 
    <!-- main body -->
    <!-- ################################################################################################ -->
    <section id="services">
      <div class="sectiontitle">
        <span class="bold" style="font-size: 3vh">어디에서나, 여행은 살아보는 거야!</span>
      </div>
      <ul class="nospace group grid-3">
        <li class="one_third">
          <article><a href="#"><i class="fas fa-spray-can"></i></a>
            <h6 class="heading">Vehicula</h6>
            <p>Nulla cursus metus non tortor erat turpis sed semper risus nisi id nunc ut congue cursus tortor aliquam.</p>
            <footer><a href="#">More Details &raquo;</a></footer>
          </article>
        </li>
        <li class="one_third">
          <article><a href="#"><i class="fas fa-user-secret"></i></a>
            <h6 class="heading">Porttitor</h6>
            <p>Vehicula nisl ac porta blandit velit risus lobortis turpis sit amet lobortis sapien dui id neque suspendisse.</p>
            <footer><a href="#">More Details &raquo;</a></footer>
          </article>
        </li>
        <li class="one_third">
          <article><a href="#"><i class="fas fa-couch"></i></a>
            <h6 class="heading">Pulvinar</h6>
            <p>Vel justo mattis magna vestibulum molestie quisque sagittis in a enim in metus ultrices tristique nam semper.</p>
            <footer><a href="#">More Details &raquo;</a></footer>
          </article>
        </li>
        <li class="one_third">
          <article><a href="#"><i class="fas fa-crow"></i></a>
            <h6 class="heading">Ultricies</h6>
            <p>Tincidunt metus nunc ornare mi at nibh ut ante est imperdiet dignissim eleifend sit amet lacinia tempor justo.</p>
            <footer><a href="#">More Details &raquo;</a></footer>
          </article>
        </li>
        <li class="one_third">
          <article><a href="#"><i class="fas fa-dolly-flatbed"></i></a>
            <h6 class="heading">Vestibulum</h6>
            <p>Pellentesque malesuada sed et nulla sit amet nisi scelerisque consectetuer vivamus odio donec metus libero semper.</p>
            <footer><a href="#">More Details &raquo;</a></footer>
          </article>
        </li>
        <li class="one_third">
          <article><a href="#"><i class="fas fa-road"></i></a>
            <h6 class="heading">Lobortis</h6>
            <p>Quis suscipit ut aliquam a metus ut interdum risus id luctus consectetuer velit neque ornare quam at ornare.</p>
            <footer><a href="#">More Details &raquo;</a></footer>
          </article>
        </li>
      </ul>
    </section>
    <!-- ################################################################################################ -->
    <!-- / main body -->
    <div class="clear"></div>
  </main>
</div>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<div class="wrapper row1">
  <section id="ctdetails" class="hoc clear"> 
    <!-- ################################################################################################ -->
    <ul class="nospace clear">
      <li class="one_quarter first">
        <div class="block clear"><a href="#"><i class="fas fa-phone"></i></a> <span><strong>Give us a call:</strong> +00 (123) 456 7890</span></div>
      </li>
      <li class="one_quarter">
        <div class="block clear"><a href="#"><i class="fas fa-envelope"></i></a> <span><strong>Send us a mail:</strong> support@domain.com</span></div>
      </li>
      <li class="one_quarter">
        <div class="block clear"><a href="#"><i class="fas fa-clock"></i></a> <span><strong> Mon. - Sat.:</strong> 08.00am - 18.00pm</span></div>
      </li>
      <li class="one_quarter">
        <div class="block clear"><a href="#"><i class="fas fa-map-marker-alt"></i></a> <span><strong>Come visit us:</strong> Directions to <a href="#">our location</a></span></div>
      </li>
    </ul>
    <!-- ################################################################################################ -->
  </section>
</div>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- <div class="bgded overlay" style="background-image:url('images/demo/backgrounds/01.png');">
  <section class="hoc container clear"> 
    ################################################################################################
    <div class="sectiontitle">
      <p class="nospace font-xs">Nisi velit nec turpis nullam vitae</p>
      <h6 class="heading">Quam nunc ut elit nunc molestie</h6>
    </div>
    <article id="points" class="group">
      <div class="two_third first">
        <h6 class="heading">Sapien tempor placerat</h6>
        <p>Luctus mauris lectus elementum nulla ac consectetuer sapien leo et arcu sed tempus tempor orci vestibulum volutpat eleifend arcu nunc vitae lacus sit amet sem consequat ullamcorper vivamus quis risus ut turpis sagittis venenatis.</p>
        <p>Volutpat et aliquam sed magna duis nibh dui porttitor eu rhoncus ut convallis eu eros in condimentum placerat.</p>
        <ul class="nospace group">
          <li><span>1</span> Nulla bibendum in erat</li>
          <li><span>2</span> Enim interdum a aliquam</li>
          <li><span>3</span> Sed commodo bibendum justo</li>
          <li><span>4</span> Sed pretium elit sed</li>
          <li><span>5</span> Nisi aliquam dolor urna</li>
          <li><span>6</span> Interdum ut dignissim eget</li>
          <li><span>7</span> Sagittis eget eros integer</li>
          <li><span>8</span> Velit mi facilisis eget</li>
        </ul>
      </div>
      <div class="one_third last"><a class="imgover" href="#"><img src="images/demo/348x394.png" alt=""></a></div>
    </article>
    ################################################################################################
  </section>
</div> -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- <div class="wrapper row2">
  <section class="hoc container clear"> 
    ################################################################################################
    <div class="sectiontitle">
      <p class="nospace font-xs">Odio duis ut est quis nisl consequat</p>
      <h6 class="heading">Gravida donec non erat eget</h6>
    </div>
    <ul id="latest" class="nospace group sd-third">
      <li class="one_third first">
        <article>
          <figure><a class="imgover" href="#"><img src="images/demo/348x261.png" alt=""></a>
            <figcaption>
              <ul class="nospace meta clear">
                <li><i class="fas fa-user"></i> <a href="#">Admin</a></li>
                <li>
                  <time datetime="2045-04-06T08:15+00:00">06 Apr 2045</time>
                </li>
              </ul>
              <h6 class="heading"><a href="#">Elit pellentesque dapibus</a></h6>
            </figcaption>
          </figure>
          <p>Justo massa adipiscing a convallis ultricies luctus et dolor aliquam nulla aenean facilisis ullamcorper diam nunc pede nulla iaculis quis lacinia ac adipiscing.</p>
        </article>
      </li>
      <li class="one_third">
        <article>
          <figure><a class="imgover" href="#"><img src="images/demo/348x261.png" alt=""></a>
            <figcaption>
              <ul class="nospace meta clear">
                <li><i class="fas fa-user"></i> <a href="#">Admin</a></li>
                <li>
                  <time datetime="2045-04-05T08:15+00:00">05 Apr 2045</time>
                </li>
              </ul>
              <h6 class="heading"><a href="#">Quis ligula morbi quam</a></h6>
            </figcaption>
          </figure>
          <p>Semper mattis nulla cursus lorem ut gravida tempor massa massa porta libero at scelerisque et arcu nulla facilisi aenean fringilla imperdiet felis mauris.</p>
        </article>
      </li>
      <li class="one_third">
        <article>
          <figure><a class="imgover" href="#"><img src="images/demo/348x261.png" alt=""></a>
            <figcaption>
              <ul class="nospace meta clear">
                <li><i class="fas fa-user"></i> <a href="#">Admin</a></li>
                <li>
                  <time datetime="2045-04-04T08:15+00:00">04 Apr 2045</time>
                </li>
              </ul>
              <h6 class="heading"><a href="#">Hendrerit ligula eu diam</a></h6>
            </figcaption>
          </figure>
          <p>Ac lectus sed ultricies augue congue nibh donec convallis elementum leo nullam dignissim varius ante fusce pharetra sodales arcu sed rutrum ipsum a ipsum.</p>
        </article>
      </li>
    </ul>
    ################################################################################################
  </section>
</div> -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- <div class="wrapper row4">
  <footer id="footer" class="hoc clear"> 
    ################################################################################################
    <div class="one_quarter first">
      <h6 class="heading">Praesent id aliquam</h6>
      <p>Non tellus nec sapien lobortis lobortis mauris egestas massa ac cursus pellentesque leo risus convallis nulla et fringilla sapien magna sit amet magna aliquam tempus praesent sit amet neque sed lobortis nulla facilisi [<a href="#">&hellip;</a>]</p>
      <ul class="faico clear">
        <li><a class="faicon-facebook" href="#"><i class="fab fa-facebook"></i></a></li>
        <li><a class="faicon-google-plus" href="#"><i class="fab fa-google-plus-g"></i></a></li>
        <li><a class="faicon-linkedin" href="#"><i class="fab fa-linkedin"></i></a></li>
        <li><a class="faicon-twitter" href="#"><i class="fab fa-twitter"></i></a></li>
        <li><a class="faicon-vk" href="#"><i class="fab fa-vk"></i></a></li>
      </ul>
    </div>
    <div class="one_quarter">
      <h6 class="heading">Rutrum amet sodales</h6>
      <ul class="nospace linklist">
        <li><a href="#">Nulla tincidunt magna</a></li>
        <li><a href="#">Vel iaculis mollis mi</a></li>
        <li><a href="#">Lacus tincidunt diam ac</a></li>
        <li><a href="#">Varius purus justo pretium</a></li>
        <li><a href="#">Nunc proin tortor elit</a></li>
      </ul>
    </div>
    <div class="one_quarter">
      <h6 class="heading">At feugiat in diam</h6>
      <p class="nospace btmspace-15">In vestibulum dolor et augue fusce neque enim scelerisque at fermentum.</p>
      <form action="#" method="post">
        <fieldset>
          <legend>Newsletter:</legend>
          <input class="btmspace-15" type="text" value="" placeholder="Name">
          <input class="btmspace-15" type="text" value="" placeholder="Email">
          <button class="btn" type="submit" value="submit">Submit</button>
        </fieldset>
      </form>
    </div>
    <div class="one_quarter last">
      <h6 class="heading">Sed imperdiet pharetra</h6>
      <ul class="nospace linklist">
        <li>
          <article>
            <h6 class="nospace font-x1"><a href="#">Massa nam nulla augue</a></h6>
            <time class="font-xs block btmspace-10" datetime="2045-04-06">Friday, 6<sup>th</sup> April 2045</time>
            <p class="nospace">Faucibus nec lacinia quis ornare a eros pellentesque in orci vitae</p>
          </article>
        </li>
        <li>
          <article>
            <h6 class="nospace font-x1"><a href="#">Velit vehicula auctor</a></h6>
            <time class="font-xs block btmspace-10" datetime="2045-04-05">Thursday, 5<sup>th</sup> April 2045</time>
            <p class="nospace">Pellentesque pulvinar vestibulum bibendum blandit lectus pretium</p>
          </article>
        </li>
      </ul>
    </div>
    ################################################################################################
  </footer>
</div> -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- <div class="wrapper row5">
  <div id="copyright" class="hoc clear"> 
    ################################################################################################
    <p class="fl_left">Copyright &copy; 2018 - All Rights Reserved - <a href="#">Domain Name</a></p>
    <p class="fl_right">Template by <a target="_blank" href="https://www.os-templates.com/" title="Free Website Templates">OS Templates</a></p>
    ################################################################################################
  </div>
</div>
################################################################################################
################################################################################################
################################################################################################
<a id="backtotop" href="#top"><i class="fas fa-chevron-up"></i></a> -->

<!-- LoginModal-->
<div id="LoginModal" class="modal fade">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">
				<div class="avatar">
				</div>				
				<h4 class="modal-title">AirTnT에 오신걸 환영합니다</h4>	
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form action="login" method="post">
					<div class="form-group">
						<c:if test="${empty value}">		
							<input type="text" class="form-control" name="member_id" placeholder="ID" required="required">
						</c:if>
						<c:if test="${not empty value}">
							<input type="text" class="form-control" name="member_id" placeholder="ID" required="required" value="${value}">		
						</c:if>
					</div>
					<div class="form-group">
						<input type="password" class="form-control" name="passwd" placeholder="Password" required="required">	
					</div>        
					<div class="form-group">
						<button type="submit" class="btn btn-primary btn-lg btn-block login-btn">로그인</button>
					</div>
					<div class="form-group">
						<c:if test="${empty value}">			
							<input type="checkbox" name="saveId">
						</c:if>	
						<c:if test="${not empty value}">
							<input type="checkbox" name="saveId" checked>
						</c:if>
						<p>아이디 기억하기</p>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<a href="findMember">Forgot Password?</a>
			</div>
		</div>
	</div>
</div> 
<!-- SignUpModal-->
<div id="SignUpModal" class="modal fade">
	<div class="modal-dialog modal-lg modal-login ">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">회 원 가 입</h4>	
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form action="signUp" method="post">
					<div class="form-group">
						<input type="text" class="form-control" name="member_id" placeholder="ID" required="required">		
					</div>
					<div class="form-group">
						<input type="password" class="form-control" name="passwd" placeholder="Password" required="required">	
					</div>        
					<div class="form-group">
						<input type="text" class="form-control" name="member_name" placeholder="이름" required="required">	
					</div>
					<div class="form-group">
						<input type="text" class="form-control" name="birth" placeholder="생년월일 (8자리)" required="required">	
					</div>
					<div class="form-group">
						<input type="text" class="form-control" name="tel" placeholder="연락처(11자리)" required="required">	
					</div>
					<div class="form-group">
						<label><input type="checkbox" class="center" name="gender" value="1" checked="checked"> 남</label>
      					<label><input type="checkbox" class="center" name="gender" value="2"> 여</label>
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-primary btn-lg btn-block login-btn" style="font-size: 15px">동의 및 계속하기</button>
					</div>
				</form>
			</div>
			<div class="modal-footer">
						<p>위의 동의 및 계속하기 버튼을 선택하면, 에어티앤티의 서비스 약관, 결제 서비스 약관, 개인정보 처리방침, 차별 금지 정책에 동의하는 것입니다.</p>
			</div>
		</div>
	</div>
</div>    
</body>
</html>