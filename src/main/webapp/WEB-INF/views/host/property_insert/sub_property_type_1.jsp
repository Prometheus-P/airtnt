<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소등록</title>
<style>
</style>
</head>
<body>
	<%@include file="../../top.jsp"%>
	<c:import url="top.jsp"/>
	<div id="mainBody" class="container theme-showcase" role="main">
		<div class="page-header">
			<h1 style="font-style: italic; font-weight: bold; font-family: fantasy;">
				다음 중 가장 비슷하다고 생각하는 유형을 골라주세요</h1>
		</div>
		<div class="col-sm-4">
			<form name="f" method="post" action="<c:url value='/host/room_type_2'/>" onsubmit="return send()">
				<c:forEach var="dto" items="${listSubPropertyType}">
					<div class="list-group" style="font-family: fantasy;">
						<button type="button" id="${dto.id}" value="${dto.name}"
							class="list-group-item" role="radio">
							<h1 class="list-group-item-heading">${dto.name}</h1>
						</button>
					</div>
				</c:forEach>
				<footer style="font-size: 30px; font-weight: bold;">
					<div style="float: left; padding-left: 250px; padding-top: 20px">
						<button type="button" class="btn btn-lg btn-default"
							onclick="previous()" style="font-size: 30px; font-weight: bold;">
							<i class="bi bi-arrow-left-square-fill"></i> 
							이전 페이지
						</button>
					</div>
					<div id="next" style="float: right; padding-right: 250px; padding-top: 20px; display:none;">
						<button  type="submit" class="btn btn-lg btn-default"
						 style="font-size: 30px; font-weight: bold;">
							다음 페이지 <i class="bi bi-arrow-right-square-fill"></i>
						</button>
					</div>
				</footer>
				<div id="set"></div>
			</form>
		</div>
	</div>
	<br><br><br><br>
	<script>
			var subPropertyTypeId = null;
			var subPropertyTypeName = null;
		$('.list-group-item').click(
			function() {
				$('.list-group-item').not(this).removeClass('active');
				$(this).toggleClass('active');
				subPropertyTypeId =  $(this).attr('id');
				subPropertyTypeName = $(this).val();
				document.getElementById('next').style.display="block"; //$('#')
			}
		);
		$(window).bind("pageshow", function (event){
			if(event.originalEvent.persisted){
				console.log("뒤로가기로 입장"); //뒤로가기로 입장 했을 시
			}
		});
		function send(){
			if($('.list-group-item').hasClass('active')){
				var obj1 = document.createElement('input');
				obj1.setAttribute('type', 'hidden');
				obj1.setAttribute('name', 'subPropertyTypeId');
				obj1.setAttribute('value', subPropertyTypeId);
			
				var obj2 = document.createElement('input');
				obj2.setAttribute('type', 'hidden');
				obj2.setAttribute('name', 'subPropertyTypeName');
				obj2.setAttribute('value', subPropertyTypeName);
			
				$('#set').append(obj1);
				$('#set').append(obj2);
				return true;
			}
			alert("숙소 유형을 선택해주세요!");
			return false;
		}
		function previous(){
			window.history.back();
		}
	</script>
</body>
</html>