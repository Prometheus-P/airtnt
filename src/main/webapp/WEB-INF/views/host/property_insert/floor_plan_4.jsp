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
	<!-- <form name="f" method="post"
		action="<c:url value='/host/property_detail_1'/>" onsubmit="send()"> -->
	<div class="container theme-showcase" role="main">
		<div class="page-header" style="font-style: italic; font-family: fantasy;">
			<h1 style="font-weight: bold;">
				숙소에서 맞이 할 최대 인원 수를 알려주세요</h1><br>최소 1로 저장 됩니다
		</div>
		<form name="f" method="post" action="<c:url value='/host/amenities_5'/>" onsubmit="return check();">
			<div class="btn-group list-group-item"
				style="padding-bottom: 70px; padding-left: 20px; font-family: fantasy;">
				<h3>최대 수용 인원</h3>
				<input id="decrease-guest" type="button" class="btn" value="-"
					onclick="changeCount(this)" style="font-size: 40px;"> 
					
					<input id="guest-count" class="form-control btn" type="number"
					name="maxGuest" 
					value="${param.maxGuest}" 
					min="1" readonly
					style="width: 80px; height: 70px; font-size: 50px;">
					
					<input id="increase-guest" type="button" class="btn" value="+"
					onclick="changeCount(this)" style="font-size: 40px;">
			</div>
			<div class="btn-group list-group-item"
				style="padding-bottom: 70px; padding-left: 20px; font-family: fantasy;">
				<h3>침대 수</h3>
				<input id="decrease-bed" type="button" class="btn" value="-"
					onclick="changeCount(this)" style="font-size: 40px;">
					<input id="bed-count" class="form-control btn" type="number"
					name="bedCount" value="${param.bedCount}" min="1" readonly
					style="width: 80px; height: 70px; font-size: 50px;">
					<input id="increase-bed" type="button" class="btn" value="+"
					onclick="changeCount(this)" style="font-size: 40px;">
			</div>
			<br><br><br>
			<button type="submit" class="btn btn-lg btn-success">확인</button>
		</form>
		<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		<%@include file='bottom.jsp'%>
		<script>
			function check(){
				if(document.f.bedCount == ""){
					window.alert("침대 수를 정해주세요!");
					return false;
				}
				if(document.f.maxGuest == ""){
					window.alert("최대 인원 수를 정해주세요!");
					return false;
				}
				return true;
			}
			function changeCount(button) {
				var idValueArray = button.id.split('-');
				var operation = idValueArray[0];
				var element = idValueArray[1];

				var countTag = document.querySelector("input#" + element
						+ "-count");
				switch (operation) {
				case "increase":
					if (countTag.value == "") {
						countTag.value = 1;
					} else {
						countTag.value++;
					}
					break;
				case "decrease":
					if (countTag.value != "") {
						if (countTag.value <= 1) {
							countTag.value = "";
						} else {
							countTag.value--;
						}
					}
					break;
				}
			}
		</script>
</body>
</html>

<!-- 
1. 숙소에서 맞이 할 최대 인원 수를 알려주세요(floor_plan)
2. 숙소 편의시설 정보를 추가해 주세요(amenities)
3. 이제 숙소 사진을 올릴 차례입니다(photos)
4. 숙소 이름을 만들어 주세요(room_name)
5. 숙소에 대해 설명해 주세요(description)
6. 이제 요금을 설정 하실 차례입니다!(price)
7. 마지막으로 법률 상황을 확인 해주세요(legal)
-->