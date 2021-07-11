<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록 가져오기</title>
<c:import url="top.jsp"></c:import>
</head>
<body>
	<c:set var="count" value="${listReview.size()}" />
	<div id="reviewHtmlAjax"
		style="font-family: fantasy; font-weight: lighter;">
		<c:if test="${empty listReview}">
			<div class="well">
				<h2>후기가 아직 없습니다.</h2>
			</div>
		</c:if>
		<%-- <div class="page-header">
			<h2><b>리뷰 작성률<br>${reviewRate}%</b></h2>
		</div>
		<div class="progress">
			<div class="progress-bar progress-bar-striped" role="progressbar"
				aria-valuenow="${reviewRate}" aria-valuemin="0" aria-valuemax="100"
				style="width: ${reviewRate}%">
			</div>
		</div> --%>
		<c:forEach items="${listReview}" var="dto">
			<div class="page-header">
				<h3>
					#${count} <br>
					<font style="font-style: italic;">평점 ${dto.rating}점</font> <br>
					${dto.writer_id}님의 후기
				</h3>
				<button type="button" class="btn btn-sm btn-default"
					data-target="#modal${dto.id}" data-toggle="modal">상세정보보기</button>
			</div>
			<div class="well">
				<div class="col-md-6">
					<p>${dto.content}</p>
					<c:if test="${empty dto.content_host}">
						<p>
							<button type="button" class="btn btn-primary"
							data-target="#${dto.id}modal" data-toggle="modal">답글 작성하기</button>
						</p>
						<div id="${dto.id}modal" class="modal" role="dialog">
							<div class="modal-dialog">
								<!-- Modal content-->
								<div class="modal-content">
									<div class="modal-header">
										<h4 class="modal-title">답글 작성</h4>
									</div>
									<div class="modal-body">
										<div class="media">
											<div class="media-body">
												<h3 class="media-heading" style="font-style: italic;">평점${dto.rating}점</h3>
												<br>
												<p>작성자 : ${dto.writer_id}님</p>
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
					</c:if>
				</div>
				<div class="col-md-6">
					<p style="font-size: 10px; color: gray;">작성일: ${dto.reg_date}</p>
				</div>
			</div>
			<c:if test="${not empty dto.content_host}">
				<div class="well">
					<div class="col-md-6">
						<p>${dto.content_host}</p>
					</div>
					<div class="col-md-6">
						<p style="font-size: 10px; color: gray;">작성일:
							${dto.content_host_date}</p>
					</div>
				</div>
			</c:if>
			<c:set var="count" value="${count - 1}" />
			<div id="modal${dto.id}" class="modal" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">리뷰 상세</h4>
						</div>
						<div class="modal-body">
							<div class="media">
								<div class="media-body">
									<h3 class="media-heading" style="font-style: italic;">평점${dto.rating}점</h3>
									<br>
									<p>작성자 : ${dto.writer_id}님</p>
									<p>예약번호 : ${dto.booking_id}</p>
									<p>숙소 : ${dto.name}</p>
									<p>숙박 기간 : ${dto.check_in_date} ~ ${dto.check_out_date}</p>
									<p>지불 금액 : ₩${dto.price}</p>
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
	</div>
	<script>
		$("#reviewHtmlAjax").load(
				function() {
					$.ajax({
						type : 'GET',
						url : '/review_send',
						data : {
							reviewParam : document
									.getElementById("reviewHtmlAjax").innerHTML
						},
						success : function(result) {
							console.log("로드 후 url 이동");
						}
					});
				});
	</script>
</body>
</html>






