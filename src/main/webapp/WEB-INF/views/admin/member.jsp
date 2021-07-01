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
	<script type="text/javascript">
	var memberMode = "all"; //회원구분 파라미터
	
	$(document).ready(function(){
		//ajax 공통 필요 변수
    	var token = $("input[name='_csrf']").val();
		var header = "X-CSRF-TOKEN";
		
		/* 라디오 버튼 이벤트 */
		$('#memberModeRadio').change(function() {
			var checkedRadio = $('#memberModeRadio input:radio:checked').val();
			alert(checkedRadio);
		});
		
		// 조회
		$("#searchBtn").click(function(){
			$.ajax({
  		        url: "member",
  		        type: "GET",
  		        beforeSend : function(xhr)
  		        {
  		        	xhr.setRequestHeader(header, token);
  		        },
  		        data: {
  		        	member_mode : memberMode
  		        },
  		        success: function(res){
  		        	document.location.href = document.location.href; //페이지 새로고침
  		        },
  		        error: function(){
  		            alert("err발생");
  		        }
  		});
	    });
		
		
	});	
	</script>
	
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
		<h1 class="h2">Member</h1>
		<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom"></div>
		<div id ="memberModeRadio" style="overflow:auto;">
			<div class="custom-control custom-radio custom-control-inline">
			  <input type="radio" id="customRadioInline1" name="memberModeRadio" class="custom-control-input">
			  <label class="custom-control-label" for="customRadioInline1" value="all">All</label>
			</div>
			<div class="custom-control custom-radio custom-control-inline">
			  <input type="radio" id="customRadioInline2" name="memberModeRadio" class="custom-control-input">
			  <label class="custom-control-label" for="customRadioInline2" value="1">Guest</label>
			</div>
			<div class="custom-control custom-radio custom-control-inline">
			  <input type="radio" id="customRadioInline3" name="memberModeRadio" class="custom-control-input">
			  <label class="custom-control-label" for="customRadioInline3" value="2">Host</label>
			</div>
			<button type="button" id="searchBtn" style="float:right;" class="btn btn-primary btn-sm" >조회</button>
		</div>
		<br>
        <div style="overflow:auto; text-align:center;">
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
							<td>${dto.member_mode}</td>
							<td>${dto.id}</td>
							<td>${dto.name}</td>
							<td>${dto.tel}</td>
							<td>${dto.gender}</td>
							<td>${dto.reg_date}</td>
						</tr>			
					</c:forEach>
		        </table>
		     </div>
		</div>
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