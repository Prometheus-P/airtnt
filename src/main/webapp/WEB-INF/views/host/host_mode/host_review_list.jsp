<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- transactoin_list -->
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>리뷰 목록</title>
</head>
<%@ include file="host_mode_top.jsp"%>
<body>

	<div class="container theme-showcase" role="main">
		<div class="col-md-6" style="font-family: fantasy;">
			<div class="page-header">
				<br> <br> <br>
				<div class="jumbotron" style="font-style: italic; font-weight: bold;">
				<h1 >숙소 별 리뷰 목록</h1>
				<p>
					게스트가 숙소에 후기를 남겼나요??<br>
					감사 인사로 마음을 전달해봐요!<br>
					숙소를 클릭하면 리뷰 목록이 나옵니다.
				</p>
				</div>
			</div>
			<div class="list-group">
				<c:forEach var="dto" items="${listProperty}">
					<button type="button" class="list-group-item"
						id="btn" onclick="list(${dto.id})" >
						<h4 class="list-group-item-heading">${dto.name}</h4>
						<p class="list-group-item-text">유형: ${dto.subPropertyTypeName}
						<br>등록일 : ${dto.regDate}</p>
					</button><br><br>
				</c:forEach>
			</div>
		</div>
		<div class="col-md-6">
		<br><br><br><br><br><br>
			<div id="reviewDiv"></div>
		</div>

	</div>
	<%@ include file="../../bottom.jsp"%>
	<script>
		$('.list-group-item').hover(function(){
			$(this).toggleClass('active');
		});
		
		$('.list-group-item').click(function() {
			$('.list-group-item').not(this).removeClass('active');
			$(this).toggleClass('active');
		});
		function list(id) {
			$.ajax({
				url : "/review_html",
				type : "post",
				data : {propertyId : id},
				cache : false
			}).done(function(result) {
				console.log("결과확인");
				$("#reviewDiv").html(result);
			}).fail(function(jqXHR, textStatus, errorThrown) {
				console.log("에러");
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
			});
		}
		
		function sendAnswer(id){
			var answer = $('#answer').val();
			var reviewId = id;
			$.ajax({
				url : "/reviewAnswer",
				type : "post",
				data : {'reviewId' : reviewId, 'answer' : answer},
				success : function(data) {
							if (JSON.parse(data)['result'] == "OK") {
								alert("답변 전달 성공!");
								location.reload(true);
								return;
							}else{
								alert("답변 전달 실패!");
								return;
							}
						},
				error: function (xhr, status, error) {
					   	   alert("서버오류로 지연되고있습니다. 잠시 후 다시 시도해주시기 바랍니다.");
					   	    }
			});
		}
	</script>
</body>
</html>
