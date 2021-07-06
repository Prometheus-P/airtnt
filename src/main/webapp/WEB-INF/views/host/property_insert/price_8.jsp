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
		<div class="page-header">
			<h1 style="font-style: italic; font-weight: bold; font-family: fantasy;">
				이제 요금을 설정 하실 차례입니다!</h1>
		</div>
		<form name="f" method="post" action="<c:url value='/host/price'/>"
			onsubmit="return check()">
			<div class="btn-group list-group-item"
				style="padding-bottom: 50px; padding-left: 20px; font-weight: bold; sfont-family: fantasy;">
				<input id="decrease-price" type="button" class="btn" value="<i class="bi bi-patch-minus"></i>"
					onclick="changePrice(this)" style="font-size: 50px;">
					
				₩<input id="guest-count" class="form-control btn" type="number"
					name="guestCount" value="${param.price}" min="10000"
					style="width: 600px; height: 100px; font-size: 60px;">
					
				<input id="increase-price" type="button" class="btn" value="<i class="bi bi-patch-plus"></i>"
					onclick="changePrice(this)" style="font-size: 50px;">
			</div>
		</form>
		<br> <br> <br> <br> <br> <br> <br>
		<br> <br> <br> <br>
		<%@include file='bottom.jsp'%>
		<script>
			function check() {
				if (f.name.value == "") {
					alert("숙소 이름을 적어주세요!");
					f.name.focus();
					return false;
				}
				if (f.description.value == "") {
					alert("숙소 설명을 적어 주세요!");
					f.description.focus();
					return false;
				}
				document.f.submit;
				return true;
			}

			function changePrice(button) {
				var idValueArray = button.id.split('-');
				var operation = idValueArray[0];
				var element = idValueArray[1];

				var priceTag = document.querySelector("input#" + element
						+ "-price");
				switch (operation) {
				case "increase":
					if (priceTag.value == "") {
						priceTag.value = 10000;
					} else {
						priceTag.value+=10000;
					}
					break;
				case "decrease":
					if (priceTag.value != "") {
						if (priceTag.value <= 10000) {
							priceTag.value = "";
						} else {
							priceTag.value-=10000;
						}
					}
					break;
				}
			}
		</script>
</body>
</html>