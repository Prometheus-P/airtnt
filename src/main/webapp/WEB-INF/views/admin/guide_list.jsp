<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@include file= "admin_nav.jsp"%>    
<html>
<head>
</head>
<body>
	<script>
		$(document).ready(function(){
		   	$("#addBtn").click(function(){
		   		location.href="guideWrite";
		    });
		})
	</script>
	<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
		<h1 class="h2">Guide Board Form</h1>
		<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom"></div>
		<div><button class="btn btn-sm btn-outline-secondary" id="addBtn" style="float:right;">추가</button></div>
		<br><br>
		<table class="table table-striped table-sm" id="boardTable" style="text-align:center;">
			<tr class = "thead-dark" style='position:relative;top:expression(this.offsetParent.scrollTop);'>
				<th>ID</th>
				<th>SUBJECT</th>
				<th>REG_DATE</th>
				<th>삭제</th>
			</tr>
			<c:if test="${empty boardList}">
				<tr>
					<td colspan='4'>등록된 가이드 게시물이 없습니다.</td>
				</tr>		 
			</c:if>
			<c:forEach var="dto" items="${boardList}">
				<tr>
					<td>${dto.contentId}</td>
					<td><a href="guideView?contentId=${dto.contentId}">${dto.subject}</a></td>
					<td>${dto.regDate}</td>
					<td><a href="guideDelete?contentId=${dto.contentId}">삭제</a></td>
				</tr>			
			</c:forEach>
		</table>
		<!-- 페이징처리 -->
		<nav aria-label="Page navigation example">
		  <ul class="pagination pagination-sm justify-content-center">
		    <li class="page-item disabled">
		      <a class="page-link" href="#" tabindex="-1">Previous</a>
		    </li>
		    <li class="page-item"><a class="page-link" href="#">1</a></li>
		    <li class="page-item"><a class="page-link" href="#">2</a></li>
		    <li class="page-item"><a class="page-link" href="#">3</a></li>
		    <li class="page-item">
		      <a class="page-link" href="#">Next</a>
		    </li>
		  </ul>
		</nav>
	</main>
</body>
</html>