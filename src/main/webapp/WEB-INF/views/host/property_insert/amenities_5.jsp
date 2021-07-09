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
	<%@include file="top.jsp" %>
	<%@include file="../../top.jsp"%>
	<!-- <form name="f" method="post"
		action="<c:url value='/host/property_detail_1'/>" onsubmit="send()"> -->
		<div class="container theme-showcase" role="main">
			<div class="page-header">
				<h1 style="font-style: italic; font-weight: bold; font-family: fantasy;">
				숙소 편의시설 정보를 추가해 주세요</h1>
			</div>
			<form name="f" method="post" action="<c:url value='/host/photos_6'/>" onsubmit="return check()">
			<div class="col-sm-4" style="font-family: fantasy;">
				<c:forEach var="dto" items="${listAmenityType}">
					<input type="checkbox" name="amenities" id="${dto.id}" value="${dto.id}" 
					<c:forEach var="regId" items="${sessionScope.listAmenities}"><c:if test="${regId eq dto.id}">checked</c:if></c:forEach>>
					<font style="font-weight: bold; font-family: fantasy; font-size: large;">
					${dto.name}
					</font><br>
				</c:forEach>
				<button type="submit" class="btn btn-lg btn-success">확인</button>
			</div>
			</form>
		</div>
		<br><br><br><br><br><br><br><br><br><br><br>
	<%@include file='bottom.jsp'%>
	<script>
	function check(){
		if($("input:checkbox[name=amenities]:checked").length < 1){
			alert("한 개 이상의 편의시설이 필요합니다!");
			return false;
		}
		document.f.submit;
		return true;
	}
	</script>
</body>
</html>
				
				
		
			