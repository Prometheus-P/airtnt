<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form name="f" method="post" action="<c:url value='property_detail_1'/>">
<h2></h2>
<h2>
숙소등록하기 0번 페이지<br>
propertyType 입력
</h2>
<table>
	<tr>
		<c:forEach var="dto" items="${propertyTypeList}">
			<td><input type="radio" name="propertyTypeId" id="${dto.name}" value="${dto.id}"><label for="${dto.name}">${dto.name}</label></td>
		</c:forEach>
	</tr>
	<tr>
		<td><input type="submit" value="전송"/></td>
	</tr>
</table>
</form>
</body>
</html>