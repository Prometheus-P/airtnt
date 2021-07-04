<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소등록</title>
</head>
<body>
	<%@include file="top.jsp"%>
	<%@include file="../../top.jsp"%>
	<div class="container theme-showcase" role="main">
		<div class="page-header">
			<h1
				style="font-style: italic; font-weight: bold; font-family: fantasy;">
				주소를 입력해주세요</h1>
		</div>
		<form name="f" method="post" action="<c:url value='/host/detail'/>" onsubmit="return send()">
		<div class="row">
			<div class="col-sm-4">
				<input type="text" id="address" name="address" placeholder="주소"
					readonly="readonly" class="form-control"
					style="text-align: center; width: 500px; height: 50px;">
				<div id="detail" style="display: none" >
				<br><br>
					<input type="text" class="form-control"
					style="text-align: center; width: 400px; height: 50px;" placeholder="상세 주소 입력">
				</div>
				<button type="button" class="btn btn-primary" id="addressDetail" name="addressDetail" 
					onclick="address_DaumPostcode(); displayDetail()" value="주소 검색">
					<span> 주소 검색 </span>
				</button>
			</div>
			<div id="field" class="col-sm-4" style="display: none;">
					<button type="submit" class="btn btn-lg btn-success"
					style=" margin-left: 80px">이 주소가 맞아요!!</button>
				<div id="map"
						style="width: 350px; height: 350px; margin-left: 80px;margin-top: 10px; float:rigth;"></div>
				</div>
			</div>
			</form>
		</div>
		<br> <br> <br> <br> <br> <br> <br>
		<br> <br> <br> <br>
		<%@include file='bottom.jsp'%>
		<script
			src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=62b11c585fb341eec39dbc28ac9bad71&libraries=services"></script>

		<script>
			function displayDetail(){
				document.getElementById('detail').style.display="block";
			}
			function send(){
				if (document.f.address.value==""){
					alert("주소를 검색해 주세요!!")
					f.addressString.focus();
					return false;
				}
				if(document.f.addressDetail.value==""){
					var check = window.confirm("상세 주소가 없나요?");
					if(!check){
						f.detailString.focus();
						return false;
					}
				}
				document.f.submit();
				return true;
			}
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
														document.getElementById('field').style.display = "block";
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



	<!-- <form action="<c:url value='/host/property_detail_3'/>" onsubmit="return check()" name="f" method="post">
	<input type="text" id="address" name = "address" placeholder="주소" readonly
						style="text-align: center; width: 200px; height: 35px;">
	<button type="button" onclick="address_DaumPostcode(); display()" value="주소 검색">
		<span> 주소 검색 </span>
	</button><br><br><br>
	<div id="check" style="display:none">
		<input type="submit" value="위치 확인!">
	</div>
	</form> -->



</body>
</html>