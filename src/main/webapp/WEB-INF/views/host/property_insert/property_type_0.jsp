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
	
		<div id="mainBody" class="container theme-showcase" role="main">
			<div class="page-header">
				<h1 style="font-style: italic; font-weight: bold; font-family: fantasy;">
				호스팅 할 숙소 유형을 알려주세요</h1>
			</div>
			<div class="col-sm-4">
			<form name="f" method="post" action="<c:url value='/host/sub_property_type_1'/>" onsubmit="return check()"> 
				<c:forEach var="dto" items="${listPropertyType}">
					<div class="list-group" style="font-family: fantasy;">
						<button type="button" id="${dto.id}" name="${dto.name}"
							class="list-group-item 
							<c:if test='${sessionScope.propertyTypeId eq dto.id}'>
							 	active
							</c:if>">
							<h1 class="list-group-item-heading">${dto.name}</h1>
						</button>
					</div>

				</c:forEach>
				<div id="set"></div>
				<button type="submit" class="btn btn-lg btn-success">확인</button>
				</form>
			</div>
		</div>
		<div id="remove"></div>
			<br><br><br><br><br><br><br><br><br><br><br>
	<%@include file='bottom.jsp'%>
	<script>
		$("#mainBody").load(
			$("#remove").append(
				"<c:remove var='propertyTypeId' scope='session'/>"+
				"<c:remove var='propertyTypeName' scope='session'/>")
			);
		
		var id = 0;
		var name = null;
		$('.list-group-item').click(function() {
			$('.list-group-item').not(this).removeClass('active');
			$(this).toggleClass('active');
			id = $(this).attr('id');
			name = $(this).attr('name');
		});
		
		function check(){
			var propertyTypeId = "<c:out value='${propertyTypeId}'/>"
			if(propertyTypeId == null){
				alert("숙소 유형을 정해 주세요!")
				return false;
			}
			$('#set').html(
				"<input type='hidden' name='propertyTypeId' value='${"+id+"}'>"+
				"<input type='hidden' name='propertyTypeName' value='${"+name+"}'>"
			)
			return true;
		}
	</script>
</body>
</html>