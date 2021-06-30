<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- hosting_listing.jsp : 호스트가 등록한 숙소 목록 -->
<html>
<head>
<meta charset="UTF-8">
<title>숙소 목록</title>
</head>
<%@ include file="top.jsp"%>
<body>
	
		<div class="container theme-showcase" role="main">
		<div class="col-md-6">
		<div class="page-header">
		<br><br><br>
			<h1>숙소 목록</h1>
		</div>
		<div class="list-group">
		<c:forEach var="dto" items="${listProperty}">
			<a href="#modal" class="list-group-item">
				<h4 class="list-group-item-heading">${dto.name}</h4>
				<p class="list-group-item-text">
				가격: ${dto.price}  
				등록일: ${dto.regDate}  
				최대인원: ${dto.maxGuest}  
				숙소유형: ${dto.roomTypeName}
				</p>
			</a>
		</c:forEach>
		</div>
	</div>
	</div>
</body>
</html>
<!--< include file="../bottom.jsp" %>-->