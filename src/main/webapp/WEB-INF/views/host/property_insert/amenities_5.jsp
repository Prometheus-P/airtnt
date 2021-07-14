<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소등록</title>
<style>
input[type=checkbox] {

zoom: 2.0;

}
footer{ 
	position:fixed; 
	left:0px; 
	bottom:0px; 
	height:20%; 
	width:100%; 
	background: #01546b ; 
	color: white; }
</style>
</head>
<body>
	<%@include file="top.jsp" %>
	<%@include file="../../top.jsp"%>
	<!-- <form name="f" method="post"
		action="<c:url value='/host/property_detail_1'/>" onsubmit="send()"> -->
		<div id="mainBody" class="container theme-showcase" role="main">
			<div class="page-header">
				<h1 style="font-style: italic; font-weight: bold; font-family: fantasy;">
				숙소 편의시설 정보를 추가해 주세요</h1>
			</div>
			<form name="f" method="post" action="<c:url value='/host/photos_6'/>" onsubmit="return check()">
			<div class="col-sm-6" style="font-family: fantasy;">
				<c:forEach var="dto" items="${listAmenityType}">
					<input class="checkbox" type="checkbox" name="listAmenity" id="${dto.id}" value="${dto.id}" 
						<c:forEach var="regId" items="${sessionScope.listAmenities}">
							<c:if test="${regId eq dto.id}">checked</c:if>
						</c:forEach> >
					<font style="font-weight: bold; font-family: fantasy; font-size: large;">
					${dto.name}
					</font><br>
				</c:forEach>
				<footer style="font-size: 30px; font-weight: bold;">
					<div style="float: left; padding-left: 80px; padding-top: 20px">
						<button type="button" class="btn btn-lg btn-default"
							onclick="previous()" style="font-size: 30px; font-weight: bold;">
							<i class="bi bi-arrow-left-square-fill"></i> 
							이전 페이지
						</button>
					</div>
					<div id="next" style="float: right; padding-right: 80px; padding-top: 20px; display:none;">
						<button  type="submit" class="btn btn-lg btn-default"
						 style="font-size: 30px; font-weight: bold;">
							다음 페이지 <i class="bi bi-arrow-right-square-fill"></i>
						</button>
					</div>
				</footer>
			</div>
			
			</form>
		</div>
		<br><br><br><br>
	<script>
	$('.checkbox').click(function(){
		document.getElementById('next').style.display="block";
	});
	function check(){
		if($("input:checkbox[name=listAmenity]:checked").length < 1){
			alert("한 개 이상의 편의시설이 필요합니다!");
			return false;
		}
		return true;
	}
	function previous(){
		windo.history.back();
	}
	</script>
</body>
</html>
				
				
		
			