<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- hosting_mode_main.jsp: 호스트 모드로 전환 시 -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>투데이</title>
</head>
<%@ include file="top.jsp" %>
<body>
	<div align="left"><h2>투데이</h2></div>
	<div>
		<h3>예약</h3>
		<c:if test="${empty listBooking}">
			게스트가 숙소를 예약하면 여기에 표시됩니다.
		</c:if>
		<c:forEach var="dto"items="${listBooking}">
			
		</c:forEach>
	</div>
	
</body>
</html>
<!--< include file="../bottom.jsp" %>-->