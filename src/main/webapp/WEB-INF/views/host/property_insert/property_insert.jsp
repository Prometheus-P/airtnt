<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<meta charset="UTF-8">
<title>숙소 등록하기</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body role="document">

	<div class="container theme-showcase" role="main">
		<div class="list-group">
			<c:forEach var="dto" items="${propertyTypeList}">
				<a href="javascript:void(0);" id="${dto.id}" class="list-group-item active">
					<h3 class="list-group-item-heading">${dto.name}</h3>
				</a>
				<script>
					var tagId = "<c:out value='${dto.id}'/>"
					var subList;
					$(tagId).on('click', function() {
						$.ajax({
							url : "host/become_a_host/property_insert",
							type : "POST",
							async: false,
							data : tagId,
							success : function(data) {
								subList = data;
								/* $('#subPropertyType').text(data); */
							}
						});
					});
				</script>
			</c:forEach>
		</div>
		<div id="subPropertyType"></div>
		
		
		<button id="btn" type="button" class="btn btn-lg btn-success">숙소 등록</button>
	</div>	
</body>
</html>