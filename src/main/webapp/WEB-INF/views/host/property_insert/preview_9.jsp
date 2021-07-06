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
	<%@include file="top.jsp"%>
	<%@include file="../../top.jsp"%>
	<!-- <form name="f" method="post"
		action="<c:url value='/host/property_detail_1'/>" onsubmit="send()"> -->
	<div class="container theme-showcase" role="main">
		<div class="page-header">
			<h1 style="font-style: italic; font-weight: bold; font-family: fantasy;">
				새로운 숙소 페이지를 확인하세요!</h1>
		</div>
		
				<div class="col-sm-6 col-md-4" style="font-family: fantasy;">
					<div class="thumbnail">
						<img src="..." alt="...">
						<div class="caption">
							<h3>${sessionScope.memeber_name}님이 호스팅하는 ${sessionScope.subPropertyType }</h3>
							<p>
							
							</p>
							<p>
								<a href="#" class="btn btn-lg btn-primary" role="button">숙소 저장하기</a> 
							</p>
						</div>
					</div>
				</div>
	</div>
	<!-- 	session.setAttribute("bedCount", floor.get("bedCount"));
		session.setAttribute("maxGuest", floor.get("maxGuest"));
		session.setAttribute("name", nameDesc.get("name"));
		session.setAttribute("description", nameDesc.get("description"));
		session.setAttribute("listAmenityName", amenityName); -->
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<%@include file='bottom.jsp'%>
	<script>
		
	</script>
</body>
</html>



