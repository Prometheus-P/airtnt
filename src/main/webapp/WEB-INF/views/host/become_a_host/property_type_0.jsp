<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소등록</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
</head>
<body>
	<%@include file="../../top.jsp"%>
	<form name="f" method="post"
		action="<c:url value='/host/property_detail_1'/>">
		<h2>
			숙소등록하기 0번 페이지<br> propertyType 입력
		</h2>
		<div class="container theme-showcase" role="main">
			<div class="col-sm-4">
				<div class="list-group">
					<c:forEach var="dto" items="${propertyTypeList}">
						<a href="javascript:void(0);" id="${dto.id}"
							class="list-group-item active" onclick="check()">
							<h3 class="list-group-item-heading">${dto.name}</h3>
						</a>
					</c:forEach>
				</div>
				<div class="radio"> 
					<label>
						<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked> 
						Option one is this and that&mdash;be sure to include why it's great
					</label>
					</div>
				<input type="text" class="form-control" placeholder="Text input">	
			</div>
	</form>
	<%@include file='bottom.jsp' %>
	<script>
		function check() {

		}
	</script>
</body>
</html>