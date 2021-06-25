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
 <form method="post" action="<c:url value='host/save_image'/>" enctype="multipart/form-data">
 <!-- test로 해봄 -->
	<input type="file" name="imageFile">
	<input type="submit" value="이미지 저장">
</form>
</body>
</html>