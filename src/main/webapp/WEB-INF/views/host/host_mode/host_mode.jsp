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
	<%@include file="top.jsp"%>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div class="container theme-showcase" role="main">
		<div class="jumbotron">
			<h1>투데이</h1>
			<p>
				오늘은 어떤 계획이 있으신가요?<br> 우선 예약 목록을 확인해 볼까요?
			</p>
		</div>
	</div>
	<div class="container theme-showcase" role="main">
		<div class="col-md-6" style="width: 80%">
			<table class="table table-striped">
				<thead>
					<tr>
						<th width="12%">상태</th>
						<th width="12%">예약번호</th>
						<th width="12%">숙소명</th>
						<th width="12%">게스트</th>
						<th width="25%">숙박 기간</th>
						<th width="15%">예약 접수 날짜</th>
						<th rowspan="2" width="15%">대금</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="dto" items="${listBooking}">
						<c:if test="${dto.checkOutDate.after(today)}">
							<tr>
								<td><c:if test="${dto.confirmDate == null}">
										<button type="button" class="btn btn-sm btn-link"
											data-toggle="modal" data-target="#modal${dto.id}"
											title="예약을 확인해주세요!" data-placement="right" style="color: orange ">승인대기</button>
										<!-- 예약 승인 시 상세 입력 -->
										<div id="modal${dto.id}" class="modal fade" role="dialog">
											<div class="modal-dialog">
												<!-- Modal content-->
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal">&times;</button>
														<h4 class="modal-title" style="font-weight: bold;">예약 확인</h4>
													</div>
													<div class="modal-body">
														<div class="media">
															<div class="media-left">
																<!-- <img src="#사진" class="media-object" style="width: 200px"> -->
																<div class="calendar"></div>
															</div>
															<div class="media-body">
																<h3 class="media-heading">${dto.guestName}님이 숙박을 원해요!</h3>
																<br>
																<p>숙소명 : ${dto.propertyName}</p>
																<p>숙박인원 : ${dto.guestCount}</p>
																<p>숙박 기간 : ${dto.checkInDate} ~ ${dto.checkOutDate}</p>
																<p>
																	<button type="button" class="btn btn-success"
																		onclick="confirm(${dto.id}, '${dto.checkOutDate}')">
																		승인</button>
																	<button type="button" class="btn btn-warning"
																		data-toggle="modal"
																		data-target="#${dto.id}modal"
																		title="신중히 고려해주세요!" data-placement="right">
																		반려</button>
																</p>
															</div>
														</div>
													</div>
													<div class="modal-footer">
														<button id="close" type="button" class="btn btn-default" data-dismiss="modal">
															닫기
														</button>
													</div>
												</div>
											</div>
										</div>
										<!-- 예약 반려시 다시 뜨는 모달 -->
										<div id="${dto.id}modal" class="modal fade" role="dialog">
											<div class="modal-dialog">
												<!-- Modal content-->
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal">&times;</button>
														<h4 class="modal-title" style="font-weight: bold;">예약 반려</h4>
													</div>
													<div class="modal-body">
														<div class="media">
															<div class="media-body">
																<h3 class="media-heading">
																예약을 반려하시는 이유가 무엇인가요??
																</h3>
																<br>
																<p>
																<textarea class="form-control col-sm-5" rows="3"
													 placeholder="ex. 제가 휴가를 갑니다. 양해 바랍니다."></textarea>
																</p>
																<p>
																	<button type="button" class="btn btn-warning"
																		onclick="reject(${dto.id})">
																		반려 확인</button>
																</p>
															</div>
														</div>
													</div>
													<div class="modal-footer">
														<button id="close_cancel" type="button" class="btn btn-default" data-dismiss="modal">
															취소
														</button>
													</div>
												</div>
											</div>
										</div>
									</c:if> 
									<c:if test="${dto.confirmDate != null && today.before(dto.checkInDate)}">
										<font color="blue"><b>확정</b></font>
									</c:if> 
									<c:if test="${dto.checkInDate.before(today) && today.before(dto.checkOutDate)}">
										<font color="green"><b>이용중</b></font>
									</c:if>
								</td>
								<td><b>${dto.bookingNumber}</b></td>
								<td><b>${dto.propertyName}</b></td>
								<td><b>${dto.guestName}</b><br>${dto.guestCount}명</td>
								<td><b>${dto.checkInDate} ~ ${dto.checkOutDate}</b><br>${dto.dayCount}박</td>
								<td>${dto.regDate}</td>
								<td>₩${dto.totalPrice}</td>
							</tr>

						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<!-- /container -->
	<script>
		function confirm(id, checkOut){
			//var checkOutDate = new Date(checkOut);
			 $.ajax({
	                type : "POST",
	                url : "/host/bookConfirm",
	                data : {'bookingId' : id, 'checkOutDate' : checkOut},
	                success : function(text){
	                    alert(text);
	                    $('#close').click();
	                },
	                error : function(XMLHttpRequest, textStatus, errorThrown){
	                    alert("서버 문제 발생! 다시 시도해 주세요.");
	                    $('#close').click();
	                }
	            });
		}
		function reject(id){
			 $.ajax({
	                type : "POST",
	                url : "/host/bookReject",
	                data : {'bookingId' : id},
	                success : function(text){ 
	                    alert(text);
	                    $('#close_cancel').click();
	                    $('#close').click();
	                },
	                error : function(XMLHttpRequest, textStatus, errorThrown){
	                    alert("서버 문제 발생! 다시 시도해 주세요.");
	                    $('#close_cancel').click();
	                    $('#close').click();
	                }
	            });
		}
	 /* 	window.onpageshow = function(event) {
				if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
				// Back Forward Cache로 브라우저가 로딩될 경우 혹은 브라우저 뒤로가기 했을 경우
				alert("히스토리백!!!!");
					}
			} 
		$(window).bind("pageshow", function (event){
			if(event.originalEvent.persisted){
				alert("히스토리백!!!!");
			}else{
				alert("새로운 페이지!!!!");
			}
		}); */ 
	</script>

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




