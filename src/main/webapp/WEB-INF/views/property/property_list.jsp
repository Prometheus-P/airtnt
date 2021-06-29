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
<title>AirTnT/숙소검색(키워드:${param.addressKey})</title>
<meta charset="utf-8">
<script type="text/javascript">
function setPropertyTypeFilter(propertyTypeId){
	var propertyTypeTag = document.getElementById("propertyType-" + propertyTypeId);
	var subPropertyTypeTagArray = document.getElementsByName("subPropertyType");
	for(var i = 0; i < subPropertyTypeTagArray.length; i++){
		var subPropertyTypeTag = subPropertyTypeTagArray[i];
		var id = subPropertyTypeTag.getAttribute("id");
		if(id.split('-')[1] == propertyTypeId){
			if(propertyTypeTag.getAttribute("checked") == "checked") {
				subPropertyTypeTag.removeAttribute("disabled");
			} else {
				subPropertyTypeTag.setAttribute("disabled", "disabled");
			}
		}
	}
	
	if(propertyTypeTag.getAttribute("checked") == "checked") {
		propertyTypeTag.removeAttribute("checked");
	} else {
		propertyTypeTag.setAttribute("checked", "checked");
	}
}
</script>

<!-- drop down -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>

</head>
<body id="top">
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- Top Background Image Wrapper -->

<!-- 상단 로그인 바 -->
<jsp:include page="/WEB-INF/views/top.jsp"/>

<form class="d-flex" action="<c:url value='/property/search'/>" method="get">
<!-- 검색 네비게이션 바 -->
<div id="pageintro" class="hoc clear justify-content-center" style="padding-top: 1vh; padding-bottom: 1vh;"> 
    <!-- ################################################################################################ -->
	<div class="position-absolute top-0 start-50 translate-middle-x">
	  <nav id="mainnav" class="navbar navbar-light">
	    <div class="container-fluid" >
	      <input name="addressKey" class="form-control me-2" type="search" 
	      placeholder="위치" value="${param.addressKey}"
	      aria-label="Search" style="height: 50px; width: 300px; font-size: 20px">
	      <button class="btn btn-primary" type="submit"
	      style="border: 0px; height: 50px; width: 100px; font-size: 20px">검색</button>
	    </div>
	  </nav>
	</div>
</div>

