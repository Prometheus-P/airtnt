

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
			<form name="f" method="post" action="<c:url value='/host/sub_property_type_1'/>" onsubmit="return check()"> 
				<c:forEach var="dto" items="${listPropertyType}">
					<div class="list-group" style="font-family: fantasy;">
						<a href="javascript:void(0)" id="${dto.id}"
							class="list-group-item" onclick="<c:set var='property' value='${dto.id}'/>">
							<h1 class="list-group-item-heading">${dto.name}</h1>
						</a>
					</div>
				</c:forEach>
				<input type="hidden" name="propertyTypeId" value="${property}">
				<button type="submit" class="btn btn-lg btn-success">확인</button>
				</form>
			</div>
			<br><br><br><br><br><br><br><br><br><br><br>
	<%@include file='bottom.jsp'%>
	<script>
		$('.list-group-item').click(function() {
			$('.list-group-item').not(this).removeClass('active');
			$(this).toggleClass('active');
		});
		function check(){
			var propertyTypeId = "<c:out value='${property}'/>"
			if(propertyTypeId == null){
				alert("숙소 유형을 정해 주세요!")
				return false;
			}
			document.f.submit();
			return true;
		}
	</script>
</body>
</html>