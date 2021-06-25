<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@include file= "admin_nav.jsp"%> 
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<style>
		#propertyList th {
		    position: sticky;
		    top: 0px;
		}	
		tr, td{
			font-size:13px;
		}
	</style>
</head>
<body>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
        <div style="overflow:auto; height:80%; text-align:center;">
			<div class="table-responsive">
		    	<table class="table table-striped table-sm">
		        	<tr>
			          	<th>회원구분</th>
			          	<th>회원ID</th>
			          	<th>회원명</th>
			          	<th>연락처</th>
			          	<th>성별</th>
			          	<th>최초가입일자</th>
					</tr>
					<c:if test="${empty memberList}">
						<tr>
							<td colspan='6'>등록된 회원이 존재하지 않습니다.</td>
						</tr>		 
					</c:if>
					<c:forEach var="dto" items="${memberList}">
						<tr>
							<td>${dto.mode}</td>
							<td>${dto.id}</td>
							<td>${dto.name}</td>
							<td>${dto.tel}</td>
							<td>${dto.gender}</td>
							<td>${dto.regDate}</td>
						</tr>			
					</c:forEach>
		        </table>
		     </div>
		</div>
	</main>
</body>