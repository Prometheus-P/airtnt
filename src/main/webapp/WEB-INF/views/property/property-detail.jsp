<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<title>숙소/상세보기(숙소명:${property.name})</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="/resources/layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<script type="text/javascript">
function loginCheck(){
	if("${member_id}" == ""){
		document.querySelector("a#login-button").click();
		return false;
	}
	return true;
}

function setTotalPrice(){
	var checkInDateStr = document.getElementById("check_in_date").value;
	var checkOutDateStr = document.getElementById("check_out_date").value;
	var guestCount = document.getElementById("guest_count").value;
	//console.log(checkInDateStr);
	//console.log(checkOutDateStr);
	if(checkInDateStr == "" || checkOutDateStr == ""){
		return;
	}
	var checkInDate = new Date(checkInDateStr);
	var checkOutDate = new Date(checkOutDateStr);
	//console.log(checkInDate);
	//console.log(checkOutDate);
	
	var diff = checkOutDate - checkInDate;
	//console.log(diff);
	var dayCount = diff / (24*60*60*1000);
	//console.log(dayCount);
	var totalPrice = guestCount * dayCount * ${property.price};
	var totalPriceStr = new Intl.NumberFormat('ko-KR', {style: 'currency',currency: 'KRW', minimumFractionDigits: 0}).format(totalPrice);
	
	document.getElementById("day_count").value = dayCount;
	document.getElementById("total_price").value = totalPrice;
	document.getElementById("price_disp").innerHTML = totalPriceStr;
}
</script>
</head>
<body id="top">

<jsp:include page="/WEB-INF/views/top.jsp"/>

<!-- 위시리스트 모달은 jQuery 라이브러리 적용을 위해서 top.jsp 아래 둬야함 -->
<c:import url="/WEB-INF/views/property/wish-modal.jsp"/>

<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- Top Background Image Wrapper -->
<!-- <div class="bgded overlay padtop" style="background-image:url('../images/demo/backgrounds/01.png');"> 
  ################################################################################################
  ################################################################################################
  ################################################################################################
  <header id="header" class="hoc clear">
    <div id="logo" class="fl_left"> 
      ################################################################################################
      <h1><a href="/">Nekmit</a></h1>
      ################################################################################################
    </div>
    <nav id="mainav" class="fl_right"> 
      ################################################################################################
      <ul class="clear">
        <li><a href="../index.html">Home</a></li>
        <li class="active"><a class="drop" href="#">Pages</a>
          <ul>
            <li><a href="gallery.html">Gallery</a></li>
            <li class="active"><a href="full-width.html">Full Width</a></li>
            <li><a href="sidebar-left.html">Sidebar Left</a></li>
            <li><a href="sidebar-right.html">Sidebar Right</a></li>
            <li><a href="basic-grid.html">Basic Grid</a></li>
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
      ################################################################################################
    </nav>
  </header>
  ################################################################################################
  ################################################################################################
  ################################################################################################
  <div id="breadcrumb" class="hoc clear"> 
    ################################################################################################
    <ul>
      <li><a href="#">Home</a></li>
      <li><a href="#">Lorem</a></li>
      <li><a href="#">Ipsum</a></li>
      <li><a href="#">Dolor</a></li>
    </ul>
    ################################################################################################
  </div>
  ################################################################################################
</div> -->
<!-- End Top Background Image Wrapper -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<div class="wrapper row3" style="height: 8rem">
  <div class="container position-relative">
    <div class="position-absolute end-0 bottom-0" >
      <!-- Button trigger modal -->
      <a href="" class="trigger-btn wish-button" id="wishProperty-${property.id}"
      data-toggle="modal" style="font-size: 20px">
        <span class="wish-text"></span>
        <!-- 빈 하트 -->
        <img class="heart" src="" style="width: 3rem; height: 3rem">
      </a>
      <script type="text/javascript">
      	// 화면 로드 시 초기화하는 과정
      	initWish("${property.id}", "${property.wishListId}", "${property.wished}");
      </script>
    </div>
  </div>
