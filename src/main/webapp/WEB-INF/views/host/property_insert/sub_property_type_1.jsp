<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소등록</title>
</head>
<body>
	<%@include file="top.jsp" %>
	<%@include file="../../top.jsp"%>
	<!-- <form name="f" method="post"
		action="<c:url value='/host/property_detail_1'/>" onsubmit="send()"> -->
		<div class="container theme-showcase" role="main">
			<div class="page-header">
				<h1 style="font-style: italic; font-weight: bold; font-family: fantasy;">
				다음 중 가장 비슷하다고 생각하는 유형을 골라주세요</h1>
			</div>
			<div class="col-sm-4">
				<c:forEach var="dto" items="${subPropertyTypeList}">
					<div class="list-group" style="font-family: fantasy;">
						<a href="javascript:void(0)" id="${dto.id}"
							class="list-group-item" onclick="send(${dto.id})">
							<h1 class="list-group-item-heading">${dto.name}</h1>
						</a>
					</div>
				</c:forEach>
				<br><br><br><br><br><br><br><br><br><br><br>
			</div>
	<%@include file='bottom.jsp'%>
	<script>
		function send(id){
			location.href="/host/room_type?subPropertyTypeId="+id;
		}
	</script>
</body>
</html>