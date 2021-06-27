<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="top.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>The Basic of Hosting</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet"
	href="<c:url value='/resources_host/assets/css/main.css'/>" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/resources_host/modal/css/default.css'/>" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/resources_host/modal/css/component1.css'/>" />
<script src="<c:url value='/resources_host/modal/js/modernizr.custom.js'/>"></script>
</head>
<body>
	<!-- Main -->
	<section id="main">
		<div class="inner">
			<!-- One -->
			<section id="one" class="wrapper style1">
				<div class="image fit flush">
					<img src="images/today.png" alt="" />
				</div>
				<div class="content">
					<div class="table-wrapper">
						<table>
							<thead>
								<tr>
									<th>상태</th>
									<th><font color="blue">게스트</font></th>
									<th>여행 날짜</th>
									<th>예약 접수 날짜</th>
									<th>수입</th>
									<th>세부정보</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${empty listBooking}">
								게스트가 숙소를 예약하면 여기에 표시됩니다.
								</c:if>
								<c:forEach var="dto" items="${listBooking}">
								<tr>
									<td>
									<c:if test="${dto.confirmDate == null}">
										<font color="red">미확정</font>
									</c:if>
									<c:if test="${dto.confirmDate != null}">
										<font color="blue">확정</font>
									</c:if>
									</td>
									<td><font color="black">박하성${dto.name}
									</font><br>1명${dto. }</td>
									<td><font color="black">2021년 07월 01일 ~ 2021년 07월
											10일</font><br>10박</td>
									<td><font color="black">2021년 06월 20일</font></td>
									<td><font color="black">\700,000</font></td>
									<td>
										<button class="md-trigger" data-modal="modal-1">세부정보</button>
									</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div class="md-overlay"></div>
			</section>
		</div>
	</section>
	<div class="md-modal md-effect-1" id="modal-1">
		<div class="md-content">
			<h3>예약상세 정보</h3>
			<div>
				<p>상세 정보</p>
				<ul>
					<li><strong>정보1</strong> 
					내용내용내용
					</li>
					<li><strong>정보2</strong>
					내용내용내용
					</li>
				</ul>
				<ul class="actions small">
					<li><a href="#" class="button special small">예약확인</a></li>
					<li><a href="#" class="button special small">예약취소</a></li>
				</ul>
				
				<button class="md-close">닫기</button>
			</div>
		</div>
	</div>
	<!-- Scripts -->
	<script src="<c:url value='/resources_host/modal/js/classie.js'/>"></script>
	<script src="<c:url value='/resources_host/modal/js/modalEffects.js'/>"></script>
	<script>
		// this is important for IEs
		var polyfilter_scriptpath = '/js/';
	</script>
	<script src="<c:url value='/resources_host/modal/js/cssParser.js'/>"></script>
	<script src="<c:url value='/resources_host/modal/js/css-filters-polyfill.js'/>"></script>
	<script src="<c:url value='/resources_host/assets/js/jquery.min.js'/>"></script>
	<script src="<c:url value='/resources_host/assets/js/jquery.poptrox.min.js'/>"></script>
	<script src="<c:url value='/resources_host/assets/js/skel.min.js'/>"></script>
	<script src="<c:url value='/resources_host/assets/js/util.js'/>"></script>
	<script src="<c:url value='/resources_host/assets/js/main.js'/>"></script>
</body>
</html>