</div>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<div class="wrapper row3" >
  
  <main class="hoc clear"> 
    <!-- main body -->
    <!-- ################################################################################################ -->
    <div class="container" style="padding-top: 0">
      
      
      <!-- 숙소 이미지 -->
      <div class="one_half first">
        <img class="imgl borderedbox inspace-5"
          <c:if test='${not empty property.images}'>
            src="${property.images.get(0).path}"
          </c:if>
         alt="" style="height: 41rem;">
      </div>
      <div class="one_half">
        <c:forEach var="image" items="${property.images}" begin="1" end="4" varStatus="status">
          <c:choose>
            <c:when test="${status.count % 2 == 1}">
              <div class="one_half first">
                <img class="imgl borderedbox inspace-5 " src="${image.path}" alt=""
                style="height: 20rem;">
              </div>
            </c:when>
            <c:otherwise>
              <div class="one_half">
                <img class="imgl borderedbox inspace-5" src="${image.path}" alt=""
                style="height: 20rem;">
              </div>
            </c:otherwise>
          </c:choose>
        </c:forEach>
      </div>
      
      
      <!-- 숙소 상세정보 나열 구역 -->
	  <div class="two_third first">
	        <div>
	          <h1>숙소 유형</h1>
	          <p style="font-size: 20px">
	            ${property.propertyType.name}/${property.subPropertyType.name}<br>
	            ${property.roomType.name}
	          </p>
	        </div>
	        
	        <hr>
	        
	        <div>
	          <h1>상세 설명</h1>
	          <p style="font-size: 20px">
	            ${property.propertyDesc}
	          </p>
	        </div>
	        
	        <hr>
	        
	        <div>
	          <h1>편의 시설</h1><br>
	          <c:forEach var="amenity" items="${property.amenities}">
	            <ul style="font-size: 20px">
	              <li>
	                ${amenity.amenityType.name}
	              </li>
	            </ul>
	          </c:forEach>
	        </div>
	        
	        <hr>
	        
	       <div>
	        <h1>대앳그을</h1>
	        <ul>
	          <li>
	            <article>
	              <header>
	                <figure class="avatar"><img src="/resources/images/demo/avatar.png" alt=""></figure>
	                <address>
	                By <a href="#">A Name</a>
	                </address>
	                <time datetime="2045-04-06T08:15+00:00">Friday, 6<sup>th</sup> April 2045 @08:15:00</time>
	              </header>
	              <div class="comcont">
	                <p>This is an example of a comment made on a post. You can either edit the comment, delete the comment or reply to the comment. Use this as a place to respond to the post or to share what you are thinking.</p>
	              </div>
	            </article>
	          </li>
	          <li>
	            <article>
	              <header>
	                <figure class="avatar"><img src="/resources/images/demo/avatar.png" alt=""></figure>
	                <address>
	                By <a href="#">A Name</a>
	                </address>
	                <time datetime="2045-04-06T08:15+00:00">Friday, 6<sup>th</sup> April 2045 @08:15:00</time>
	              </header>
	              <div class="comcont">
	                <p>This is an example of a comment made on a post. You can either edit the comment, delete the comment or reply to the comment. Use this as a place to respond to the post or to share what you are thinking.</p>
	              </div>
	            </article>
	          </li>
	          <li>
	            <article>
	              <header>
	                <figure class="avatar"><img src="/resources/images/demo/avatar.png" alt=""></figure>
	                <address>
	                By <a href="#">A Name</a>
	                </address>
	                <time datetime="2045-04-06T08:15+00:00">Friday, 6<sup>th</sup> April 2045 @08:15:00</time>
	              </header>
	              <div class="comcont">
	                <p>This is an example of a comment made on a post. You can either edit the comment, delete the comment or reply to the comment. Use this as a place to respond to the post or to share what you are thinking.</p>
	              </div>
	            </article>
	          </li>
	        </ul>
	        
	      </div>
	      
          <!-- 최근 목록 -->
          <h2>최근 본 숙소</h2>
          <div id="carouselControls-recent" class="carousel slide" data-bs-interval="false">
            <div class="carousel-inner" style="margin-left: 10%; width: 80%">
              <c:forEach var="recentProperty" items="${recentProperties}" varStatus="status">
                <c:if test="${status.count % 3 == 1}">
                <div class="carousel-item <c:if test='${status.count == 1}'>active</c:if>">
                </c:if>
                  <div class="one_third <c:if test='${status.count % 3 == 1}'>first</c:if>">
                    <img
                      <c:if test='${recentProperty.images != null && recentProperty.images.size() > 0}'>
                        src="${recentProperty.images.get(0).path}"
                      </c:if>
                    class="d-block w-100" alt="">
                    <span>${recentProperty.name}</span>
                  </div>
                <c:if test="${status.count % 3 == 0 || status.last}">
                </div>
                </c:if>
              </c:forEach>
            </div>
            <c:if test="${not empty recentProperties && recentProperties.size() > 3}">
              <button class="carousel-control-prev" type="button" data-bs-target="#carouselControls-recent"
              data-bs-slide="prev">
                <img src="https://img.icons8.com/fluent/48/000000/back.png"/>
                <!-- <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span> -->
              </button>
              <button class="carousel-control-next" type="button" data-bs-target="#carouselControls-recent"
              data-bs-slide="next">
                <img src="https://img.icons8.com/fluent/48/000000/forward.png"/>
                <!-- <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span> -->
              </button>
            </c:if>
          </div><!-- end of 최근 목록 -->
	   </div><!-- end of two_third first -->
	   <div class="one_third">
	     <!-- 
	       상세정보에서 넘어가는 예약정보
	       host id, guest id, day count, guest count, total price,
	       checkin date, checkout date
	      -->
	     <form action="<c:url value='/property/booking'/>" method="post" onsubmit="return loginCheck()">
	       <input type="hidden" name="propertyId" value="${property.id}">
	       <input type="hidden" name="hostId" value="${property.hostId}">
	       <input type="hidden" name="guestId" value="${sessionScope.member_id}">
	       <input id="day_count" type="hidden" name="dayCount">
	       <input id="total_price" type="hidden" name="totalPrice">
	       <ul class="list-group" style="font-size: 20px">
	         <li class="list-group-item">
	           <div class="one_third first">
	             체크인
	           </div>
	           <div class="two_third">
	             <input id="check_in_date" type="date" name="checkInDate" class="btmspace-15"
	             min="${tomorrow}" value="${tomorrow}"
	             onchange="javascript:setTotalPrice()">
	           </div>
	         </li>
	         <li class="list-group-item">
	           <div class="one_third first">
	             체크아웃
	           </div>
	           <div class="two_third">
	             <input id="check_out_date" type="date" name="checkOutDate" class="btmspace-15"
	             min="${dayAfterTomorrow}" value="${dayAfterTomorrow}"
	             onchange="javascript:setTotalPrice()">
	           </div>
	         </li>
	         <li class="list-group-item">
	           <div class="one_third first">
	             인원수
	           </div>
	           <div class="two_third">
	             <input id="guest_count" type="number" name="guestCount" class="btmspace-15"
	             min="1" max="${property.maxGuest}" value="1" 
	             onchange="javascript:setTotalPrice()">
	           </div>
	         </li>
	         <li class="list-group-item" style="font-size: 30px;color: blue">
	           총액 <span id="price_disp"></span>
 	           <script type="text/javascript">
	             setTotalPrice();
	           </script>
	         </li>
	         <li class="list-group-item">
	           <input class="btn btn-primary" type="submit"
	           style="font-size: 20px; width: 15rem" value="예약하기">
	           <a href="문의url?propertyId=${property.id}" class="btn btn-info"
	           style="font-size: 20px; width: 15rem">1:1 문의하기</a>
	         </li>
	       </ul>
	     </form>
	   </div>
	   
      
      <!-- <div class="scrollable">
        <table>
          <thead>
            <tr>
              <th>Header 1</th>
              <th>Header 2</th>
              <th>Header 3</th>
              <th>Header 4</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><a href="#">Value 1</a></td>
              <td>Value 2</td>
              <td>Value 3</td>
              <td>Value 4</td>
            </tr>
            <tr>
              <td>Value 5</td>
              <td>Value 6</td>
              <td>Value 7</td>
              <td><a href="#">Value 8</a></td>
            </tr>
            <tr>
              <td>Value 9</td>
              <td>Value 10</td>
              <td>Value 11</td>
              <td>Value 12</td>
            </tr>
            <tr>
              <td>Value 13</td>
              <td><a href="#">Value 14</a></td>
              <td>Value 15</td>
              <td>Value 16</td>
            </tr>
          </tbody>
        </table>
      </div> -->
