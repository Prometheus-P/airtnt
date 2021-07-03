<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 1. 외부에서 '호스트 되기' 또는 '새로운 숙소 만들기' 클릭시>> before_host
	시작하기 클릭시
	>> property_type & sub_property_type & room_type & maxGuest & bedCount(property_detail_1) -->
<html>
<head>
<meta charset="UTF-8">
<title>숙소등록</title>
</head>
<body>
<%@include file="top.jsp" %>
<%@include file="../../top.jsp"%>
	
<input type="text" class="form-control" placeholder="Text input">
<form method="post" action="<c:url value='/host/property_address_2'/>" name="f">
<table>
	<tr>
	<td></td>
	<c:forEach var="dto" items="${subPropertyTypeList}">
			<td><input type="radio" name="subPropertyTypeId" id="${dto.name}" value="${dto.id}"><label for="${dto.name}">${dto.name}</label></td>
		</c:forEach>
	</tr>
	<tr>
		<c:forEach var="dto" items="${roomTypeList}">
			<td><input type="radio" name="roomTypeId" id="${dto.name}" value="${dto.id}"><label for="${dto.name}">${dto.name}</label></td>
		</c:forEach>
	</tr>
	<tr>
		<td>
		침대 갯수<br>
		<input type="number" name="bedCount"/>
		</td>
	</tr>
	<tr>
		<td>
		최대 수용 인원<br>
		<input type="number" name="maxGuest"/>
		</td>
	</tr>
	<tr>
		<td><input type="submit" value="확인"/></td>
	</tr>
</table>
</form>
</body>
</html>






