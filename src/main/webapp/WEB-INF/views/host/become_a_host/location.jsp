<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>location</title>
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="/resources_host/become_a_host/css/demo.css" />
<link rel="stylesheet" type="text/css" href="/resources_host/become_a_host/css/component.css" />
<!-- Modernizr is used for flexbox fallback -->
<script src="/resources_host/become_a_host/js/modernizr.custom.js"></script>
</head>
<body>
	
	<!-- Main view -->
	<div class="view">
		<!-- Blueprint header -->
		<header class="bp-header cf">
			<span>AirTnT <span class="bp-icon bp-icon-about"
				data-content="저희 AirTnT의 주 원동력 호스트가 되어 주셔서 감사합니다."></span></span>
			<h1>주소 찾기</h1>
			<nav>
				<a href="" class="bp-icon bp-icon-prev" data-info="이전 페이지">
				<span>이전페이지</span></a> 
				<a href="" class="bp-icon bp-icon-next" data-info="다음 페이지">
				<span>다음페이지</span></a>
			</nav>
		</header>
		<!-- Product grid -->
		<section class="grid">
			<!-- Products -->
			<div class="product">
				<div class="product__info">
					<h3 class="product__title">주소</h3>
					<input type="text" id="sample5_address" placeholder="주소"
						style="text-align: center; width: 200px; height: 35px;">
					<button class="action action--button action--buy" 
						onclick="sample5_execDaumPostcode()" value="주소 검색">
						<span class="action__text"> 주소 검색 </span>
					</button>
					<br><br><br><br>
					
					<button class="action action--button_check action--buy" onclick="location.href=''">
						<span class="action__text"> 주소 확인 </span>
					</button>
				</div>
			</div>
			
			<div>
				<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
				<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=62b11c585fb341eec39dbc28ac9bad71&libraries=services"></script>
				<div id="map"
					style="width: 350px; height: 350px; margin-top: 10px; display: none">
				</div>
				<script>
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div
					mapOption = {
						center : new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
						level : 5
					// 지도의 확대 레벨
					};

					//지도를 미리 생성
					var map = new daum.maps.Map(mapContainer, mapOption);
					//주소-좌표 변환 객체를 생성
					var geocoder = new daum.maps.services.Geocoder();
					//마커를 미리 생성
					var marker = new daum.maps.Marker({
						position : new daum.maps.LatLng(37.537187, 127.005476),
						map : map
					});

					function sample5_execDaumPostcode() {
						new daum.Postcode(
								{
									oncomplete : function(data) {
										var addr = data.address; // 최종 주소 변수

										// 주소 정보를 해당 필드에 넣는다.
										document.getElementById("sample5_address").value = addr;
										// 주소로 상세 정보를 검색
										geocoder.addressSearch(
														data.address,
														function(results,
																status) {
															// 정상적으로 검색이 완료됐으면
															if (status === daum.maps.services.Status.OK) {

																var result = results[0]; //첫번째 결과의 값을 활용

																// 해당 주소에 대한 좌표를 받아서
																var coords = new daum.maps.LatLng(
																		result.y,
																		result.x);
																// 지도를 보여준다.
																mapContainer.style.display = "block";
																map.relayout();
																// 지도 중심을 변경한다.
																map.setCenter(coords);
																// 마커를 결과값으로 받은 위치로 옮긴다.
																marker.setPosition(coords)
															}
														});
									}
								}).open();
					}
				</script>
			</div>
		</section>
	</div>
</body>
</html>
