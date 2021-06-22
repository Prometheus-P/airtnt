<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<!--
Template Name: Nekmit
Author: <a href="https://www.os-templates.com/">OS Templates</a>
Author URI: https://www.os-templates.com/
Copyright: OS-Templates.com
Licence: Free to use under our free template licence terms
Licence URI: https://www.os-templates.com/template-terms
-->
<html lang="">
<!-- To declare your language - read more here: https://www.w3.org/International/questions/qa-html-language-declarations -->
<head>
<title>AirTnT/숙소검색</title>
<meta charset="utf-8">

</head>
<body id="top">
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- Top Background Image Wrapper -->

<!-- 검색, 로그인 네비게이션 바 -->
<jsp:include page="/nav_bar.jsp"/>

<%-- <div class="bgded overlay padtop" style="background-image:url('<c:url value='/resources/images/demo/backgrounds/01.png'/>')"> 
  <!-- ################################################################################################ -->
  <!-- ################################################################################################ -->
  <!-- ################################################################################################ -->
  <header id="header" class="hoc clear">
    <div id="logo" class="fl_left"> 
      <!-- ################################################################################################ -->
      <h1><a href="index">Nekmit</a></h1>
      <!-- ################################################################################################ -->
    </div>
    <nav id="mainav" class="fl_right"> 
      <!-- ################################################################################################ -->
      <ul class="clear">
        <li><a href="index">Home</a></li>
        <li class="active"><a class="drop" href="#">Pages</a>
          <ul>
            <li><a href="gallery.html">Gallery</a></li>
            <li><a href="full-width.html">Full Width</a></li>
            <li><a href="sidebar-left.html">Sidebar Left</a></li>
            <li><a href="sidebar-right.html">Sidebar Right</a></li>
            <li class="active"><a href="basic-grid.html">Basic Grid</a></li>
            <li><a href="font-icons.html">Font Icons</a></li>
          </ul>
        </li>
        <li><a class="drop" href="#">Dropdown</a>
          <ul>
            <li><a href="#">Level 2</a></li>
            <li><a class="drop" href="#">Level 2 + Drop</a>
              <ul>
                <li><a href="#">Level 3</a></li>
                <li><a href="#">Level 3</a></li>
                <li><a href="#">Level 3</a></li>
              </ul>
            </li>
            <li><a href="#">Level 2</a></li>
          </ul>
        </li>
        <li><a href="#">Link Text</a></li>
        <li><a href="#">Link Text</a></li>
        <li><a href="#">Link Text</a></li>
      </ul>
      <!-- ################################################################################################ -->
    </nav>
  </header>
  <!-- ################################################################################################ -->
  <!-- ################################################################################################ -->
  <!-- ################################################################################################ -->
  <div id="breadcrumb" class="hoc clear"> 
    <!-- ################################################################################################ -->
    <ul>
      <li><a href="#">Home</a></li>
      <li><a href="#">Lorem</a></li>
      <li><a href="#">Ipsum</a></li>
      <li><a href="#">Dolor</a></li>
    </ul>
    <!-- ################################################################################################ -->
  </div>
  <!-- ################################################################################################ -->
</div> --%>
<!-- End Top Background Image Wrapper -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- <div class="wrapper row1">
  <section id="ctdetails" class="hoc clear"> 
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
  </section>