<!--       <div id="comments">
        <h2>Comments</h2>
        <ul>
          <li>
            <article>
              <header>
                <figure class="avatar"><img src="../images/demo/avatar.png" alt=""></figure>
                <address>
                By <a href="#">A Name</a>
                </address>
                <time datetime="2045-04-06T08:15+00:00">Friday, 6<sup>th</sup> April 2045 @08:15:00</time>
              </header>
              <div class="comcont">
                <p>This is an example of a comment made on a post. You can either edit the comment, delete the comment or reply to the comment. Use this as a place to respond to the post or to share what you are thinking.</p>
              </div>
            </article>
          </li>
          <li>
            <article>
              <header>
                <figure class="avatar"><img src="../images/demo/avatar.png" alt=""></figure>
                <address>
                By <a href="#">A Name</a>
                </address>
                <time datetime="2045-04-06T08:15+00:00">Friday, 6<sup>th</sup> April 2045 @08:15:00</time>
              </header>
              <div class="comcont">
                <p>This is an example of a comment made on a post. You can either edit the comment, delete the comment or reply to the comment. Use this as a place to respond to the post or to share what you are thinking.</p>
              </div>
            </article>
          </li>
          <li>
            <article>
              <header>
                <figure class="avatar"><img src="../images/demo/avatar.png" alt=""></figure>
                <address>
                By <a href="#">A Name</a>
                </address>
                <time datetime="2045-04-06T08:15+00:00">Friday, 6<sup>th</sup> April 2045 @08:15:00</time>
              </header>
              <div class="comcont">
                <p>This is an example of a comment made on a post. You can either edit the comment, delete the comment or reply to the comment. Use this as a place to respond to the post or to share what you are thinking.</p>
              </div>
            </article>
          </li>
        </ul>
        <h2>Write A Comment</h2>
        <form action="#" method="post">
          <div class="one_third first">
            <label for="name">Name <span>*</span></label>
            <input type="text" name="name" id="name" value="" size="22" required>
          </div>
          <div class="one_third">
            <label for="email">Mail <span>*</span></label>
            <input type="email" name="email" id="email" value="" size="22" required>
          </div>
          <div class="one_third">
            <label for="url">Website</label>
            <input type="url" name="url" id="url" value="" size="22">
          </div>
          <div class="block clear">
            <label for="comment">Your Comment</label>
            <textarea name="comment" id="comment" cols="25" rows="10"></textarea>
          </div>
          <div>
            <input type="submit" name="submit" value="Submit Form">
            &nbsp;
            <input type="reset" name="reset" value="Reset Form">
          </div>
        </form>
      </div> -->
      <!-- ################################################################################################ -->
    </div>
    <!-- ################################################################################################ -->
    <!-- / main body -->
    <div class="clear"></div>
  </main>
</div>
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
<!-- <script src="/resources/layout/scripts/jquery.min.js"></script>
<script src="/resources/layout/scripts/jquery.backtotop.js"></script>
<script src="/resources/layout/scripts/jquery.mobilemenu.js"></script> -->
</body>
</html>