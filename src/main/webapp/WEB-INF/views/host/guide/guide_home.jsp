<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AirTnT</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href='<c:url value='/resources/layout/styles/layout.css'/>'
	rel="stylesheet" type="text/css" media="all">
	<link href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="/resources/css/modal.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<c:set var="isLogin" value="false" />
	<c:if test="${not empty member_id && not empty member_name}">
		<c:set var="isLogin" value="true" />
	</c:if>
	<div class="bgded overlay padtop"
		style="background-image:url('<c:url value='/resources/img/main3.jpg'/>');">
		<!-- ################################################################################################ -->
		<!-- ################################################################################################ -->
		<!-- ################################################################################################ -->
		<header id="header" class="hoc clear">
			<div id="logo" class="fl_left">
				<!-- ################################################################################################ -->
				<h1>
					<a href="index">AirTnT</a>
				</h1>
				<!-- ################################################################################################ -->
			</div>
			<nav id="mainav" class="fl_right">
				<!-- ################################################################################################ -->
				<a class="btn" href="<c:url value='/host/property_insert'/>">시작하기</a>
				<ul class="clear">
					<c:if test="${!isLogin}">
						<li><a class="drop" href="#">로그인 하기</a>
							<ul>
								<li><a id="login-button" href="#LoginModal"
									class="trigger-btn" data-toggle="modal">로그인</a></li>
								<li><a id="signUp-button" href="#SignUpModal"
									class="trigger-btn" data-toggle="modal">회원가입</a></li>
								<li><a href="help">도움말</a></li>
							</ul>
					</c:if>
					<c:if test="${isLogin}">
						<li class="active"><c:if test="${member_mode == 2}">
								<a href="<c:url value='/host/host_mode'/>">호스트 모드로 전환</a>
								<c:set var='isHostMode' value='true' scope='session' />
							</c:if></li>
						<li><a class="drop" href="#">MyPages</a>
							<ul>
								<li><a href="/tour">여행</a></li>
								<li><a href="/wishList">위시리스트</a></li>
								<li><a href="/myPage">계정</a></li>
								<li><a href="/help">도움말</a></li>
								<li><a href="/logout?preURI=${currentURI}">로그아웃</a></li>
							</ul></li>
					</c:if>
				</ul>
				<!-- ################################################################################################ -->
			</nav>
		</header>
		<!-- ################################################################################################ -->
		<!-- ################################################################################################ -->
		<!-- ################################################################################################ -->
		<div id="pageintro" class="hoc clear">
			<!-- ################################################################################################ -->
			<article>
				<h3 class="heading">
					공간을 나누고 <br>새로운 세상을 얻다
				</h3>
				<p>에어티앤티의 호스트가 되면 남는 공간을 활용해 부수입을 올리고 진짜 하고 싶은 일에 매진할 수 있습니다.</p>
				<footer>
					<ul class="nospace inline pushright">
						<li><a class="btn"
							href="<c:url value='/host/property_insert'/>">시작하기</a></li>
					</ul>
				</footer>
			</article>
			<!-- ################################################################################################ -->
		</div>
		<!-- ################################################################################################ -->
	</div>
	<!-- End Top Background Image Wrapper -->
	<!-- ################################################################################################ -->
	<!-- ################################################################################################ -->
	<!-- ################################################################################################ -->

	<!-- ################################################################################################ -->
	<!-- ################################################################################################ -->
	<!-- ################################################################################################ -->
	<div class="wrapper row3">
		<main class="hoc container clear"> <!-- main body --> <!-- ################################################################################################ -->
		<section id="services">
			<div class="sectiontitle">
				<p class="nospace font-xs">에어티앤티에서 호스팅 하기</p>
				<h6 class="heading">기초적인 호스팅 방법을 확인해 보세요</h6>
			</div>

			<ul class="nospace group grid-3">
				<c:forEach var="dto" items="${listGuide}">
					<li class="one_third">
						<article>
							<a href="<c:url value='/guide_context?id=${dto.id}'/>"><i
								class="fas fa-spray-can"></i></a>
							<h6 class="heading">${dto.subject}</h6>
							<p>${dto.explanation}.</p>
							<footer>
								<a href="<c:url value='/guide_context?id=${dto.id}'/>">더보기
									&raquo;</a>
							</footer>
						</article>
					</li>
				</c:forEach>
			</ul>
		</section>
		<!-- ################################################################################################ -->
		<!-- / main body -->
		<div class="clear"></div>
		</main>
	</div>
	<div class="wrapper row4">
		<%@include file="../../bottom.jsp"%>
	</div>
	<div class="wrapper row5">
		<div id="copyright" class="hoc clear">
			<!-- ################################################################################################ -->
			<p class="fl_left">
				Copyright &copy; 2018 - All Rights Reserved - <a href="#">Domain
					Name</a>
			</p>
			<p class="fl_right">
				Template by <a target="_blank" href="https://www.os-templates.com/"
					title="Free Website Templates">OS Templates</a>
			</p>
			<!-- ################################################################################################ -->
		</div>
	</div>
	<!-- ################################################################################################ -->
	<!-- ################################################################################################ -->
	<!-- ################################################################################################ -->
	<a id="backtotop" href="#top"><i class="fas fa-chevron-up"></i></a>
	<!-- LoginModal-->
	<div id="LoginModal" class="modal fade">
		<div class="modal-dialog modal-login">
			<div class="modal-content">
				<div class="modal-header">
					<div class="avatar"></div>
					<h4 class="modal-title">AirTnT에 오신걸 환영합니다</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">
					<form action="login" method="post">
						<div class="form-group">
							<c:if test="${empty value}">
								<input type="text" class="form-control" name="id"
									placeholder="ID" required="required">
							</c:if>
							<c:if test="${not empty value}">
								<input type="text" class="form-control" name="id"
									placeholder="ID" required="required" value="${value}">
							</c:if>
						</div>
						<div class="form-group">
							<input type="password" class="form-control" name="passwd"
								placeholder="Password" required="required">
						</div>
						<div class="form-group">
							<button type="submit"
								class="btn btn-primary btn-lg btn-block login-btn">로그인</button>
						</div>
						<div class="form-group">
							<c:if test="${empty value}">
								<input type="checkbox" name="saveId">
							</c:if>
							<c:if test="${not empty value}">
								<input type="checkbox" name="saveId" checked>
							</c:if>
							<p>아이디 기억하기</p>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<a href="findMember">Forgot Password?</a>
				</div>
			</div>
		</div>
	</div>

	<!-- JAVASCRIPTS -->
	<script src="/resources/layout/scripts/jquery.min.js"></script>
	<script src="/resources/layout/scripts/jquery.backtotop.js"></script>
	<script src="/resources/layout/scripts/jquery.mobilemenu.js"></script>
</body>
</html>
