<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AirTnT</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<!--basic-->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous"> -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script> -->
	<link href="/resources/layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
	
	<!--loginModal-->
	<link href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="/resources/css/modal.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="/resources/script/check.js"></script>
	<!--ratingStar  -->
	<link rel="stylesheet" href="/resources/css/jquery.raty.css">
	<script src="/resources/script/jquery.raty.js"></script>
	<!-- JAVASCRIPTS
	<script src="layout/scripts/jquery.min.js"></script>
	<script src="layout/scripts/jquery.backtotop.js"></script>
	<script src="layout/scripts/jquery.mobilemenu.js"></script> -->

</head>
<body>
	<c:set var="isLogin" value="false"/>
	<c:if test="${not empty member_id && not empty member_name}"><c:set var="isLogin" value="true"/></c:if>
  <!-- ################################################################################################ -->
  <!-- ################################################################################################ -->
  <header id="header" class="hoc clear" style="padding-right: 10vh;">
    <div id="logo" class="fl_left"> 
      <!-- ################################################################################################ -->
      <h1 style="font-size: 25px">
        <a href="/"><img src="/resources/images/paper-plane-logo.png"
        style="width: 30px;height: 30px;"> AirTnT</a>
      </h1>
      <!-- ################################################################################################ -->
    </div>
    <nav id="mainav" class="fl_right" > 
      <!-- ################################################################################################ -->
      <ul class="clear">
      
        <li class="active">
        <c:if test="${isLogin}">
        	<c:if test="${sessionScope.member_mode.trim() == '1'}">
       			<a href="/guide_home">호스트 되기</a>
       			<c:set var='isHostMode' value='false' scope='session'/>
        	</c:if>
        	<c:if test="${sessionScope.member_mode.trim() == '2'}">
        		<c:choose>
        			<c:when test="${sessionScope.isHostMode}">
        				<a href="<c:url value='/host/host_mode'/>">호스트 홈으로</a>
        			</c:when>
        			<c:otherwise>
        				<a href="/host/host_mode">호스트 모드로 전환</a>
        				<c:set var='isHostMode' value='true' scope='session'/>
        			</c:otherwise>
        		</c:choose>
        	</c:if>
        </c:if>
        
        <c:if test="${!isLogin}">
        	<a href="/guide_home">호스트 되기</a>
        </c:if>
        </li>
        <c:if test="${!isLogin}">
        <li><a class="drop" href="#">로그인 하기</a>
          <ul>
            <li><a id="login-button" href="#LoginModal" class="trigger-btn" data-toggle="modal">로그인</a></li>
            <li><a id="signUp-button" href="#SignUpModal" class="trigger-btn" data-toggle="modal">회원가입</a></li>
            <li><a href="help">도움말</a></li>
          </ul>
          </c:if>
        <c:if test="${isLogin}">
        <li><a class="drop" href="#">MyPages</a>
          <ul>
            <li><a href="/tour">여행</a></li>
            <li><a href="/wishList">위시리스트</a></li>
            <li><a href="/myPage">계정</a></li>
            <li><a href="/help">도움말</a></li>
            <li><a href="/logout?preURI=${currentURI}">로그아웃</a></li>
          </ul>
        </li>
        </c:if>
      </ul>
      <!-- ################################################################################################ -->
    </nav>
  </header>
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
				<form action="/login" method="post">
					<input type="hidden" name="preURI" value="${currentURI}">
					<div class="form-group">
						<c:if test="${empty value}">		
							<input type="text" class="form-control" name="id" placeholder="ID" required="required">
						</c:if>
						<c:if test="${not empty value}">
							<input type="text" class="form-control" name="id" placeholder="ID" required="required" value="${value}">		
						</c:if>
					</div>
					<div class="form-group">
						<input type="password" class="form-control" name="passwd" placeholder="Password" required="required">	
					</div>        
					<div class="form-group">
						<button type="submit" class="btn btn-primary btn-lg btn-block login-btn">로그인</button>
					</div>
					<div class="form-group">
						<c:if test="${empty value}">			
							<input type="checkbox" name="saveId" aria-describedby="saveIdHelp">
						</c:if>	
						<c:if test="${not empty value}">
							<input type="checkbox" name="saveId" checked aria-describedby="saveIdHelp">
						</c:if>
						<div id="saveIdHelp" class="form-text">아이디기억하기</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<a href="#FindPassModal" data-toggle="modal" data-dismiss="modal" aria-hidden="true">비밀번호를 잊으셨나요?</a>
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
				<form name="form" action="/signUp" method="post" onsubmit="return checkAll()">
					<input type="hidden" name="preURI" value="${currentURI}">
					<div class="form-group mb-3 col-sm-lg">
						    <label for="InputId" class="form-label">ID</label>
						    <input type="text" name="id" class="form-control" id="userId" aria-describedby="IdHelp">
						    <div id="IdHelp" class="form-text">아이디는 영문 대소문자와 숫자 4~20자리로 입력해야합니다</div>
					</div>
					<div class="form-group mb-3 col-sm-lg">
						    <label for="InputPass" class="form-label">비밀번호</label>
						    <input type="password" name="passwd" class="form-control" id="password1" aria-describedby="PassHelp">
						    <div id="PassHelp" class="form-text">비밀번호는 영문 대소문자와 숫자 4~20자리로 입력해야합니다</div>
					</div>
					<div class="form-group mb-3 col-sm-lg">
						    <label for="InputPass" class="form-label">비밀번호확인</label>
						    <input type="password" class="form-control" id="password2">
					</div>
					<div class="form-group mb-3 col-sm-lg">
						    <label for="InputName" class="form-label">이름</label>
						    <input type="text" name="name" class="form-control" id="name">
					</div>
					<div class="form-group mb-3 col-sm-lg">
						    <label for="InputEmail" class="form-label">이메일</label>
						    <input type="text" name="email" class="form-control" id="email" aria-describedby="EmailHelp">
						    <div id="EmailHelp" class="form-text">이메일 형식을 맞춰주세요</div>
					</div>
					<div class="form-group mb-3 col-lg">
						   <label for="InputBirth" class="form-label">생년월일</label>
						   <input type="text" name="birth" class="form-control" id="birth" aria-describedby="birthHelp" >
						   <div id="birthHelp" class="form-text">2000/00/00</div>
					</div>
				  	<div class="form-group mb-3 col-lg">
						    <label for="InputTel" class="form-label">핸드폰번호</label>
						    <input type="text" name="tel" class="form-control" id="tel" aria-describedby="TelHelp">
						    <div id="TelHelp" class="form-text">010-xxxx-xxxx</div>
				  	</div>
				  	<div class="form-group mb-3 col-lg">
						<label for="inputState" class="form-label">성별</label>
						    <select id="inputState" class="form-select form-select-lg" name="gender">
						       	<option selected value="1">남성</option>
						      	<option value="2">여성</option>
						    </select>
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-primary btn-lg btn-block login-btn" style="font-size: 15px">동의 및 가입하기</button>
					</div>
				</form>
			</div>
			<div class="modal-footer">
						<p>위의 동의 및 계속하기 버튼을 선택하면, 에어티앤티의 서비스 약관, 결제 서비스 약관, 개인정보 처리방침, 차별 금지 정책에 동의하는 것입니다.</p>
			</div>
		</div>
	</div>
