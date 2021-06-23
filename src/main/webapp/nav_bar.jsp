<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<!--basic-->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
	<link href='<c:url value='/resources/layout/styles/layout.css'/>' rel="stylesheet" type="text/css" media="all">
	<!--loginModal-->
	<link href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="/resources/css/modal.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<!-- JAVASCRIPTS -->
	<script src="/resources/layout/scripts/jquery.min.js"></script>
	<script src="/resources/layout/scripts/jquery.backtotop.js"></script>
	<script src="/resources/layout/scripts/jquery.mobilemenu.js"></script>
</head>
<body>
<c:set var="isLogin" value="false"/>
<c:if test="${not empty sessionScope.id && not empty sessionScope.pw}"><c:set var="isLogin" value="true"/></c:if>
	
  <!-- ################################################################################################ -->
  <!-- ################################################################################################ -->
  <!-- ################################################################################################ -->
  <header id="header" class="hoc clear" style="padding-right: 10vh;">
    <div id="logo" class="fl_left"> 
      <!-- ################################################################################################ -->
      <h1><a href="<c:url value='/index'/>">AirTnT</a></h1>
      <!-- ################################################################################################ -->
    </div>
      <div id="pageintro" class="hoc clear justify-content-center" style="padding-top: 5vh;"> 
    <!-- ################################################################################################ -->
        <nav class="navbar navbar-light">
		  <div class="container-fluid" >
		    <form class="d-flex" action="<c:url value='/guest/search'/>" method="get">
		      <input name="addressKey" class="form-control me-2" type="search" placeholder="위치" aria-label="Search" style="height: 50px; width: 300px; font-size: 20px">
		      <button class="btn btn-outline-primary" type="submit" style="background-color:#01546b; border: 0px; height: 50px; width: 100px; font-size: 20px">검색</button>
		    </form>
		  </div>
		</nav>
    <!-- ################################################################################################ -->
  </div>
    
    <nav id="mainav" class="fl_right" > 
      <!-- ################################################################################################ -->
      <ul class="clear">
        <li class="active"><a href="index">호스트 되기</a></li>
        <c:if test="${!isLogin}">
        <li><a class="drop" href="#">로그인 하기</a>
          <ul>
            <li><a href="#LoginModal" class="trigger-btn" data-toggle="modal">로그인</a></li>
            <li><a href="#SignUpModal" class="trigger-btn" data-toggle="modal">회원가입</a></li>
            <li><a href="help">도움말</a></li>
          </ul>
          </c:if>
        <c:if test="${isLogin}">
        <li><a class="drop" href="#">MyPages</a>
          <ul>
            <li><a href="trip">여행</a></li>
            <li><a href="wishlist">위시리스트</a></li>
            <li><a href="pages/sidebar-right.html">호스트 되기</a></li>
            <li><a href="mypage">계정</a></li>
            <li><a href="help">도움말</a></li>
            <li><a href="logout">로그아웃</a></li>
          </ul>
          </c:if>
        </li>
      </ul>
      <!-- ################################################################################################ -->
    </nav>
  </header>
  <!-- ################################################################################################ -->
  <!-- ################################################################################################ -->
  <!-- ################################################################################################ -->





  <!-- ################################################################################################ -->



<!-- LoginModal-->
<div id="LoginModal" class="modal fade">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">
				<div class="avatar">
				</div>				
				<h4 class="modal-title">AirTnT에 오신걸 환영합니다</h4>	
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form action="login" method="post">
					<div class="form-group">
						<input type="text" class="form-control" name="id" placeholder="ID" required="required">		
					</div>
					<div class="form-group">
						<input type="password" class="form-control" name="password" placeholder="Password" required="required">	
					</div>        
					<div class="form-group">
						<button type="submit" class="btn btn-primary btn-lg btn-block login-btn">로그인</button>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<a href="findMember">Forgot Password?</a>
			</div>
		</div>
	</div>
</div> 
<!-- SignUpModal-->
<div id="SignUpModal" class="modal fade">
	<div class="modal-dialog modal-lg modal-login ">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">회 원 가 입</h4>	
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form action="signUp" method="post">
					<div class="form-group">
						<input type="text" class="form-control" name="member_id" placeholder="ID" required="required">		
					</div>
					<div class="form-group">
						<input type="password" class="form-control" name="passwd" placeholder="Password" required="required">	
					</div>        
					<div class="form-group">
						<input type="text" class="form-control" name="member_name" placeholder="이름" required="required">	
					</div>
					<div class="form-group">
						<input type="text" class="form-control" name="birth" placeholder="생년월일 (8자리)" required="required">	
					</div>
					<div class="form-group">
						<input type="text" class="form-control" name="tel" placeholder="연락처(11자리)" required="required">	
					</div>
					<div class="form-group">
						<label><input type="checkbox" class="center" name="gender" value="1" checked="checked"> 남</label>
      					<label><input type="checkbox" class="center" name="gender" value="2"> 여</label>
					</div>
					<div class="form-group">
						<input type="text" class="form-control" name="account" placeholder="계좌번호" required="required">	
					</div>        
					<div class="form-group">
						<button type="submit" class="btn btn-primary btn-lg btn-block login-btn" style="font-size: 15px">동의 및 계속하기</button>
					</div>
				</form>
			</div>
			<div class="modal-footer">
						<p>위의 동의 및 계속하기 버튼을 선택하면, 에어티앤티의 서비스 약관, 결제 서비스 약관, 개인정보 처리방침, 차별 금지 정책에 동의하는 것입니다.</p>
			</div>
		</div>
	</div>
</div>
</body>
</html>