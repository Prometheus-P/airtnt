<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- top.jsp -->
<html>
<head>
<meta charset="UTF-8">
<title>top</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="nav-item">
			<a class="nav-link active" aria-current="page" href="#">투데이</a>
		</li>
		<li class="nav-item">
			<a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">채팅</a>
		</li>
		<li class="nav-item">
			<a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">인사이트</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="#">달력</a>
		</li>
		<li class="nav-item dropdown">
		<a class="nav-link dropdown-toggle"data-bs-toggle="dropdown" href="#" role="button"
			aria-expanded="false"> 메뉴 </a>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="#">숙소</a></li>
				<li><a class="dropdown-item" href="#">새로운 숙소 등록하기</a></li>
				<li><hr class="dropdown-divider"></li>
				<li><a class="dropdown-item" href="#">대금 수령 내역</a></li>
			</ul></li>
	</ul>
</body>
</html>