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

<title>호스트 메인</title>
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
							<th width="25%">숙박 기간</th>
							<th width="15%">예약 접수 날짜</th>
							<th rowspan="2" width="10%">대금</th>
							<th width="10%"></th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="dto" items="${listBooking}">
						<tr>
							<td>
							<c:if test="${dto.regDate.before(today) && today.before(dto.confirmDate)}">
								<a href="#modal" style="font-color: red"><b>승인대기 중</b></a>
							</c:if>
							<c:if test="${dto.confirmDate.before(today) && today.before(dto.checkInDate)}">
								<font color="blue"><b>확정</b></font>
							</c:if>
							<c:if test="${dto.checkInDate.before(today) && today.before(dto.checkOutDate)}">
								<font color="green"><b>이용중</b></font>
							</c:if>
						
							</td>
							<td><b>${dto.guestName}</b><br>${dto.guestCount}명</td>
							<td><b>${dto.checkInDate} ~ ${dto.checkOutDate}</b><br>${dto.dayCount}박</td>
							<td>${dto.regDate}</td>
							<td>₩${dto.totalPrice}</td>
							<td>
							<button type="button" class="btn btn-sm btn-info"
									data-toggle="modal" data-target="#myModal"
									title="예약 상세" data-placement="right">
									더보기
							</button>
							</td>
						</tr>
						<div id="myModal" class="modal fade" role="dialog">
							<div class="modal-dialog">
								<!-- Modal content-->
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">예약상세 정보</h4>
									</div>
									<div class="modal-body">
										<div class="media">
											<div class="media-left" >
												<!-- <img src="#사진" class="media-object" style="width: 200px"> -->
												<div class="calendar"></div>
											</div>
											<div class="media-body">
												<h3 class="media-heading">${dto.name}</h3>
												<br>
												<p>숙소 유형 : ${dto.roomTypeName}</p>
												<p>대여 유형 : ${dto.roomTypeName}</p>
												<p>최대 수용 인원 : ${dto.maxGuest}</p>
												<p>침대 수 : ${dto.bedCount}</p>
												<p>가격 : ${dto.price}</p>
												<p>주소 : ${dto.address}</p>
												<p>숙소 설명 : ${dto.propertyDesc}</p>
												<p>수정일 : ${dto.modDate}</p>
												<p>
												<button onclick="location.href='<c:url value="/host/properties_update"/>?id=${dto.id}'" 
												type="button" class="btn btn-warning"  formmethod="get">
												수정하기</button>
												</p>
											</div>
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">닫기</button>
									</div>
								</div>
							</div>
						</div>
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




