<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<html>
<head>
</head>
<body>
	<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
	<script>
    
    $(document).ready(function(){
    	 $("table td").click(function(){
             var txt = $(this).text();
             alert(txt);
         });
    	
    }
  </script>

	<h2>숙소 필터 관리</h2>
	<table id="propertyList" border="1" width="500">
		<tr>
			<th>대분류코드</th>
			<th>대분류명</th>
		</tr>
		<c:if test="${empty propertyList}">
			<tr>
				<td colspan='2'>등록된 필터 대분류가 없습니다.</td>
			</tr>		 
		</c:if>
		<c:forEach var="dto" items="${propertyList}">
			<tr>
				<td>${dto.id}</td>
				<td>${dto.name}</td>
			</tr>			
		</c:forEach>
	</table>
	<br>
	<table border="1" width="500">
		<tr>
			<th>대분류코드</th>
			<th>중분류코드</th>
			<th>중분류명</th>
		</tr>
		<c:if test="${empty subPropertyList}">
			<tr>
				<td colspan='3'>등록된 필터 중분류가 없습니다.</td>
			</tr>		 
		</c:if>
		<c:forEach var="dto" items="${subPropertyList}">
			<tr>
				<td>${dto.property_type_id}</td>
				<td>${dto.id}</td>
				<td>${dto.name}</td>
			</tr>			
		</c:forEach>
	</table>
</body>