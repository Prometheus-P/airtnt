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
				<table class="table table-striped">
					<thead>
						<tr>
							<th>#</th>
							<th>가격</th>
							<th>등록일</th>
							<th>최대인원</th>
							<th rowspan="2">숙소유형</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="dto" items="${listProperty}">
					<c:set var="count" value="${count+1}"/>
						<tr>
							<td>${count}</td>
							<td>${dto.price}</td>
							<td>${dto.regDate}</td>
							<td>${dto.maxGuest}</td>
							<td>${dto.roomTypeName}</td>
							<td><button type="button" class="btn btn-sm btn-primary">세부정보</button></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
</body>
</html>
<!--< include file="../bottom.jsp" %>-->
							
							
							
							
							
							
							
							