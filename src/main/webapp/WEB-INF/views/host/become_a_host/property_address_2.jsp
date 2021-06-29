<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>address</title>
</head>
<body>
	<script type="text/javascript">
		function display(){
			document.getElementById("check").style.display="block";
		}
		function check(){
			if (f.address.value==""){
				alert("주소를 입력해 주세요!!")
				f.address.focus()
				return false;
			}
			document.f.submit()
			return true;
		}
	</script>
	<h2>주소 입력페이지!</h2>
	<form action="<c:url value='/host/property_detail_3'/>" onsubmit="check()" name="f" method="post">
	<input type="text" id="address" name = "address" placeholder="주소" readonly
						style="text-align: center; width: 200px; height: 35px;">
	<button type="button" onclick="address_DaumPostcode(); display()" value="주소 검색">
		<span> 주소 검색 </span>
	</button><br><br><br>
	<div id="check" style="display:none">
		<input type="submit" value="위치 확인!">
	</div>
	</form>

	<div>
		<script
			src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=62b11c585fb341eec39dbc28ac9bad71&libraries=services"></script>
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
			
			function address_DaumPostcode() {
				new daum.Postcode(
						{
							oncomplete : function(data) {
								var addr = data.address; // 최종 주소 변수

								// 주소 정보를 해당 필드에 넣는다.
								document.getElementById("address").value = addr;
								// 주소로 상세 정보를 검색
								geocoder.addressSearch(
												data.address,
												function(results, status) {
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
</body>
</html>