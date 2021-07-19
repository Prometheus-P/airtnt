<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소등록</title>
<style>
input[type=checkbox] {
	zoom: 2.0;
}
</style>
</head>
<body>
	<%@include file="insert_top.jsp"%>
	<%@include file="../../top.jsp"%>
	<!-- <form name="f" method="post"
		action="<c:url value='/host/property_detail_1'/>" onsubmit="send()"> -->
	<div id="mainBody" class="container theme-showcase" role="main">
		<div class="page-header">
			<h1
				style="font-style: italic; font-weight: bold; font-family: fantasy;">
				새로운 숙소 페이지를 확인하세요!</h1>
		</div>
		<div class="col-sm-6" style="font-family: fantasy;">
			<div class="thumbnail">
				<div id="propertyImg"></div>
				<%-- <img src="${path}" alt="${count+1}"> --%>
				<div class="caption">
					<h2>${name}</h2>
					<h3>${sessionScope.memeber_name}님이호스팅하는
						${subPropertyTypeName}</h3>
					<hr class="divider" />
					<p>최대 인원 ${maxGuest}명 ·
						침대${bedCount}개</p>
					<hr class="divider" />
					<h4>
						편의 시설<br>
					</h4>
					<p>
						<c:forEach var='amenity' items='${listAmenity}'>
							<i class="bi bi-check">${amenity.name}</i>
							<br>
						</c:forEach>
					</p>

					<hr class="divider" />
					<h4>
						위치<br>
					</h4>
					<p>${address}</p>

					<hr class="divider" />
					<h4>
						설명<br>
					</h4>
					<p>${description}</p>

				</div>
			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<footer style="font-size: 30px; font-weight: bold;">
		<div style="float: left; padding-left: 250px; padding-top: 20px">
			<button type="button" class="btn btn-lg btn-default"
				onclick="previous()" style="font-size: 30px; font-weight: bold;">
				<i class="bi bi-arrow-left-square-fill"></i> 이전 페이지
			</button>
		</div>
		<div style="float: right; padding-right: 250px; padding-top: 20px;">
			<button id="save" type="button" class="btn btn-lg btn-default"
				style="font-size: 30px; font-weight: bold;">
				숙소 저장 <i class="bi bi-arrow-right-square-fill"></i>
			</button>
		</div>
	</footer>
</body>
<script>
	$('#mainBody').load(function (){
		var length = parseInt(localStorage.getItem('length'));
		for(var x; x<length; ++x){
			var src= localStorage.getItem('image'+x);
			var img = document.createElement("img");
	        img.setAttribute("src", src);
	        document.querySelector("div#propertyImg").appendChild(img);
		}
	});
	
	$(document).ready(function() {
		$('#save').bind('click', function() {
			doSomething();
		});
	});

	var doSomething = function() {
		$('#save').unbind('click');
		$.ajax({
			url : "/host/property_save",
			type : "post",
			success : function(data) {
				if (JSON.parse(data)['result'] == "OK") {
					localStorage.clear();
					alert("숙소가 저장 되었습니다! 호스트 메인 페이지로 이동합니다!")
					location.href = "/host/host_mode";
				} else {
					alert("숙소 저장 중 문제 발생! 관리자에게 연락바랍니다!");
				}
			},
			error : function(xhr, status, error) {
				alert("서버오류로 지연되고있습니다. 잠시 후 다시 시도해주시기 바랍니다.");
			}
		});
	}
	function previous() {
		window.history.back();
	}
</script>
</html>



