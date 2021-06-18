<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div align="center">
	<!-- 대표 사진 -->
	<div align="left">
		<img src="">
	</div>
	
	<!-- 예약정보 입력란 -->
	<div align="right">
		<form action="booking.com" method="post">
			인원수 <input name="guestNum" type="number" ><br>
			가격 : <input name="price" value="<fmt:formatNumber value="0" type="currency"/>">
			<input type="submit" value="담아두기" formaction="">
			<input type="submit" value="문의하기" formaction=""><br>
			<input type="submit" value="예약하기" formaction="booking.com">
		</form>
	</div>
</div>

<hr>

<!-- 상세 설명 -->
<div align="center">
	<textarea rows="30" cols="10">
		상세설명
	</textarea>
</div>

<hr>

<!-- 편의시설 -->
<div align="center">
	
</div>

<hr>

<div>
	<!-- 별점 -->
	<div align="left">
		★★★★★
	</div>
	<!-- 후기 -->
	<div align="right">
		후기
	</div>
</div>

<!-- 다른 숙소들 목록 -->
<div>
	이런 숙소는 어떠세요?
</div>

</body>
</html>