<!-- 검색 필터 -->
<div class="wrapper row1" style="height: 100px">
  <section class="hoc container clear" style="padding-top: 20px">
  
      <!-- 숙소 유형 검색 필터 -->
      <div class="one_quarter first" >
        
        <div class="btn-group">
        
          <button class="btn btn-secondary btn-lg dropdown-toggle" type="button"
          id="dropdownMenuClickableInside" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"
          style="width: 200px; height: 50px; font-size: 20px">숙소 유형</button>
          
          <ul class="dropdown-menu list-group" aria-labelledby="dropdownMenuClickableInside">
            <c:forEach var="propertyType" items="${propertyTypes}" varStatus="status">
              <li class="list-group-item">
                <!-- Split dropend button -->
                <div class="form-check form-check-inline">
                  <input id="propertyType-${propertyType.id}" class="form-check-input"
                  type="checkbox" name="propertyType" value="${propertyType.id}"
                  onchange="setPropertyTypeFilter(${propertyType.id})">
                  <label class="form-check-label">${propertyType.name} 전체</label>
                </div>
                
                <button class="btn btn-primary dropdown-toggle" type="button" data-bs-toggle="collapse"
                data-bs-target="#collapseExample${propertyType.id}" aria-expanded="false" aria-controls="collapseExample${propertyType.id}">
                   ${propertyType.name} 세부유형
                </button>
                <div class="collapse" id="collapseExample${propertyType.id}">
                  <c:forEach var="subPropertyType" items="${propertyType.subPropertyTypes}">
                    <div class="form-check form-check-inline">
                      <input id="subPropertyType-${propertyType.id}-${subPropertyType.id}" class="form-check-input"
                      type="checkbox" name="subPropertyType" value="${subPropertyType.id}">
                      <label class="form-check-label">${subPropertyType.name}</label>
                    </div>
                  </c:forEach>
                </div>
              </li>
            </c:forEach>
          </ul>
          
        </div>
        
      </div>
      
      <!-- 방 유형 검색 필터 -->
      <div class="one_quarter">
      
        <div class="btn-group">
        
          <button class="btn btn-secondary btn-lg dropdown-toggle" type="button"
          id="dropdownMenuClickableInside" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"
          style="width: 200px; height: 50px; font-size: 20px">방 유형</button>
          
          <ul class="dropdown-menu list-group" aria-labelledby="dropdownMenuClickableInside">
            <c:forEach var="roomType" items="${roomTypes}">
              <li class="list-group-item" style="font-size: 20px">
                <div class="form-check form-check-inline">
                  <input class="form-check-input" type="checkbox" name="roomType" value="${roomType.id}">
                  <label class="form-check-label">${roomType.name}</label>
                </div>
              </li>
            </c:forEach>
          </ul>
          
        </div>
      </div>
      
      <!-- 편의시설 검색 필터 -->
      <div class="one_quarter">
      
        <div class="btn-group">
        
          <button class="btn btn-secondary btn-lg dropdown-toggle" type="button"
          id="dropdownMenuClickableInside" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"
          style="width: 200px; height: 50px; font-size: 20px">편의시설</button>
          
          <div class="dropdown-menu" aria-labelledby="dropdownMenuClickableInside" style="font-size: 15px">
            <c:forEach var="amenityType" items="${amenityTypes}">
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" name="amenityType" value="${amenityType.id}">
                <label class="form-check-label">${amenityType.name}</label>
              </div>
            </c:forEach>
          </div>
          
        </div>
      </div>
      
      <!-- 인원, 침대 수, 가격 검색 필터 -->
      <div class="one_quarter">
        <div class="btn-group">
        
          <button class="btn btn-secondary btn-lg dropdown-toggle" type="button"
          id="dropdownMenuClickableInside" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"
          style="width: 200px; height: 50px; font-size: 20px">
            기타사항
          </button>
          
          
          <div class="dropdown-menu list-group" aria-labelledby="dropdownMenuClickableInside" style="width: 400px;">
            <div class="btn-group list-group-item" style="font-size: 20px; padding-bottom: 50px; padding-left: 20px">
              <h3>최대 인원</h3>
              <input id="increase-guest" type="button" class="btn" value="-">
              <input id="guest-count" class="form-control btn" type="number" name="guestCount"
                value="${empty param.guestCount ? 0 : param.guestCount}" min="0"
                readonly style="width: 50px;">
              <input id="decrease-guest" type="button" class="btn" value="+">
            </div>
            <div class="btn-group list-group-item" style="font-size: 20px; padding-bottom: 50px; padding-left: 20px">
              <h3>침대 수</h3>
              <input id="increase-bed" type="button" class="btn" value="-">
              <input id="bed-count" class="form-control btn" type="number" name="bedCount"
                value="${empty param.bedCount ? 0 : param.bedCount}" min="0"
                readonly style="width: 50px;">
              <input id="decrease-bed" type="button" class="btn" value="+">
            </div>
            <div class="list-group-item form-check form-check-inline" style="font-size: 20px;">
              <h3>가격 범위</h3>
              ₩<input id="min-price" class="form-control form-check-label nobr" type="number" name="minPrice"
                value="${empty param.minPrice ? 0 : param.guestCount}"
                min="0" style="width: 100px; display: inline;"> ~&nbsp;
              ₩<input id="max-price" class="form-control form-check-label nobr" type="number" name="maxPrice"
                value="${empty param.maxPrice ? (empty param.minPrice ? 0 : param.minPrice + 10000) : param.maxPrice}"
                min="0" style="width: 100px; display: inline;">
            </div>
          </div>
        </div>
      </div>
  </section>
</div>

</form>

<!-- 메인 화면 -->
<div class="wrapper row3">
  <div class="hoc container clear"> 
    <!-- main body -->
    <!-- ################################################################################################ -->
    <div class="content"> 
      <!-- ################################################################################################ -->
      <h2>${param.addressKey} 주변의 숙소 목록</h2>
      <!-- ################################################################################################ -->
      <div class="group btmspace-50 demo">
      
        <!-- 숙소 리스트 -->
        <div class="one_half first">
	        <div class="content"> 
	      <!-- ################################################################################################ -->
	      <div id="gallery">
	        <figure>
	          <header class="heading"></header>
	          <hr>
	          <!-- 숙소리스트 영역 -->
	          <ul class="nospace clear" >
	            <c:forEach var="property" items="${properties}">
	            <li style="height: 150px;">
	              <div class="one_third first" >
	                <a href="<c:url value='/property/detail?propertyId=${property.id}'/>"><img src="${property.images.get(0).path}" alt="" ></a>
	              </div>
	              <div class="two_third">
	                <h2><a href="<c:url value='/property/detail?propertyId=${property.id}'/>">${property.name}</a></h2>
	                <h4>${property.propertyType.name}/${property.subPropertyType.name} ${property.roomType.name}</h4>
	                <h4>${property.address}</h4>
	              </div>
	            </li>
	            <hr>
	            </c:forEach>
	          </ul>
	          <figcaption>Gallery Description Goes Here</figcaption>
	        </figure>
	      </div>
	    </div>
        
        </div>
        
        <!-- 카카오맵 -->
        <div class="one_half">
          <div id="map" style="width:600px;height:600px;"></div>
          <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=62b11c585fb341eec39dbc28ac9bad71"></script>
          <script type="text/javascript" src="/resources/map/kakao_map_test.js"></script>
        </div>
      </div>
    </div>
  </div>
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
<!-- <script src="../layout/scripts/jquery.min.js"></script>
<script src="../layout/scripts/jquery.backtotop.js"></script>
<script src="../layout/scripts/jquery.mobilemenu.js"></script> -->

</body>
</html>