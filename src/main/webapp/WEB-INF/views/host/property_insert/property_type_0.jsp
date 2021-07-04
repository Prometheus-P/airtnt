<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소등록</title>
</head>
<body>
	<%@include file="top.jsp" %>
	<%@include file="../../top.jsp"%>
	<!-- <form name="f" method="post"
		action="<c:url value='/host/property_detail_1'/>" onsubmit="send()"> -->
		<div class="container theme-showcase" role="main">
			<div class="page-header">
				<h1 style="font-style: italic; font-weight: bold; font-family: fantasy;">
				호스팅 할 숙소 유형을 알려주세요</h1>
			</div>
			<div class="col-sm-4">
				<c:forEach var="dto" items="${propertyTypeList}">
					<div class="list-group" style="font-family: fantasy;">
						<a href="javascript:void(0)" id="${dto.id}"
							class="list-group-item" onclick="send(${dto.id})">
							<h1 class="list-group-item-heading">${dto.name}</h1>
						</a>
					</div>
				</c:forEach>
				<br><br><br><br><br><br><br><br><br><br><br>
			</div>
	<%@include file='bottom.jsp'%>
	<script>
		function send(id){
			location.href="/host/sub_property_type?propertyTypeId="+id;
		}
		/* $('.list-group-item').click(function() {
			$('.list-group-item').not(this).removeClass('active');
			$(this).toggleClass('active');
		}); */

		 /* function send() {
			var propertyId = document
					.getElementsByClassName("list-group-item active")[0].value
			if (propertyId == null) {
				alert("숙소 유형을 선택해 주세요!");
				return;
			}
			var input = $("<input>").attr("type", "hidden").attr("name",
					"propertyTypeId").val(propertyId);
			$("#f").append($(input));
			document.f.method = "post"
			document.f.submit();
		} */ 
	</script>
</body>
</html>