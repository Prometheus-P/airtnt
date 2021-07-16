<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="">
<head>
<title>AirTnT/숙소검색(키워드:${addressKey})</title>
<meta charset="utf-8">
<style>
	 #test_btn{ border-top-left-radius: 5px; border-bottom-left-radius: 5px; border-top-right-radius: 5px; border-bottom-right-radius: 5px; margin-right:-4px; } 
	 #test_btn2{ border-top-left-radius: 20px; border-bottom-left-radius: 20px; border-top-right-radius: 20px; border-bottom-right-radius: 20px; margin-right:0px; } 
	 #test_btn3{ border-top-left-radius: 20px; border-bottom-left-radius: 20px; border-top-right-radius: 20px; border-bottom-right-radius: 20px; margin-right:0px; border: 1px solid #000000; background-color: rgba(0,0,0,0); color: #000000; padding: 5px;} 
	 #btn_group button{ border: 1px solid #b0aaaa; background-color: rgba(0,0,0,0); color: black; padding: 5px; margin:10px; }
	 #btn_group button:hover{border: 1.5px solid #000000 } 
</style>
</head>
<body>
	<!-- 상단 로그인 바 -->
	<c:import url="/WEB-INF/views/top.jsp" />

	<!-- 위시리스트 모달은 jQuery 라이브러리 적용을 위해서 top.jsp 아래 둬야함 -->
	<c:import url="/WEB-INF/views/property/_wish-modal.jsp" />

	<!-- 검색필터 이벤트 처리와 초기화를 제어하는 커스텀 파일 -->
	<script src="/resources/script/search-control.js"></script>

	<!-- 실시간 추전 주소 검색어를 띄워주는 파일 -->
	<script src="/resources/script/address-control.js"></script>
	
	<!-- 카카오 주소검색을 불러오는 커스텀 파일 -->
		<script src="/resources/script/address-control.js"></script>
		
		<form id="search-form" action="<c:url value='/property/search'/>" method="get" onsubmit="setParametersOnSubmit()">
			<!-- 검색 네비게이션 바 -->
			<div class="position-absolute top-0 start-50 translate-middle-x" style="z-index: 999; margin-top:10px; ">
				<nav class="navbar navbar-light bg-light" id="mainnav" style="justify-content:center; background-color:#ffffff!important;">
					<input id="search" name="addressKey" class="form-control mr-sm-2"
							type="search" placeholder="어디로 여행하실건가요?"
							value="${param.addressKey}" aria-label="Search"
							style="height: 40px; width: 300px; font-size: 18px; box-shadow: 0px 0px 10px #e0e0e0;"> 
					<input type="hidden" id="temp-search" name="tempAddressKey"> 
					<input type="hidden" id="latitude" name="latitude" value="${latitude}">
					<input type="hidden" id="longitude" name="longitude" value="${longitude}">
					<ul id="auto-complete-area" class="dropdown-menu list-group" style="width: 40rem; font-size: 2rem;">
						<!-- 주소 자동완성 목록 -->
					</ul>
					<button class="btn btn-info" type="submit" style="margin-left:10px; box-shadow: 0px 0px 10px #e0e0e0;">Search</button>
				</nav>
			</div>
			
	<div>			
	<!-- 메인 화면 -->
		<div class="hoc clear wrapper row3" style="width:93%; margin-top:15px; height:70%; border-bottom: 1px solid #000000">
		<!-- main body -->
	
			<!-- 숙소 리스트 -->
			<div class="one_half first" style="width: 55%;padding-right: 10px;">
				
					
					<input type="hidden" id="page-num" name="pageNum" value="1">
							
					<h2 style="font-weight: bold;"> ${addressKey} 주변의 숙소 목록</h2>
		
					<div class="filter" style="margin-top:15px; height: 60px;">
		
						<!-- 숙소 유형 검색 필터 -->
						<div class="btn-group first">
						
							<div id="btn_group" class="btn-group">
			
								<button style="font-size:15px; padding-left:10px; padding-right:10px;" class="btn btn-secondary btn-lg dropdown-toggle"
										type="button" id="dropdownMenuClickableInside-1" data-bs-toggle="dropdown" data-bs-auto-close="outside"
										aria-expanded="false">숙소 유형</button>
			
								<ul class="dropdown-menu list-group" aria-labelledby="dropdownMenuClickableInside-1">
								<c:forEach var="propertyType" items="${propertyTypes}">
									<li class="list-group-item">
										<!-- Split dropend button -->
										<div class="form-check form-check-inline">
											<input type="checkbox" id="propertyType-${propertyType.id}" class="form-check-input" name="propertyTypeId" value="${propertyType.id}"
												<c:forEach var='tagAttribute' items='${propertyType.tagAttributes}'>
			                     					 ${tagAttribute}="${propertyType.getTagAttributeMapValue(tagAttribute)}"
			                  						</c:forEach>
												onchange="modSubPropertyTypes(this)"> <label class="form-check-label">${propertyType.name} 전체</label>
										</div>
			
										<button class="btn btn-primary dropdown-toggle" type="button" data-bs-toggle="collapse"
											data-bs-target="#collapse-${propertyType.id}" aria-expanded="false" aria-controls="collapse-${propertyType.id}">${propertyType.name} 세부유형</button>
										<c:set var="isChecked" value="${false}" />
										<div class="collapse" id="collapse-${propertyType.id}">
											<c:forEach var="subPropertyType" items="${propertyType.subPropertyTypes}">
												<div class="form-check form-check-inline">
													<input type="checkbox" id="subPropertyType-${propertyType.id}-${subPropertyType.id}"
														<c:forEach var='tagAttribute' items='${subPropertyType.tagAttributes}'>
			                       							${tagAttribute}="${subPropertyType.getTagAttributeMapValue(tagAttribute)}"
			                       							<c:if test='${tagAttribute == "checked"}'>
			                       								<c:set var='isChecked' value='${true}'/>
			                       							</c:if>
			                       						</c:forEach>
														class="form-check-input" name="subPropertyTypeId" value="${subPropertyType.id}"> 
													<label class="form-check-label">${subPropertyType.name}</label>
												</div>
											</c:forEach>
										</div>
										<c:if test="${isChecked}">
											<script type="text/javascript">
												document.querySelector("div#collapse-${propertyType.id}").setAttribute("class","collapse show");
											</script>
										</c:if>
									</li>
								</c:forEach>
									<li>
										<input type="button" class="btn btn-secondary" value="초기화" onclick="resetTags('propertyTypes')">
									</li>
								</ul>
							</div>
							
						</div>
						
						<!-- 방 유형 검색 필터 -->
						<div id="btn_group" class="btn-group">
						
							<button class="btn btn-secondary btn-lg dropdown-toggle"
								type="button" id="dropdownMenuClickableInside-2"
								data-bs-toggle="dropdown" data-bs-auto-close="outside"
								aria-expanded="false" style="font-size:15px; padding-left:15px; padding-right:15px;">방 유형</button>
			
							<ul class="dropdown-menu list-group" aria-labelledby="dropdownMenuClickableInside-2">
							<c:forEach var="roomType" items="${roomTypes}">
								<li class="list-group-item" style="font-size: 20px">
									<div class="form-check form-check-inline">
										<input type="checkbox" class="form-check-input" name="roomTypeId" value="${roomType.id}"
											<c:forEach var='tagAttribute' items='${roomType.tagAttributes}'>
			                     				${tagAttribute}="${roomType.getTagAttributeMapValue(tagAttribute)}"
			                    			</c:forEach>>
			                    		<label class="form-check-label">${roomType.name}</label>	
			                    	</div>
								</li>
							</c:forEach>
								<li>
									<input type="button" class="btn btn-secondary" value="초기화" onclick="resetTags('roomTypes')">
								</li>
							</ul>
							
						</div>
			
						<!-- 편의시설 검색 필터 -->
						<div id="btn_group" class="btn-group">
						
							<button class="btn btn-secondary btn-lg dropdown-toggle" type="button" id="dropdownMenuClickableInside-3" data-bs-toggle="dropdown" 
									data-bs-auto-close="outside" aria-expanded="false" style="font-size:15px; padding-left:15px; padding-right:15px;">편의시설</button>
			
							<div class="dropdown-menu" aria-labelledby="dropdownMenuClickableInside-3" style="font-size: 15px">
							<c:forEach var="amenityType" items="${amenityTypes}">
								<div class="form-check form-check-inline">
									<input type="checkbox" class="form-check-input" name="amenityTypeId" value="${amenityType.id}"
										<c:forEach var='tagAttribute' items='${amenityType.tagAttributes}'>
			                    			${tagAttribute}="${amenityType.getTagAttributeMapValue(tagAttribute)}"
			                  			</c:forEach>>
									<label class="form-check-label">${amenityType.name}</label>
								</div>
							</c:forEach>
								<input type="button" class="btn btn-secondary" value="초기화" onclick="resetTags('amenityTypes')">
							</div>
							
						</div>
			
						<!-- 인원, 침대 수, 가격 검색 필터 -->
						<div id="btn_group" class="btn-group">
						
							<button class="btn btn-secondary btn-lg dropdown-toggle"
									type="button" id="dropdownMenuClickableInside-4"
									data-bs-toggle="dropdown" data-bs-auto-close="outside"
									aria-expanded="false" style="font-size:15px; padding-left:15px; padding-right:15px;">기타사항</button>
			
							<div class="dropdown-menu list-group" aria-labelledby="dropdownMenuClickableInside-4" style="width: 500px;">
								<div class="btn-group list-group-item" style="padding-bottom: 50px; padding-left: 20px">
									<h3>인원</h3>
									<input id="decrease-guest" type="button" class="btn" value="-" onclick="changeCount(this)" style="font-size: 20px;">
									<input id="guest-count" class="form-control btn" type="number"
										    name="guestCount" value="${param.guestCount}" min="1"
											readonly style="width: 80px; height: 44px; font-size: 30px;">
									<input id="increase-guest" type="button" class="btn" value="+" onclick="changeCount(this)" style="font-size: 20px;">
								</div>
								
								<div class="btn-group list-group-item" style="padding-bottom: 50px; padding-left: 20px">
									<h3>침대 수</h3>
									<input id="decrease-bed" type="button" class="btn" value="-" onclick="changeCount(this)" style="font-size: 20px;">
									<input id="bed-count" class="form-control btn" type="number"
											name="bedCount" value="${param.bedCount}" min="1" readonly
											style="width: 80px; height: 44px; font-size: 30px;">
									<input id="increase-bed" type="button" class="btn" value="+" onclick="changeCount(this)" style="font-size: 20px;">
								</div>
								<div class="list-group-item form-check form-check-inline" style="font-size: 20px;">
									<h3>가격 범위</h3>
									₩<input id="min-price" class="form-control form-check-label"
											type="number" name="minPrice" value="${param.minPrice}"
											min="10000" step="10000" placeholder="10000+"
											oninput="modMinMaxPrice(this)" onchange="modUnderPrice(this)"
											style="width: 150px; display: inline; font-size: 20px">
									~&nbsp; 
									₩<input id="max-price" class="form-control form-check-label" type="number"
											name="maxPrice" value="${param.maxPrice}" min="10000"
											step="10000" placeholder="10000+"
											oninput="modMinMaxPrice(this)" onchange="modUnderPrice(this)"
											style="width: 150px; display: inline; font-size: 20px">
								</div>
								<div class="list-group-item">
									<input type="button" class="btn btn-secondary" value="초기화" onclick="resetTags('etc')">
								</div>
							</div>
						</div>	
					</div> <!-- filter end -->
					<input type="button" class="btn btn-secondary" value="전체 초기화" onclick="resetTags('all')">
				</form>
					
				<!-- 숙소리스트 영역 -->
				<hr>
				<ul class="nospace clear">
				<c:forEach var="property" items="${properties}">
					<li style="height: 150px;">
						<div class="one_third first">
						<!-- 사진 넘기기 -->
							<div id="carouselControls-${property.id}" class="carousel slide">
								<div class="carousel-inner">
								<c:forEach var="image" items="${property.images}" varStatus="status">
									<div class="carousel-item <c:if test='${status.count == 1}'>active</c:if>">
										<img src="${image.path}" class="d-block w-100" alt="" style="object-fit: cover; border-radius: 10px; width: 200px; height: 150px">
									</div>
								</c:forEach>
								</div>
								<c:if test="${not empty property.images && property.images.size() > 1}">
									<button class="carousel-control-prev" type="button" data-bs-target="#carouselControls-${property.id}" data-bs-slide="prev">
										<img src="https://img.icons8.com/color/48/000000/back--v1.png" />
									</button>
									<button class="carousel-control-next" type="button" data-bs-target="#carouselControls-${property.id}" data-bs-slide="next">
										<img src="https://img.icons8.com/color/48/000000/forward.png" />
									</button>
								</c:if>
							</div>
						</div>
		
						<div class="two_third position-relative">
							<a href="<c:url value='/property/detail?propertyId=${property.id}'/>" style="color:#383434; font-size:20px;">${property.name}</a>
							<h4 style="font-size:15px;">${property.propertyType.name}/${property.subPropertyType.name}</h4>
							<h4 style="font-size:15px;">${property.roomType.name}</h4>
							<h4 style="font-size:15px;">${property.address}</h4>
							<c:if test="${not empty property.amenityTypes}">
								<h5>
									편의시설 :
									<c:forEach var="amenityType" items="${property.amenityTypes}" varStatus="status">
		                            	${amenityType.name}<c:if test="${not status.last}">,</c:if>
									</c:forEach>
								</h5>
							</c:if>
							<h5 style="color:#8f8c8c; font-size:15px;"><img src="/resources/property_img/starIcon.PNG" style="width:18px; height:18px; margin-bottom:5px;">
								${property.rating} (후기 ${property.reviews.size()} 개)
							</h5>
							<div class="position-absolute end-0 bottom-0" style="margin-right:20px;">
								<h4 style="color: #0d6efd">
									<fmt:formatNumber type="currency" value="${property.price}" />
								</h4>
							</div>
						</div>
					</li>
		
					<!-- 위시 버튼 -->
					<div class="position-relative">
						<div class="position-absolute end-0 bottom-50">
						<!-- Button trigger modal -->
							<a href="" class="trigger-btn wish-button" id="wishProperty-${property.id}" data-toggle="modal"> <!-- 빈 하트 -->
								<img class="heart" src="" style="width: 3rem; height: 3rem">
							</a>
							<script type="text/javascript">
								// 화면 로드 시 초기화하는 과정
								initWish("${property.id}","${property.wishListId}","${property.wished}");
							</script>
						</div>
					</div>
		
					<hr>
				</c:forEach>
			</ul>
			
			<!-- 페이지 버튼 값 설정 -->
			<c:set var="startPageNum" value="${param.pageNum - 3}" />
			<c:set var="endPageNum" value="${param.pageNum + 3}" />
			<c:if test="${startPageNum < 1}">
				<c:set var="startPageNum" value="1" />
			</c:if>
			<c:if test="${endPageNum > totalPagesNum}">
				<c:set var="endPageNum" value="${totalPagesNum}" />
			</c:if>
			
			<!-- 페이지 버튼 -->
			<div>
				<nav class="" aria-label="Page navigation">
					<ul class="pagination justify-content-center">
						<c:if test="${startPageNum > 1}">
							<li class="page-item"><a href="#" id="page-1"
								class="page-link" onclick="movePage(this)"
								style="width: 3rem; height: 3rem; font-size: 2rem"> 1 </a></li>
							<li class="page-item disabled"><span class="page-link"
								style="width: 3rem; height: 3rem; font-size: 2rem"> ... </span></li>
						</c:if>
						<c:choose>
							<c:when test="${startPageNum == 1}">
								<li class="page-item disabled"><span class="page-link"
									style="width: 3rem; height: 3rem; font-size: 2rem">
										&laquo; </span></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a id="page-${pageNum - 4}"
									class="page-link" href="#" onclick="movePage(this)"
									aria-label="Previous"
									style="width: 3rem; height: 3rem; font-size: 2rem"> &laquo; </a></li>
							</c:otherwise>
						</c:choose>
						<c:forEach var="pageNum" begin="${startPageNum}" end="${endPageNum}">
							<c:choose>
								<c:when test="${pageNum == param.pageNum}">
									<li class="page-item active" aria-current="page"><span
										class="page-link"
										style="width: 3rem; height: 3rem; font-size: 2rem">
											${pageNum} </span></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a id="page-${pageNum}"
										class="page-link" href="#" onclick="movePage(this)"
										style="width: 3rem; height: 3rem; font-size: 2rem">
											${pageNum} </a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${endPageNum == totalPagesNum}">
								<li class="page-item disabled"><span class="page-link"
									style="width: 3rem; height: 3rem; font-size: 2rem">
										&raquo; </span></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a id="page-${pageNum + 4}"
									class="page-link" href="#" onclick="movePage(this)"
									aria-label="Next"
									style="width: 3rem; height: 3rem; font-size: 2rem"> &raquo; </a></li>
							</c:otherwise>
						</c:choose>
						<c:if test="${endPageNum < totalPagesNum}">
							<li class="page-item disabled"><span class="page-link"
								style="width: 2rem; height: 2rem; font-size: 1rem"> ... </span></li>
							<li class="page-item"><a href="#" id="page-${endPageNum}"
								class="page-link" onclick="movePage(this)"
								style="width: 3rem; height: 3rem; font-size: 2rem">
									${totalPagesNum} </a></li>
						</c:if>
					</ul>
				</nav>
			</div>
			
			
				<!-- 최근 목록 -->
				<div style="background-color:#fcfafa; padding: 2rem">
					<c:import url="/WEB-INF/views/property/_recent-list.jsp" />
				</div>
			</div>
			
			<!-- 카카오맵 -->
			<div class="one_half" style="margin-left:0px; width: 40%;">
				<div id="map" style="width: 800px; height: 100%;  position: absolute;">
					<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=62b11c585fb341eec39dbc28ac9bad71"></script>
					<script>
						$(document).ready(function() {
							var mapContainer = document.getElementById('map'), // 지도를 표시할 div
												mapOption = { 
																center : new kakao.maps.LatLng("${latitude}", "${longitude}"), // 지도의 중심좌표
																level : 7// 지도의 확대 레벨
															};
							var map = new kakao.maps.Map(mapContainer, mapOption); // 지도 생성
							var bounds = new kakao.maps.LatLngBounds(); // 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체
		
							// 마커 객체 배열 생성(positions)
							var positions = [];
							var selectedMarker = null; //클릭한 마커 담을 변수
							var table = $('#markerPositionTb tr'); //숙소 조회 리스트
							for (var i=0; i<table.length; i++) {
								var id = $('tr:eq(' + i + ')>td:eq(0)').html(); //숙소id
								var latitude = $('tr:eq(' + i + ')>td:eq(1)').html(); //위경도
								var longitude = $('tr:eq(' + i + ')>td:eq(2)').html();
								var name = $('tr:eq(' + i + ')>td:eq(3)').html(); //숙소명
								var propertyType = $('tr:eq(' + i + ')>td:eq(4)').html(); //숙소타입
								var image = $('tr:eq(' + i + ')>td:eq(5)').html(); //이미지
								var rating = $('tr:eq(' + i + ')>td:eq(6)').html(); //평점
		
								if (name.length > 16) name = name.substring(0, 16) + '...'; //숙소명 긴 경우
		
								//마커 각각의 객체를 positions 배열에 push
								positions.push({
									title : name,
									latlng : new kakao.maps.LatLng(latitude, longitude),
									id : id,
									propertyType : propertyType,
									image : image,
									rating : rating
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
								var imageSize = new kakao.maps.Size(38,40);
		
								// 마커 이미지 생성    
								var markerImage = new kakao.maps.MarkerImage("/resources/property_img/marker.png", imageSize);
								var overMarkerImage = new kakao.maps.MarkerImage("/resources/property_img/marker1.png", imageSize);
								var selectedMarkerImage = new kakao.maps.MarkerImage("/resources/property_img/marker1.png", imageSize);
		
								var marker = new kakao.maps.Marker(
										{
											map : map,
											position : data.latlng,
											image : markerImage// 마커 이미지 
										});
		
								marker.setMap(map); //마커 표시
								bounds.extend(positions[i].latlng); //최종단계에서 맵 중앙 재조정할때 사용
		
								///////////////////////////////오버레이////////////////////////////////////////
								//오버레이 생성
								var overlay = new kakao.maps.CustomOverlay(
										{
											clickable : true , //지도 클릭 이벤트 막음
											position : data.latlng
										});
		
								//오버레이 내용 구성
								var content = document.createElement('div');
								content.className = 'wrap';
								content.style.cssText = 'background: white; border-radius: 10px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc; box-shadow: 0px 0px 20px #000; height:330px;';
		
								//오버레이 안의 이미지 구현
								var imageArea = document.createElement('div');
								imageArea.id = 'carouselControls-img' + data.id;
								imageArea.className = 'carousel slide';
								imageArea.style.cssText = 'width: 300px;height: 200px;overflow: hidden; padding:0.5px; border-radius: 10px;';
								content.appendChild(imageArea);
		
								//마커객체에 담아놓았던 이미지 경로 split 하여 경로 배열(arr)에 넣음
								const arr = data.image.split(":");
								const size = arr.length;
		
								//사진 슬라이드 좌우버튼
								if (size > 2) {
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
								image.innerHTML = '<img src="'+ arr[0] +'" >';
								carousel.appendChild(image);
		
								//else img
								for (let i=1; i<size-1; i++) {
									var imageElse = document.createElement('div');
									imageElse.className = 'carousel-item';
									imageElse.innerHTML = '<img src="'+ arr[i] +'" >';
									carousel.appendChild(imageElse);
								}
		
								//숙소 설명 및 링크 설정
								var desc = document.createElement('div');
								desc.className = "desc";
								desc.style.cssText = "position: relative;height: 90px; width:300px; padding:15px;font-size:18px;";
								desc.innerHTML = '<img src="/resources/property_img/starIcon.PNG" style="width:18px; height:18px; margin-bottom:5px;">'
												+ data.rating + '<br>'
												+ '<a href="/property/detail?propertyId='+ data.id + '" target="_blank" style="color:#383434;">'
												+ data.propertyType
												+ '<br>'
												+ data.title + '<br>'
												+ '</a>';
								content.appendChild(desc);
		
								overlay.setContent(content);
		
								//마커 클릭 이벤트
								kakao.maps.event.addListener(marker, 'click',function(){
									
										//클릭되어있는 기존 마커 over 처리
										//지금 선택한 마커가 클릭되어있는 기존 마커가 아니고, null 이 아니면
										if (selectedMarker !== marker&& selectedMarker != null) {
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
										//오버레이 위치 맞춰서 맵 이동
										map.setCenter(overlay.getPosition());
										
								});
		
								//맵 클릭 이벤트
								kakao.maps.event.addListener(map, 'click', function() {
									// 클릭된 마커 객체가 null이 아니면
									// 클릭된 마커의 이미지를 조회기록있는 마커이미지로 변경
									!!selectedMarker&& selectedMarker.setImage(overMarkerImage);
		
									//오버레이 맵에서 제거
									overlay.setMap(null);
								});
		
							}
		
							//마커 범위 재설정
							map.setBounds(bounds);
		
						})
					</script>
				</div>
				
				<div class="content">
		
				<!-- ################################################################################################ -->
				<header class="heading"></header>
				<!-- 숙소리스트 : 맵 내 마커 정보 -->
				<table id="markerPositionTb" style="display: none;">
					<c:forEach var="property" items="${properties}">
						<tr>
							<td>${property.id}</td>
							<td>${property.latitude}</td>
							<td>${property.longitude}</td>
							<td>${property.name}</td>
							<td>${property.propertyType.name}</td>
							<td><c:forEach var="image" items="${property.images}">
		                              ${image.path}:
		                        </c:forEach></td>
		                    <td>${property.rating}</td>   
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
	
	
	<div class="wrapper row5" style="height:30%; bottom: 0; width: 100%;">
	  <section id="ctdetails" class="hoc clear"> 
	    ################################################################################################
	    <ul class="nospace clear">
	      <li class="one_quarter first">
	        <div class="block clear">
	          <a href="#"><i class="fas fa-phone"></i></a>
	          <span><strong>대표 오정석</strong> +082 010-7293-4295</span>
	          <span><strong>기획팀장 이승훈</strong> +082 010-1234-5678</span>
	          <span><strong>연구소장 최수연</strong> +082 010-1234-5678</span>
	          <span><strong>그냥 박하성</strong> +082 010-1234-5678</span>
	        </div>
	        <div class="block clear"><a href="#"><i class="fas fa-phone"></i></a> <span><strong>Give us a call:</strong> +00 (123) 456 7890</span></div>
	      </li>
	      <li class="one_quarter">
	        <div class="block clear"><a href="#"><i class="fas fa-envelope"></i></a> <span><strong>Send us a mail:</strong> support@domain.com</span></div>
	      </li>
	      <li class="one_quarter">
	        <div class="block clear">
	          <a href="#"><i class="fas fa-clock"></i></a>
	          <span>개발 시간<strong> 월 - 일(주중 무휴)</strong> 00:00am - 23:59pm</span>
	        </div>
	        <div class="block clear"><a href="#"><i class="fas fa-clock"></i></a> <span><strong> Mon. - Sat.:</strong> 08.00am - 18.00pm</span></div>
	      </li>
	      <li class="one_quarter">
	        <div class="block clear"><a href="#"><i class="fas fa-map-marker-alt"></i></a> <span><strong>Come visit us:</strong> Directions to <a href="#">our location</a></span></div>
	      </li>
	    </ul>
	    ################################################################################################
	  </section>
	</div>
</div>
	<a id="backtotop" href="#top"><i class="fas fa-chevron-up"></i></a>
	<!-- JAVASCRIPTS -->
	<script src="/resources/layout/scripts/jquery.backtotop.js"></script>
	<script src="../layout/scripts/jquery.backtotop.js"></script>
</body>
</html>