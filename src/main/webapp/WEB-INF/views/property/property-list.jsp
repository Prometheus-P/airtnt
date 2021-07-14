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
<title>AirTnT/숙소검색(키워드:${addressKey})</title>
<meta charset="utf-8">

<!-- map 커스텀 정보창 css -->
<style>
	.wrap {position: absolute;left: 0;bottom: 40px;width: 300px;height: 330px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
</style>

<!-- drop down, popup, ... -->
<!-- <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
crossorigin="anonymous"></script> -->
</head>
<body>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- Top Background Image Wrapper -->

<script src="/resources/script/json2.js"></script>

<!-- 상단 로그인 바 -->
<c:import url="/WEB-INF/views/top.jsp"/>

<!-- 위시리스트 모달은 jQuery 라이브러리 적용을 위해서 top.jsp 아래 둬야함 -->
<c:import url="/WEB-INF/views/property/_wish-modal.jsp"/>

<!-- 검색필터 이벤트 처리와 초기화를 제어하는 커스텀 파일 -->
<script src="/resources/script/search-control.js"></script>

<script type="text/javascript">
console.log("(${latitude}, ${longitude})");
</script>

<form id="search-form" action="<c:url value='/property/search'/>" method="get" onsubmit="setParametersOnSubmit()">
<input type="hidden" id="page-num" name="pageNum" value="1">

<!-- 검색 네비게이션 바 -->
<!-- <div id="pageintro" class="hoc clear justify-content-center" style="height: 10px"> -->
    <!-- ################################################################################################ -->
<div class="position-absolute top-0 start-50 translate-middle-x" style="z-index: 999">
  <nav id="mainnav" class="navbar navbar-light">
    <div class="container-fluid btn-group" >
      <input id="search" name="addressKey" class="form-control me-2" type="search" 
      placeholder="위치" value="${param.addressKey}"
      aria-label="Search" style="height: 50px; width: 300px; font-size: 20px">
      
      <input type="hidden" id="temp-search" name="tempAddressKey">
      <input type="hidden" id="latitude" name="latitude" value="${latitude}">
      <input type="hidden" id="longitude" name="longitude" value="${longitude}">
      
      <ul id="auto-complete-area" class="dropdown-menu list-group" style="width: 40rem; font-size: 2rem;">
        <!-- 주소 자동완성 목록 -->
      </ul>
      
      <input class="btn btn-primary" type="submit" value="검색"
      style="border: 0px; height: 50px; width: 100px; font-size: 20px">
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
  <div class="hoc clear" style="margin-left: 50px; margin-right: 50px">

    <!-- main body -->
    <!-- ################################################################################################ -->
    <div class="content"> 
      <!-- ################################################################################################ -->
      <h2>${addressKey} 주변의 숙소 목록</h2>
      <!-- ################################################################################################ -->
      <div class="group btmspace-50 demo">
        <!-- 숙소 리스트 -->
        <div class="one_half first">
          <div class="content"> 
          
          <!-- ################################################################################################ -->
              <header class="heading"></header>
              <!-- 숙소리스트 : 맵 내 마커 정보 -->
	          <table id="markerPositionTb" style="display:none;">
	          	<c:forEach var="property" items="${properties}">
	          		<tr>
                  	<td>${property.id}</td>
                  	<td>${property.latitude}</td>
                  	<td>${property.longitude}</td>
                  	<td>${property.name}</td>
                  	<td>${property.propertyType.name}</td>
                  	<td>
                  		 <c:forEach var="image" items="${property.images}">
                              ${image.path}:
                         </c:forEach>
                    </td>      
                  	</tr>
	          	</c:forEach>
	          </table>
	          
              <!-- 숙소리스트 영역 -->
              <hr>
              <ul class="nospace clear" >
                <c:forEach var="property" items="${properties}">
                
                <li style="height: 150px;">
                    <div class="one_third first" >
                      
                      <!-- 사진 넘기기 -->
                      <div id="carouselControls-${property.id}" class="carousel slide">
                        <div class="carousel-inner">
                          <c:forEach var="image" items="${property.images}" varStatus="status">
                            <div class="carousel-item <c:if test='${status.count == 1}'>active</c:if>">
                              <img src="${image.path}" class="d-block w-100" alt="" style="object-fit: cover; width:200px;height: 150px">
                            </div>
                          </c:forEach>
                        </div>
                        <c:if test="${not empty property.images && property.images.size() > 1}">
                          <button class="carousel-control-prev" type="button"
                          data-bs-target="#carouselControls-${property.id}" data-bs-slide="prev">
                            <img src="https://img.icons8.com/color/48/000000/back--v1.png"/>
                            <!-- <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span> -->
                          </button>
                          <button class="carousel-control-next" type="button"
                          data-bs-target="#carouselControls-${property.id}" data-bs-slide="next">
                            <img src="https://img.icons8.com/color/48/000000/forward.png"/>
                            <!-- <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span> -->
                          </button>
                        </c:if>
                      </div>

                    </div>
                    
                    <div class="two_third">
                      <h2><a href="<c:url value='/property/detail?propertyId=${property.id}'/>">${property.name}</a></h2>
                      <h4>${property.propertyType.name}/${property.subPropertyType.name}</h4>
                      <h4>${property.roomType.name}</h4>
                      <h4>${property.address}</h4>
                    </div>
                </li>
                
                <!-- 위시 버튼 -->
                <div class="position-relative">
                  <div class="position-absolute end-0 bottom-50">
                    <!-- Button trigger modal -->
                    <a href="" class="trigger-btn wish-button" id="wishProperty-${property.id}"
                    data-toggle="modal">
                      <!-- 빈 하트 -->
                      <img class="heart" src="" style="width: 3rem; height: 3rem">
                    </a>
                    <script type="text/javascript">
                      // 화면 로드 시 초기화하는 과정
                      initWish("${property.id}", "${property.wishListId}", "${property.wished}");
                    </script>
                  </div>
                </div>
                <hr>
                </c:forEach>
                
              </ul>
          </div>
          
          <!-- 페이지 버튼 값 설정 -->
          <c:set var="startPageNum" value="${param.pageNum - 3}"/>
          <c:set var="endPageNum" value="${param.pageNum + 3}"/>
          <c:if test="${startPageNum < 1}">
          	<c:set var="startPageNum" value="1"/>
          </c:if>
          <c:if test="${endPageNum > totalPagesNum}">
          	<c:set var="endPageNum" value="${totalPagesNum}"/>
          </c:if>
          <!-- 페이지 버튼 -->
          <div class="position-relative">
            <nav class="position-absolute end-0" aria-label="Page navigation">
              <ul class="pagination">
                <c:if test="${startPageNum > 1}">
                  <li class="page-item">
                    <a href="#" id="page-1" class="page-link" onclick="movePage(this)"
                    style="width: 5rem;height: 5rem;font-size: 2rem">
                      1
                    </a>
                  </li>
                  <li class="page-item disabled">
                    <span class="page-link" style="width: 5rem;height: 5rem;font-size: 2rem">
                      ...
                    </span>
                  </li>
                </c:if>
                <c:choose>
                  <c:when test="${startPageNum == 1}">
                    <li class="page-item disabled">
                      <span class="page-link" style="width: 5rem; height: 5rem;font-size: 2rem">
                        &laquo;
                      </span>
                    </li>
                  </c:when>
                  <c:otherwise>
                    <li class="page-item">
                      <a id="page-${pageNum - 4}" class="page-link" href="#" onclick="movePage(this)"
                      aria-label="Previous" style="width: 5rem; height: 5rem;font-size: 2rem">
                        &laquo;
                      </a>
                    </li>
                  </c:otherwise>
                </c:choose>
                <c:forEach var="pageNum" begin="${startPageNum}" end="${endPageNum}">
                  <c:choose>
                    <c:when test="${pageNum == param.pageNum}">
                      <li class="page-item active" aria-current="page">
                        <span class="page-link" style="width: 5rem;height: 5rem;font-size: 2rem">
                          ${pageNum}
                        </span>
                      </li>
                    </c:when>
                    <c:otherwise>
                      <li class="page-item">
                        <a id="page-${pageNum}" class="page-link" href="#" onclick="movePage(this)"
                        style="width: 5rem;height: 5rem;font-size: 2rem">
                          ${pageNum}
                        </a>
                      </li>
                    </c:otherwise>
                  </c:choose>
                </c:forEach>
                <c:choose>
                  <c:when test="${endPageNum == totalPagesNum}">
                    <li class="page-item disabled">
                      <span class="page-link" style="width: 5rem; height: 5rem;font-size: 2rem">
                        &raquo;
                      </span>
                    </li>
                  </c:when>
                  <c:otherwise>
                    <li class="page-item">
                      <a id="page-${pageNum + 4}" class="page-link" href="#" onclick="movePage(this)"
                      aria-label="Next" style="width: 5rem; height: 5rem;font-size: 2rem">
                        &raquo;
                      </a>
                    </li>
                  </c:otherwise>
                </c:choose>
                <c:if test="${endPageNum < totalPagesNum}">
                  <li class="page-item disabled">
                    <span class="page-link" style="width: 5rem;height: 5rem;font-size: 2rem">
                      ...
                    </span>
                  </li>
                  <li class="page-item">
                    <a href="#" id="page-${endPageNum}" class="page-link" onclick="movePage(this)"
                    style="width: 5rem;height: 5rem;font-size: 2rem">
                      ${totalPagesNum}
                    </a>
                  </li>
                </c:if>
              </ul>
            </nav>
          </div>
            
          <!-- 최근 목록 -->
          <div style="padding-top: 8rem">
            <c:import url="/WEB-INF/views/property/_recent-list.jsp"/>
          </div>
        </div>
        
        <!-- 카카오맵 -->
        <div class="one_half">
          <div id="map" style="width:600px;height:600px;"></div>
          <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=62b11c585fb341eec39dbc28ac9bad71"></script>
          <!-- <script type="text/javascript" src="/resources/map/kakao_map_test.js"></script> -->
          <script>
	      	$(document).ready(function(){
	      		var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	      		 mapOption = { 
			        center: new kakao.maps.LatLng(37.65634637629008, 127.07345281096936), // 지도의 중심좌표
			        level: 5 // 지도의 확대 레벨
			    };
	      		
		      	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		      	var bounds = new kakao.maps.LatLngBounds(); // 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체
		      	
		     	// 마커 객체 배열 생성(positions)
		      	var positions = []; 
		      	var selectedMarker = null; //클릭한 마커 담을 변수
		      	var table = $('#markerPositionTb tr'); //숙소 조회 리스트
		      	for(var i=0; i<table.length; i++){
		      		
		      		var id = $('tr:eq('+i+')>td:eq(0)').html(); //숙소id
		      		var latitude = $('tr:eq('+i+')>td:eq(1)').html(); //위경도
		      		var longitude = $('tr:eq('+i+')>td:eq(2)').html();
		      		var name = $('tr:eq('+i+')>td:eq(3)').html(); //숙소명
		      		var propertyType = $('tr:eq('+i+')>td:eq(4)').html(); //숙소타입
		      		var image = $('tr:eq('+i+')>td:eq(5)').html(); //이미지
		      		
		      		if(name.length>16) name = name.substring(0, 16)+'...'; //숙소명 긴 경우

		      		//마커 각각의 객체를 positions 배열에 push
		      		positions.push({title : name,
		      						latlng : new kakao.maps.LatLng(latitude, longitude),
		      						id : id,
		      						propertyType : propertyType,
		      						image : image
		      					  });
		      	}
		        
		     	// 마커 이미지 주소
		      	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		     	
		      	for (var i=0; i<positions.length; i++) {
		      	    var data = positions[i];
		      	    displayMarker(data);
		      	}

		      	// 지도에 마커를 표시 및 오버레이 세팅 (오버레이 세팅은 나중에 함수로 따로 뺄 예정!)
		      	function displayMarker(data) { 
		      		// 마커 이미지 크기
		      	    var imageSize = new kakao.maps.Size(38, 40); 
		      	    
		      	    // 마커 이미지 생성    
		      	    var markerImage = new kakao.maps.MarkerImage("/resources/property_img/marker5.png", imageSize); 
		      	    var overMarkerImage = new kakao.maps.MarkerImage("/resources/property_img/marker4.png", imageSize); 
		      	    var selectedMarkerImage = new kakao.maps.MarkerImage("/resources/property_img/marker7.png", imageSize); 
		      	    
		      	    var marker = new kakao.maps.Marker({
		      	        map: map,
		      	        position: data.latlng,
		      	      	image : markerImage // 마커 이미지 
		      	    });
		      	    
		      	 	marker.setMap(map); //마커 표시
		      	 	bounds.extend(positions[i].latlng); //최종단계에서 맵 중앙 재조정할때 사용
		      	 	
		      	 	//오버레이 생성
		      	    var overlay = new kakao.maps.CustomOverlay({
		      	        yAnchor: 1,
		      	      	clickable: true, //지도 클릭 이벤트 막음
		      	      	position : map.getCenter()
		      	    });
		      	    
		      		//오버레이 내용 구성
		      	    var content = document.createElement('div');
		      	  	content.className = 'wrap';
		      	    content.style.cssText = 'background: white; border-radius: 10px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc; box-shadow: 0px 0px 20px #000;';
		      	    
		      	  	
		      	  	//오버레이 안의 이미지 구현
		      	    var imageArea = document.createElement('div');
		      	  	imageArea.id = 'carouselControls-img'+data.id;
		      	  	imageArea.className = 'carousel slide';
		      	  	imageArea.style.cssText = '{position: relative;width: 300px;height: 220px;overflow: hidden;}';
		      	  	content.appendChild(imageArea);
		      	  	
		      		//마커객체에 담아놓았던 이미지 경로 split 하여 경로 배열(arr)에 넣음
		      	  	const arr = data.image.split(":");
		      	  	const size  = arr.length;
		      	  	
		      	  	//사진 슬라이드 좌우버튼
		      	  	if(size>2){
			      	  	var txt = '<button class="carousel-control-prev" type="button" data-bs-target="#carouselControls-img'+data.id+'" data-bs-slide="prev">'
			      	  	+ '<span class="carousel-control-prev-icon" aria-hidden="true"></span>'
                        + '<span class="visually-hidden">Previous</span>'
                      	+ '</button>'
                      	+ '<button class="carousel-control-next" type="button" data-bs-target="#carouselControls-img'+data.id+'" data-bs-slide="next">'
                        + '<span class="carousel-control-next-icon" aria-hidden="true"></span>'
                        + '<span class="visually-hidden">Next</span>'
                     	+ '</button>';
	      	    		
			      	  	imageArea.innerHTML = txt;
		      	  	};
		      	  	
		      	  	var carousel = document.createElement('div');
		      	  	carousel.className = 'carousel-inner';
		      	  	imageArea.appendChild(carousel);
		      		
		      	  	
		      	  	//첫번째 img
		      	  	var image = document.createElement('div');
		      	  	image.className = 'carousel-item active';
		      	  	image.innerHTML = '<img src="'+ arr[0] +'" style="object-fit: cover;">';
		      	  	carousel.appendChild(image);
		      	  	
		      	  	//else img
		      	  	for(let i=1; i<size-1; i++){
			      	  	var imageElse = document.createElement('div');
			      	  	imageElse.className = 'carousel-item';
			      	  	imageElse.innerHTML = '<img src="'+ arr[i] +'" style="object-fit: cover;">';
			      	  	carousel.appendChild(imageElse);
		      	  	}
		      	  	
		      	  	//숙소 설명 및 링크 설정
		      	  	var desc = document.createElement('div');
		      	  	desc.className = "desc";
		      	  	desc.style.cssText = "position: relative;height: 90px; width:300px; padding:15px;font-size:18px;";
		      	  	desc.innerHTML =  '<img src="/resources/property_img/starIcon.PNG" style="width:18px; height:18px; margin-bottom:5px;">4.84<br>'
		      	  					  + '<a href="/property/detail?propertyId='+ data.id + '" target="_blank">'
		      	  					  + data.propertyType + '<br>'+ data.title + '<br>' + '</a>';
		      	  	content.appendChild(desc);
		      	    
		      	    overlay.setContent(content);

					
		      	    //마커 클릭 이벤트
		      	    kakao.maps.event.addListener(marker, 'click', function() {
		      	    	//클릭되어있는 기존 마커 over 처리
		      	    	//지금 선택한 마커가 클릭되어있는 기존 마커가 아니고, null 이 아니면
		      	    	if(selectedMarker !== marker && selectedMarker != null){
		      	    		//overlay.setMap(null);
		      	    		selectedMarker.setImage(overMarkerImage);
		      	    	}
		      	    	
		      	    	// 클릭한 마커 이미지 변경
		      	        if (!selectedMarker || selectedMarker !== marker) {
		      	            marker.setImage(selectedMarkerImage);
		      	        }

		      	        // 클릭된 마커를 현재 클릭된 마커 객체로 설정
		      	        selectedMarker = marker;
		      	        
		      	    	//맵에 오버레이 세팅
		      	    	overlay.setMap(map);
		      	    });
		      	    
		      	    //맵 클릭 이벤트
		      	  	kakao.maps.event.addListener(map, 'click', function() {
		      	  		// 클릭된 마커 객체가 null이 아니면
	      	            // 클릭된 마커의 이미지를 조회기록있는 마커이미지로 변경
		      	  		!!selectedMarker && selectedMarker.setImage(overMarkerImage);
		      	  		
		      	  		//오버레이 맵에서 제거
		      	        overlay.setMap(null);
		      	    });
		      	    
		      		
		      	}
		      	
		     	//마커 범위 재설정
		      	map.setBounds(bounds);
		     	//재설정한 지도 기준으로 오버레이가 맵 중앙에 표시되도록 위치 재설정
		      	overlay.setPosition(map.getCenter()); 
		     	
	        })
	        
          </script>
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