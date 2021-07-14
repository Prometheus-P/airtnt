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
	<!-- <form name="f" method="post"
		action="<c:url value='/host/property_detail_1'/>" onsubmit="send()"> -->
	<div class="container theme-showcase" role="main">
		<div class="page-header">
			<h1 style="font-style: italic; font-weight: bold; font-family: fantasy;">
				새로운 숙소 페이지를 확인하세요!</h1>
		</div>

		<div class="col-sm-6 col-md-4" style="font-family: fantasy;">
			<div class="thumbnail">
			<c:forEach var="dto" items="${listImgUrl}">
				<c:set var="count" value="${count+1}"/>
				<img src="${dto.path}" alt="${count}">
			</c:forEach>
				<div class="caption">
					<h2>${sessionScope.name}</h2>
					<h3>${sessionScope.memeber_name}님이호스팅하는
						${sessionScope.subPropertyType}</h3>
					<hr class="divider" />
					<p>최대 인원 ${sessionScope.maxGuest}명 · 침대${sessionScope.bedCount}개</p>
					<hr class="divider" />
					<p>${sessionScope.description}</p>
					<hr class="divider" />

					<h4>편의 시설<br></h4>
					<p>
						<c:forEach var='amenity' items='${sessionScope.listAmenityName}'>
							${amenity}<br>
						</c:forEach>
					</p>
					
					<hr class="divider" />
					<h4>위치<br></h4>
					<p>${sessionScope.address}</p>
					
					<hr class="divider" />
					<h4>설명<br></h4>
					<p>${sessionScope.description}</p>
					
					<p>
						<a href="<c:url value='/host/publish_celebration'/>" class="btn btn-lg btn-primary" role="button">
						숙소 저장하기</a>
					</p>
				</div>
			</div>
		</div>
	</div>
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
</body>
</html>