</div> -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<div class="wrapper row3">
  <main class="hoc container clear"> 
    <!-- main body -->
    <!-- ################################################################################################ -->
    <div class="content"> 
      <!-- ################################################################################################ -->
      <h2>Half</h2>
      <!-- ################################################################################################ -->
      <div class="group btmspace-50 demo">
        <div class="one_half first">
	        <div class="content"> 
	      <!-- ################################################################################################ -->
	      <div id="gallery">
	        <figure>
	          <header class="heading">Gallery Title Goes Here</header>
	          <hr>
	          <!-- 숙소리스트 영역 -->
	          <ul class="nospace clear" >
	            <c:forEach var="property" items="${properties}">
	            <li style="height: 150px;">
	              <div class="one_third first" >
	                <a href="<c:url value='/room/detail'/>"><img src="/resources/room_img/room_ex.jpg" alt="" ></a>
	              </div>
	              <div class="two_third">
	                <h2><a href="<c:url value='/room/detail'/>">${property.name}</a></h2>
	                <h4>${property.propertyTypeName}/${property.subPropertyTypeName} ${property.roomTypeName}</h4>
	                <h4>${property.address}</h4>
	              </div>
	            </li>
	            <hr>
	            </c:forEach>
	          </ul>
	          <figcaption>Gallery Description Goes Here</figcaption>
	        </figure>
	      </div>
	      <!-- ################################################################################################ -->
	      <!-- ################################################################################################ -->
	      <!-- <nav class="pagination">
	        <ul>
	          <li><a href="#">&laquo; Previous</a></li>
	          <li><a href="#">1</a></li>
	          <li><a href="#">2</a></li>
	          <li><strong>&hellip;</strong></li>
	          <li><a href="#">6</a></li>
	          <li class="current"><strong>7</strong></li>
	          <li><a href="#">8</a></li>
	          <li><a href="#">9</a></li>
	          <li><strong>&hellip;</strong></li>
	          <li><a href="#">14</a></li>
	          <li><a href="#">15</a></li>
	          <li><a href="#">Next &raquo;</a></li>
	        </ul>
	      </nav> -->
	      <!-- ################################################################################################ -->
	    </div>
        
        </div>
        <div class="one_half">지ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ도</div>
      </div>
      </div>
      </main>
      </div>
      
      
      
      <!-- ################################################################################################ -->
     <!--  <h2>Quarter</h2>
      ################################################################################################
      <div class="group btmspace-50 demo">
        <div class="one_quarter first">1/4</div>
        <div class="one_quarter">1/4</div>
        <div class="one_quarter">1/4</div>
        <div class="one_quarter">1/4</div>
      </div>
      <div class="group btmspace-50 demo">
        <div class="one_quarter first">1/4</div>
        <div class="one_quarter">1/4</div>
        <div class="two_quarter">2/4 or 1/2</div>
      </div>
      <div class="group btmspace-50 demo">
        <div class="one_quarter first">1/4</div>
        <div class="three_quarter">3/4</div>
      </div>
      ################################################################################################
      <h2>Third</h2>
      ################################################################################################
      <div class="group btmspace-50 demo">
        <div class="one_third first">1/3</div>
        <div class="one_third">1/3</div>
        <div class="one_third">1/3</div>
      </div>
      <div class="group demo">
        <div class="one_third first">1/3</div>
        <div class="two_third">2/3</div>
      </div>
      ################################################################################################
    </div>
    ################################################################################################
    / main body
    <div class="clear"></div>
  </main>
</div> -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<div class="wrapper row4">
  <footer id="footer" class="hoc clear"> 
    <!-- ################################################################################################ -->
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
    <!-- ################################################################################################ -->
  </footer>
</div>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<div class="wrapper row5">
  <div id="copyright" class="hoc clear"> 
    <!-- ################################################################################################ -->
    <p class="fl_left">Copyright &copy; 2018 - All Rights Reserved - <a href="#">Domain Name</a></p>
    <p class="fl_right">Template by <a target="_blank" href="https://www.os-templates.com/" title="Free Website Templates">OS Templates</a></p>
    <!-- ################################################################################################ -->
  </div>
</div>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<a id="backtotop" href="#top"><i class="fas fa-chevron-up"></i></a>
<!-- JAVASCRIPTS -->
<!-- <script src="../layout/scripts/jquery.min.js"></script>
<script src="../layout/scripts/jquery.backtotop.js"></script>
<script src="../layout/scripts/jquery.mobilemenu.js"></script> -->
</body>
</html>