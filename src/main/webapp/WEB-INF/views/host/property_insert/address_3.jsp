<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소등록</title>
<style>
footer{ 
	position:fixed; 
	left:0px; 
	bottom:0px; 
	height:20%; 
	width:100%; 
	background: #01546b ; 
	color: white; }
</style>
</head>
<body>
	<%@include file="top.jsp"%>
	<%@include file="../../top.jsp"%>
	<div class="container theme-showcase" role="main">
		<div class="page-header">
			<h1 style="font-style: italic; font-weight: bold; font-family: fantasy;">
				주소를 입력해주세요</h1>
				<button type="button" class="btn btn-primary" id="search" name="addressDetail" 
					onclick="address_DaumPostcode(); load()" value="주소 검색">
					<span> 주소 검색 </span>
				</button>
		</div>
		<form name="f" method="post" action="<c:url value='/host/floor_plan_4'/>" onsubmit="return send()">
		<div class="row">
			<div class="col-sm-6">
				<input type="text" id="address" name="address" placeholder="주소"
					readonly="readonly" class="form-control"  required
					style="text-align: center; width: 500px; height: 50px;"
					<c:if test="${not empty sessionScope.checkAddress}">
						value = "${sessionScope.checkAddress}"
						<c:remove var="checkAddress" scope="session"/>
						<c:remove var="address" scope="session"/>
					</c:if>>
				<div id="detail" style="display: none" >
				<br><br>
					<input type="text" class="form-control" id=addressDetail name="addressDetail" 
					style="text-align: center; width: 400px; height: 50px;" placeholder="상세 주소 입력" >
				</div>
				
			</div>
			<div id="field" class="col-sm-6" style="display: none;">
				<div class="alert alert-success" role="alert" >
					<strong>위치가 검색 되었습니다!</strong> 상세주소를 입력하시고, 지도의 위치가 맞다면 다음 페이지로 이동해주세요.
				</div>
				<div id="map" style="width: 350px; height: 350px; margin-left: 80px;margin-top: 10px; float:rigth;"></div>
			</div>
			</div>
				<footer style="font-size: 30px; font-weight: bold;">
					<div style="float: left; padding-left: 80px; padding-top: 20px">
						<button type="button" class="btn btn-lg btn-default"
							onclick="previous()" style="font-size: 30px; font-weight: bold;">
							<i class="bi bi-arrow-left-square-fill"></i> 
							이전 페이지
						</button>
					</div>
					<div id="next" style="float: right; padding-right: 80px; padding-top: 20px; display:none;">
						<button  type="submit" class="btn btn-lg btn-default"
						 style="font-size: 30px; font-weight: bold;">
							다음 페이지 <i class="bi bi-arrow-right-square-fill"></i>
						</button>
					</div>
				</footer>
			</form>
		</div>
		<br> <br> <br> <br> <br> <br> <br>
		<script
			src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=62b11c585fb341eec39dbc28ac9bad71&libraries=services"></script>

		<script>
		function previous(){
			windo.history.back();
		}
			function load(){
				document.getElementById('detail').style.display="block";
				document.getElementById('next').style.display="block";
			}

           function send(){
                if($("#address").val() == ""){
                	alert("주소를 검색해 주세요!!");
                	return false;
                }
                if($("#addressDetail").val() == ""){
                	if(!window.confirm("상세 주소가 없나요?")){
                		return false;
                	}
                }
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