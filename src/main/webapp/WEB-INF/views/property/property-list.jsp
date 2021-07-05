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

<!-- drop down, popup, ... -->
<!-- <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
crossorigin="anonymous"></script> -->

<!-- <script src="/resources/script/wish-control.js"></script> -->

<!-- 검색필터 이벤트 처리와 초기화를 제어하는 커스텀 파일 -->
<script src="/resources/script/search-control.js"></script>

</head>
<body>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- Top Background Image Wrapper -->

<!-- 상단 로그인 바 -->
<c:import url="/WEB-INF/views/top.jsp"/>

<!-- 위시리스트 모달은 jQuery 라이브러리 적용을 위해서 top.jsp 아래 둬야함 -->
<c:import url="/WEB-INF/views/property/wish-modal.jsp"/>

<form action="<c:url value='/property/search'/>" method="get" onsubmit="setParametersOnSubmit()">
<!-- 검색 네비게이션 바 -->
<!-- <div id="pageintro" class="hoc clear justify-content-center" style="height: 10px"> -->
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
<!-- </div> -->

<!-- 검색 필터 -->
<div class="wrapper row1" style="height: 50px">
  <div class="hoc container clear position-relative" >
    <div class="position-absolute top-0 start-0">
      <input type="button" class="btn btn-secondary"
      value="전체 초기화" onclick="resetTags('all')">
    </div>
  </div>
</div>

