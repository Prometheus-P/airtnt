<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
bottom.jsp: 뒤로 & 다음 
preview.jsp에서는 다음X 저장하기O
publish_celebration.jsp에서는 뒤로X
 -->
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<footer style="font-size: 30px; font-weight: bold;" >
	<div style="float: left; padding-left: 80px; padding-top: 20px">
	<button type="button" class="btn btn-lg btn-default" onclick="previous()" style="font-size: 30px; font-weight: bold;" >
		<i class="bi bi-arrow-left-square-fill"></i> 이전 페이지
	</button>
	</div>
	<div style="float: right; padding-right: 80px; padding-top: 20px">
	<button type="button" class="btn btn-lg btn-default" onclick="next()" style="font-size: 30px; font-weight: bold;" > 
	다음 페이지
	<i class="bi bi-arrow-right-square-fill"></i>
	</button>
	</div>
	</footer>
	</form>
	<script>
		function getRecent(){
			var url = document.location.href; 
			var splitUrl = url.split("/");    //   "/" 로 전체 url 을 나눈다
			var urlLength = splitUrl.length;
			var recentPage = splitUrl[urlLength-1];   // 나누어진 배열의 맨 끝이 파일명이다
			return recentPage;
		}
		function previous(){
			var recent = getRecent();
		}
		function next() {
			var recent = getRecent();
		}
	</script>
</body>
</html>