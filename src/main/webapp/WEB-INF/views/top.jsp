<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<<<<<<< HEAD
<h2>Top<h2>
<a href="guest/search">검색</a>
=======
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AirTnT</title>
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
	<!-- <script src="layout/scripts/jquery.min.js"></script>
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
      <h1><a href="index">AirTnT</a></h1>
      <!-- ################################################################################################ -->
    </div>
    <nav id="mainav" class="fl_right"> 
      <!-- ################################################################################################ -->
      <ul class="clear">
        <li class="active"><a href="index">호스트 되기</a></li>
        <c:if test="${!isLogin}">
        <li><a class="drop" href="#" >로그인 하기</a>
          <ul>
            <li><a href="#LoginModal" class="trigger-btn" data-toggle="modal">로그인</a></li>
            <li><a href="#SignUpModal" class="trigger-btn" data-toggle="modal">회원가입</a></li>
            <li><a href="help">도움말</a></li>
          </ul>
        </li>
          </c:if>
        <c:if test="${isLogin}">
        <li><a class="drop" href="#">MyPages</a>
          <ul>
            <li><a href="tour">여행</a></li>
            <li><a href="wishList">위시리스트</a></li>
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
>>>>>>> branch 'master' of https://github.com/ccd485/airtnt.git