<div class="wrapper row2" style="height: 100px">
  <div class="hoc container clear" style="padding-top: 20px">
  
      <!-- 숙소 유형 검색 필터 -->
      <div class="one_quarter first" >
        <div class="btn-group">
        
          <button class="btn btn-secondary btn-lg dropdown-toggle" type="button"
          id="dropdownMenuClickableInside-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"
          style="width: 200px; height: 50px; font-size: 20px">숙소 유형</button>
          
          <ul class="dropdown-menu list-group" aria-labelledby="dropdownMenuClickableInside-1">
            <c:forEach var="propertyType" items="${propertyTypes}">
              <li class="list-group-item">
                <!-- Split dropend button -->
                <div class="form-check form-check-inline">
                  <input type="checkbox" id="propertyType-${propertyType.id}"
                  class="form-check-input" name="propertyTypeId" value="${propertyType.id}"
                    <c:forEach var='tagAttribute' items='${propertyType.tagAttributes}'>
                      ${tagAttribute}="${propertyType.getTagAttributeMapValue(tagAttribute)}"
                    </c:forEach>
                  onchange="modSubPropertyTypes(this)">
                  <label class="form-check-label">${propertyType.name} 전체</label>
                </div>
                
                <button class="btn btn-primary dropdown-toggle" type="button" data-bs-toggle="collapse"
                data-bs-target="#collapse${propertyType.id}" aria-expanded="false" aria-controls="collapseExample${propertyType.id}">
                   ${propertyType.name} 세부유형
                </button>
                <div class="collapse" id="collapse${propertyType.id}">
                  <c:forEach var="subPropertyType" items="${propertyType.subPropertyTypes}">
                    <div class="form-check form-check-inline">
                      <input type="checkbox" id="subPropertyType-${propertyType.id}-${subPropertyType.id}"
                      class="form-check-input" name="subPropertyTypeId" value="${subPropertyType.id}"
                        <c:forEach var='tagAttribute' items='${subPropertyType.tagAttributes}'>
                          ${tagAttribute}="${subPropertyType.getTagAttributeMapValue(tagAttribute)}"
                        </c:forEach>
                      >
                      <label class="form-check-label">${subPropertyType.name}</label>
                    </div>
                  </c:forEach>
                </div>
              </li>
            </c:forEach>
            <li>
              <input type="button" class="btn btn-secondary"
              value="초기화" onclick="resetTags('propertyTypes')">
            </li>
          </ul>
        </div>
        
      </div>
      
      <!-- 방 유형 검색 필터 -->
      <div class="one_quarter">
      
        <div class="btn-group">
        
          <button class="btn btn-secondary btn-lg dropdown-toggle" type="button"
          id="dropdownMenuClickableInside-2" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"
          style="width: 200px; height: 50px; font-size: 20px">방 유형</button>
          
          <ul class="dropdown-menu list-group" aria-labelledby="dropdownMenuClickableInside-2">
            <c:forEach var="roomType" items="${roomTypes}">
              <li class="list-group-item" style="font-size: 20px">
                <div class="form-check form-check-inline">
                  <input type="checkbox" class="form-check-input" name="roomTypeId" value="${roomType.id}"
                    <c:forEach var='tagAttribute' items='${roomType.tagAttributes}'>
                      ${tagAttribute}="${roomType.getTagAttributeMapValue(tagAttribute)}"
                    </c:forEach>
                  >
                  <label class="form-check-label">${roomType.name}</label>
                </div>
              </li>
            </c:forEach>
            <li>
              <input type="button" class="btn btn-secondary"
              value="초기화" onclick="resetTags('roomTypes')">
            </li>
          </ul>
        </div>
      </div>
      
      <!-- 편의시설 검색 필터 -->
      <div class="one_quarter">
      
        <div class="btn-group">
        
          <button class="btn btn-secondary btn-lg dropdown-toggle" type="button"
          id="dropdownMenuClickableInside-3" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"
          style="width: 200px; height: 50px; font-size: 20px">편의시설</button>
          
          <div class="dropdown-menu" aria-labelledby="dropdownMenuClickableInside-3" style="font-size: 15px">
            <c:forEach var="amenityType" items="${amenityTypes}">
              <div class="form-check form-check-inline">
                <input type="checkbox" class="form-check-input" name="amenityTypeId" value="${amenityType.id}"
                  <c:forEach var='tagAttribute' items='${amenityType.tagAttributes}'>
                    ${tagAttribute}="${amenityType.getTagAttributeMapValue(tagAttribute)}"
                  </c:forEach>
                >
                <label class="form-check-label">${amenityType.name}</label>
              </div>
            </c:forEach>
            <input type="button" class="btn btn-secondary"
            value="초기화" onclick="resetTags('amenityTypes')">
          </div>
          
        </div>
      </div>
      
      <!-- 인원, 침대 수, 가격 검색 필터 -->
      <div class="one_quarter">
        <div class="btn-group">
        
          <button class="btn btn-secondary btn-lg dropdown-toggle" type="button"
          id="dropdownMenuClickableInside-4" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"
          style="width: 200px; height: 50px; font-size: 20px">
            기타사항
          </button>
          
          <div class="dropdown-menu list-group" aria-labelledby="dropdownMenuClickableInside-4" style="width: 500px;">
            <div class="btn-group list-group-item" style="padding-bottom: 50px; padding-left: 20px">
              <h3>인원</h3>
              <input id="decrease-guest" type="button" class="btn"
              value="-" onclick="changeCount(this)" style="font-size: 20px;">
              <input id="guest-count" class="form-control btn" type="number" name="guestCount"
                value="${param.guestCount}" min="1"
                readonly style="width: 80px; height: 44px;font-size: 30px;">
              <input id="increase-guest" type="button" class="btn"
              value="+" onclick="changeCount(this)" style="font-size: 20px;">
            </div>
            <div class="btn-group list-group-item" style="padding-bottom: 50px; padding-left: 20px">
              <h3>침대 수</h3>
              <input id="decrease-bed" type="button" class="btn"
              value="-" onclick="changeCount(this)" style="font-size: 20px;">
              <input id="bed-count" class="form-control btn" type="number" name="bedCount"
                value="${param.bedCount}" min="1"
                readonly style="width: 80px; height: 44px;font-size: 30px;">
              <input id="increase-bed" type="button" class="btn"
              value="+" onclick="changeCount(this)"  style="font-size: 20px;">
            </div>
            <div class="list-group-item form-check form-check-inline" style="font-size: 20px;">
              <h3>가격 범위</h3>
              ₩<input id="min-price" class="form-control form-check-label" type="number"
                name="minPrice" value="${param.minPrice}" min="10000" step="10000" placeholder="10000+"
                oninput="modMinMaxPrice(this)" onchange="modUnderPrice(this)"
                style="width: 150px; display: inline; font-size: 20px"> ~&nbsp;
              ₩<input id="max-price" class="form-control form-check-label" type="number"
                name="maxPrice" value="${param.maxPrice}" min="10000" step="10000" placeholder="10000+"
                oninput="modMinMaxPrice(this)" onchange="modUnderPrice(this)"
                style="width: 150px; display: inline; font-size: 20px">
            </div>
            <div class="list-group-item">
              <input type="button" class="btn btn-secondary"
              value="초기화" onclick="resetTags('etc')">
            </div>
          </div>
        </div>
      </div>

  </div>
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
	          <header class="heading"></header>
	          <hr>
	          <!-- 숙소리스트 영역 -->
	          <ul class="nospace clear" >
	            <c:forEach var="property" items="${properties}">
	            
	            <li style="height: 150px;">
	                <div class="one_third first" >
	                  <a href="<c:url value='/property/detail?propertyId=${property.id}'/>">
	                    <img src="${property.images.get(0).path}" alt="" >
	                  </a>
	                </div>
	                <div class="two_third">
	                  <h2><a href="<c:url value='/property/detail?propertyId=${property.id}'/>">${property.name}</a></h2>
	                  <h4>${property.propertyType.name}/${property.subPropertyType.name}</h4>
	                  <h4>${property.roomType.name}</h4>
	                  <h4>${property.address}</h4>
	                </div>
	            </li>
	            <div class="position-relative">
	              <div class="position-absolute end-0 bottom-50">
	                <!-- Button trigger modal -->
	                <a href="" class="trigger-btn wish-button" id="wishProperty-${property.id}"
	                data-toggle="modal">
	                  <!-- 빈 하트 -->
	                  <img src="https://img.icons8.com/fluent-systems-regular/48/000000/like--v1.png"
	                  style="width: 3rem; height: 3rem">
	                </a>
	                <script type="text/javascript">
	                // 화면 로드 시 초기화하는 과정
	                wishButton = document.querySelector("a#wishProperty-${property.id}");
	                if("${sessionScope.member_id}" == ""){
	                	wishButton.href = "#LoginModal";
	                } else {
	                	if("${property.wished}" == "true"){
	                		wishButton.href = "#";
	                		wishButton.setAttribute("class",
	                				"trigger-btn wish-button unwish wishList-${property.wishListId}");
	                		var imgTag = document.createElement("img");
	                		// 찬 하트
	                		imgTag.src = "https://img.icons8.com/fluent/48/000000/like.png";
	                		imgTag.style = "width: 3rem; height: 3rem";
	                		wishButton.innerHTML = "";
	                		wishButton.appendChild(imgTag);
	                	} else {
	                		wishButton.href = "#wish-modal";
	                	}
	                }
	                </script>
	              </div>
	            </div>
	            <hr>
	            </c:forEach>
	          </ul>
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