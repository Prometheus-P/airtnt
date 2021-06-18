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

<form method="get">
	<!-- 검색 필터 -->
	<div id="filter" align="center">
		<label>편의시설</label>
		<!-- <input type="checkbox" name="bath_num" value=""> 침대 수<input type="number" ><br>
		<input type="checkbox" name="" value="">침ㅅ 수<input type="number" ><br>
		<input type="checkbox" name="convenience" value=""> 욕실 수<input type="number" ><br> -->
	</div>
	<!-- 정렬 조건, 검색 키워드 입력란 -->
	<div align="center">
		<select name="sort">
			<option value="none">정렬조건</option>
			<option value="near">거리순</option>
			<option value="recent">최신순</option>
			<option value="rating">별점순</option>
		</select>
		<input type="text" name="key">
		<input type="submit" value="검색">
	</div>
</form>

<!-- 숙소 목록 -->
<div>
	숙소 목록<!-- room_detail.jsp -->
</div>

<!-- 최근 목록 -->
<div>
	최근 목록
</div>

</body>
</html>