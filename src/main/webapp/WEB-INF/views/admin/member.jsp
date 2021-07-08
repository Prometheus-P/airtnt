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
		.col{
			font-size:13px;
		}
		
	</style>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function(){
			
			//url 내 파라미터값 가져오기
			var getUrlParameter = function getUrlParameter(sParam) {
		    	var sPageURL = decodeURIComponent(window.location.search.substring(1)),
		    	sURLVariables = sPageURL.split('&'),sParameterName,i;
		    	for (i = 0; i < sURLVariables.length; i++) {
		    		sParameterName = sURLVariables[i].split('=');
		    		if (sParameterName[0] === sParam) {
		    			return sParameterName[1] === undefined ? true : sParameterName[1];
		    		}
		    	}
		    };
		    var member_mode = getUrlParameter('member_mode');
		    
		    //초기 조회시 파라미터값 없으므로 all(0) 으로 세팅
		    if(member_mode == undefined || member_mode == ''){
		    	member_mode = 0;
		    }
		    //멤버구분 라디오버튼 값 설정
		    $('input:radio[name=memberModeRadio]:input[value=' + member_mode + ']').attr("checked", true);
		
			//조회 버튼 클릭시 선택한 멤버구분값 조건으로 조회
		    $("#searchBtn").click(function(){
		        var memberMode = $('input[name="memberModeRadio"]:checked').val();
		        location.href='member?member_mode=' + memberMode; 
		    });
		    
		});	
	</script>
	
	<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
		<h1 class="h2">Member</h1>
		<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom"></div>
		<!-- 멤버 모드 구분 라디오 버튼 -->
		<div id ="memberModeRadio" style="overflow:auto;">
			<div class="custom-control custom-radio custom-control-inline">
			  <input type="radio" id="customRadioInline1" name="memberModeRadio" value="0" class="custom-control-input">
			  <label class="custom-control-label" for="customRadioInline1">All</label>
			</div>
			<div class="custom-control custom-radio custom-control-inline">
			  <input type="radio" id="customRadioInline2" name="memberModeRadio" value="1" class="custom-control-input">
			  <label class="custom-control-label" for="customRadioInline2">Guest</label>
			</div>
			<div class="custom-control custom-radio custom-control-inline">
			  <input type="radio" id="customRadioInline3" name="memberModeRadio" value="2" class="custom-control-input">
			  <label class="custom-control-label" for="customRadioInline3">Host</label>
			</div>
			<button type="button" id="searchBtn" style="float:right;" class="btn btn-primary btn-sm" >조회</button>
		</div>

		<br>

		<!-- 조회 결과 grid -->
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
		<c:if test="${rowCount>0}">
			<nav aria-label="Page navigation example">
			  <ul class="pagination pagination-sm justify-content-center">
			    <li class="page-item">
			    	<c:if test="${startPage>pageBlock}">
			      		<a class="page-link" href="member?pageNum=${startPage-pageBlock}&member_mode=${member_mode}" tabindex="-1">Previous</a>
			      	</c:if>
			    </li>
			    <c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
			    	<li class="page-item"><a class="page-link" href="member?pageNum=${i}&member_mode=${member_mode}">${i}</a></li>
				</c:forEach>
			    <li class="page-item">
			    	<c:if test="${endPage<pageCount}">
			      		<a class="page-link" href="member?pageNum=${startPage + pageBlock}&member_mode=${member_mode}">Next</a>
			      	</c:if>
			    </li>
			  </ul>
			</nav>
		</c:if>	
		
	</main>
</body>