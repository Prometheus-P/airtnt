<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- top.jsp -->
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>

	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> 
					<span class="icon-bar"></span>
					<span class="icon-bar"></span> 
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand">${sessionScope.member_name}님 환영합니다</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="<c:url value='/host/host_mode'/>">투데이</a></li>
					<li><a href="<c:url value='/host/host_properties_list'/>">숙소</a></li>
					<li><a href="<c:url value='/host/transaction_list'/>">대금수령 내역</a></li>
					<li><a href="#">채팅</a></li>
					<li class="dropdown"><a id="drop4" href="#" class="dropdown-toggle" data-toggle="dropdown">
					메뉴 
					<span class="caret"></span>
					</a>
						<ul class="dropdown-menu">
							<li><a href="<c:url value='/host/host_review_list'/>">리뷰</a></li>
							<li class="divider"></li>
							<li><a href="<c:url value='/host/property_type_0'/>">새 숙소 생성</a></li>
							<li class="dropdown-header">메롱</li>
						</ul></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</nav>

	<script type="text/javascript">
		$('li').click(function() {
			$('li').removeClass('active'); 
			$(this).addClass('active');
		});
	</script>

</body>
</html>