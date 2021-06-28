<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">

<title>Navbar Template for Bootstrap</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body role="document">
<%@include file="top.jsp" %>
	<div class="container theme-showcase" role="main">
		<div class="jumbotron">
			<h1>투데이</h1>
			<p>
				오늘은 어떤 계획이 있으신가요?<br>
				우선 예약 목록을 확인해 볼까요?
			</p>
		</div>
	</div>
	<div class="container theme-showcase" role="main">
	<div class="col-md-6" style="width: 80%">
				<table class="table table-striped">
					<thead>
						<tr>
							<th width="15%">상태</th>
							<th width="15%">게스트</th>
							<th width="25%">여행 날짜</th>
							<th width="15%">예약 접수 날짜</th>
							<th rowspan="2" width="10%">수입</th>
							<th width="10%"></th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="dto" items="${listBooking}">
						<tr>
							<td>
							<c:if test="${dto.confirmDate ==null}"><a href="#modal" style="font-color: red"><b>승인대기 중</b></a></c:if>
							<c:if test="${dto.confirmDate != null}"><a href="#modal" style="font-color: blue"><b>확정</b></a></c:if>
							</td>
							<td><b>${dto.guestName}</b><br>${dto.guestCount}명</td>
							<td><b>${dto.checkInDate} ~ ${dto.checkOutDate}</b><br>${dto.dayCount}박</td>
							<td>${dto.regDate}</td>
							<td>₩${dto.totalPrice}</td>
							<td><button type="button" class="btn btn-sm btn-primary">세부정보</button></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
			</div>
	<!-- /container -->


	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

	<svg xmlns="http://www.w3.org/2000/svg" width="1140" height="500"
		viewBox="0 0 1140 500" preserveAspectRatio="none"
		style="visibility: hidden; position: absolute; top: -100%; left: -100%;">
		<defs></defs>
		<text x="0" y="53"
			style="font-weight:bold;font-size:53pt;font-family:Arial, Helvetica, Open Sans, sans-serif;dominant-baseline:middle">Thirdslide</text></svg>
</body>
</html>