</div>
<!-- FindPassModal-->
<div id="FindPassModal" class="modal fade">
	<div class="modal-dialog modal-lg modal-login ">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">비밀번호 찾기</h4>	
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form name="findPass" action="/findPass" method="post" onsubmit="return FindPassCheck()">
					<div class="form-group mb-3 col-sm-lg">
						    <label for="InputId" class="form-label">ID</label>
						    <input type="text" name="id" class="form-control" id="Fid">
					</div>
					<div class="form-group mb-3 col-sm-lg">
						    <label for="InputPass" class="form-label">이름</label>
						    <input type="text" name="name" class="form-control" id="Fname">
					</div>
					<div class="form-group mb-3 col-sm-lg">
						    <label for="InputEmail" class="form-label">이메일</label>
						    <input type="text" name="email" class="form-control" id="Femail" aria-describedby="EmailHelp">
						    <div id="EmailHelp" class="form-text">가입 시 입력한 이메일주소</div>
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-primary btn-lg btn-block login-btn" style="font-size: 15px">전송</button>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<a href="#FindIdModal" data-toggle="modal" data-dismiss="modal" aria-hidden="true">설마...아이디도 잊으셨나요?</a>
			</div>
		</div>
	</div>
</div>  
<!-- FindIdModal-->
<div id="FindIdModal" class="modal fade">
	<div class="modal-dialog modal-lg modal-login ">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">아이디 찾기</h4>	
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form name="findId" action="/findId" method="post" onsubmit="return FindPassCheck(id)">
					<div class="form-group mb-3 col-sm-lg">
						    <label for="InputPass" class="form-label">이름</label>
						    <input type="text" name="name" class="form-control" id="FIname">
					</div>
					<div class="form-group mb-3 col-sm-lg">
						    <label for="InputEmail" class="form-label">이메일</label>
						    <input type="text" name="email" class="form-control" id="FIemail" aria-describedby="EmailHelp">
						    <div id="EmailHelp" class="form-text">가입 시 입력한 이메일주소</div>
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-primary btn-lg btn-block login-btn" style="font-size: 15px">전송</button>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<a href="#SignUpModal" data-toggle="modal" data-dismiss="modal" aria-hidden="true">그냥 회원가입하기</a>
			</div>
		</div>
	</div>
</div>  
