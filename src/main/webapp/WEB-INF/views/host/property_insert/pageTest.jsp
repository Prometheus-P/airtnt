<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>사진 로딩 연습</title>
</head>
<body>
	<c:forEach var="path" items="${listImgUrl}">
		<img src="${path}"/>
	</c:forEach>
</body>
</html>