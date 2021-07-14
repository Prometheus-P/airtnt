<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>숙소등록</title>
<style>
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
	<%@include file="top.jsp"%>
	<%@include file="../../top.jsp"%>
	<!-- <form name="f" method="post"
		action="<c:url value='/host/property_detail_1'/>" onsubmit="send()"> -->
	<div class="container theme-showcase" role="main">
		<div class="page-header">
			<h1
				style="font-style: italic; font-weight: bold; font-family: fantasy;">
				숙소의 이름과 설명을 적어 주세요</h1>
		</div>
		<br><br><br>
		<form name="f" method="post" action="<c:url value='/host/price_8'/>" onsubmit="return check()">
				<h3>숙소의 이름은 무엇인가요?</h3>
				<div class="input-group input-group-lg">
					<span class="input-group-addon" id="name-addon">이름</span>
					<div class="input-group input-group-lg">
						<input id="name" type="text" class="form-control" placeholder="ex. 한강이 비춰주는 아침햇살"
							name="name" aria-describedby="name-addon">
					</div>
					
				</div>
				<div class="container">
					<h3>숙소에 대한 상세 설명을 적어주세요</h3>
					<textarea id="description" name="description" class="form-control col-sm-5" rows="7"
					 placeholder="ex. 활기 넘치는 이곳에서의 시간이 마음에 드실 거에요."></textarea>
				</div>
			<footer style="font-size: 30px; font-weight: bold;">
					<div style="float: left; padding-left: 80px; padding-top: 20px">
						<button type="button" class="btn btn-lg btn-default"
							onclick="previous()" style="font-size: 30px; font-weight: bold;">
							<i class="bi bi-arrow-left-square-fill"></i> 
							이전 페이지
						</button>
					</div>
					<div style="float: right; padding-right: 80px; padding-top: 20px;">
						<button  id="next" disabled="disabled" type="submit" class="btn btn-lg btn-default"
						 style="font-size: 30px; font-weight: bold;">
							다음 페이지 <i class="bi bi-arrow-right-square-fill"></i>
						</button>
					</div>
				</footer>
		</form>
		</div>
		<br> <br> <br> <br> <br> <br> <br>
		<script>
				$('#description').change(function(){
					$('#next').removeAttr('disabled');
				});
			function check() {
				if (f.name.value == "") {
					alert("숙소 이름을 적어주세요!");
					f.name.focus();
					return false;
				}
				if (f.description.value == "") {
					alert("숙소 설명을 적어 주세요!");
					f.description.focus();
					return false;
				}
				document.f.submit;
				return true;
			}
			function previous(){
				windo.history.back();
			}
		</script>
</body>
</html>