<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@include file= "admin_nav.jsp"%>    
<html>
<head>
</head>
<body>
	<script>
		var num = 1;
	</script>
	<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
		<h1 class="h2">Guide Board Content</h1>
		<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom"></div>
		<form name="f" action="guideUpdate" method="post">
		
		<!-- 제목과 설명 부분 -->
		<c:forEach var="dto" items="${boardList}" begin="0" end="0">
			 <input type="hidden" name="guideId" value="${dto.guideId}">
			 <div class="form-group">
			   <label for="exampleFormControlInput1">Title</label>
			   <input type="text" class="form-control" id="subject" name="subject" value="${dto.subject}">
			 </div>
			  <div class="form-group">
			   <label for="exampleFormControlTextarea1">Explanation</label>
			   <textarea class="form-control" id="explanation" name="explanation" rows="2">${dto.explanation}</textarea>
			 </div>
		</c:forEach>
		
		<!-- context 부분 -->
		<c:forEach var="dto" items="${boardList}" varStatus="status">
			<div class="form-group">
		   		<label for="exampleFormControlTextarea1">Content${status.count}</label>
		   		<textarea class="form-control" id="context" rows="3" name="contextArr">${dto.context}</textarea>
		   		<input type="hidden" name="idArr" value="${dto.id}">
		 	</div>
		</c:forEach>
			<div align="center">
				<input type="reset" value="초기화">
				<input type="submit" value="수정">
				<input type="button" value="목록" onclick="location.href='guidelist'">
			 </div>
		</form>
	</main>
</body>
</html>