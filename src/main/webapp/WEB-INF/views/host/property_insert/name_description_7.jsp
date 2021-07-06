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
			<h1
				style="font-style: italic; font-weight: bold; font-family: fantasy;">
				숙소의 이름과 설명을 적어 주세요</h1>
		</div>
		<form name="f" method="post" action="<c:url value='/host/price'/>"
			onsubmit="return check()">
			<div class="col-sm-4" style="font-family: fantasy;">
				<h3>숙소의 이름은 무엇인가요?</h3>
				<span class="input-group-addon" id="name-addon">이름</span>
				<div class="input-group input-group-lg">
					<input type="text" class="form-control" placeholder="ex. 한강이 비춰주는 아침햇살"
						aria-describedby="name-addon">
				</div>
				<div class="container">
					<h3>숙소에 대한 상세 설명을 적어주세요</h3>
					<textarea class="form-control col-sm-5" rows="7"
					 placeholder="ex. 활기 넘치는 이곳에서의 시간이 마음에 드실 거에요."></textarea>
				</div>
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
		</script>
</body>
</html>