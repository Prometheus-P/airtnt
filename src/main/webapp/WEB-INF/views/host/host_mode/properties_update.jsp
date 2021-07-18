<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 등록한 숙소 수정: 등록한 숙소의 정보를 띄우고 수정 후 저장 -->
<html>
<head>
<meta charset="UTF-8">
<title>숙소 수정</title>
</head>

<%@ include file="top.jsp"%>
<body>
<form name="f" action="/host/host_properties_list_update" onsubmit="return check()">
	<div class="container theme-showcase" role="main">
		<div class="page-header">
		<br> <br> <br>
			<h1>숙소 수정</h1>
			<button type="button" class="btn btn-primary" onclick="location.href='/host/update_photos?propertyId='=${productDTO.id}">사진 수정하기</button>
		</div>
		<div class="page-header" style="font-weight: bold; font-family: fantasy; font-style: italic;">
			<h2>방 유형</h2>
			</div>
			<div style="font-family: fantasy;">
				<c:forEach var="dto" items="${listRoomType}">
					<input class="radio" type="radio" name="roomTypeId" id="${dto.id}" value="${dto.id}" 
						<c:if test="${propertyDTO.roomTypeId == dto.id}">checked</c:if>>
					<font style="font-weight: bold; font-family: fantasy; font-size: large;">
					${dto.name}
					</font><br>
				</c:forEach>
			</div>
			<div class="page-header"  style="font-weight: bold; font-family: fantasy; font-style: italic;">
			<h2>편의 시설</h2>
			</div>
			<div style="font-family: fantasy;">
				
				<c:forEach var="dto" items="${listAmenityType}">
					<input class="checkbox" type="checkbox" name="listAmenity" id="${dto.id}" value="${dto.id}" 
					<c:forEach var="amenityId" items="${listAmenityId}">
						<c:if test="${amenityId == dto.id}">checked</c:if>
					</c:forEach> >
					<font style="font-weight: bold; font-family: fantasy; font-size: large;">
					${dto.name}
					</font><br>
				</c:forEach>
			</div>
			<div class="page-header"  style="font-weight: bold; font-family: fantasy; font-style: italic;">
			<h2>숙소 인원 설정</h2>
			</div>
			<div style="font-family: fantasy;">
			<br>설정 하신 값은 최대인원: ${propertyDTO.maxGuest}명, 침대 갯수: ${propertyDTO.bedCount}개
			<div class="btn-group list-group-item"
				style="padding-bottom: 70px; padding-left: 20px; font-family: fantasy;">
				<h3>최대 수용 인원</h3>
				<input id="decrease-guest" type="button" class="btn" value="-"
					onclick="changeCount(this)" style="font-size: 40px;"> 
					
					<input id="guest-count" class="form-control btn" type="number"
					name="maxGuest" required
					value="${param.maxGuest}" 
					min="1" readonly
					style="width: 80px; height: 70px; font-size: 50px;">
					
					<input id="increase-guest" type="button" class="btn" value="+"
					onclick="changeCount(this)" style="font-size: 40px;">
			</div>
			<div class="btn-group list-group-item"
				style="padding-bottom: 70px; padding-left: 20px; font-family: fantasy;">
				<h3>침대 수</h3>
				<input id="decrease-bed" type="button" class="btn" value="-" 
					onclick="changeCount(this)" style="font-size: 40px;">
					
					<input id="bed-count" class="form-control btn" type="number"
					name="bedCount" value="${param.bedCount}" min="1" readonly required
					style="width: 80px; height: 70px; font-size: 50px;">
					
					<input id="increase-bed" type="button" class="btn" value="+"
					onclick="changeCount(this)" style="font-size: 40px;">
			</div>
			</div>
			<div class="page-header"  style="font-weight: bold; font-family: fantasy; font-style: italic;">
			<h3>숙소 설명</h3>
			</div>
			<div style="font-family: fantasy;">
				
				<div class="container">
					<h3>숙소에 대한 상세 설명을 적어주세요</h3>
					<textarea id="description" name="description" class="form-control col-sm-5" rows="7"
					 placeholder="ex. 활기 넘치는 이곳에서의 시간이 마음에 드실 거에요." value="${propertyDTO.propertyDesc}"></textarea>
				</div>
			</div>
			<div class="page-header"  style="font-weight: bold; font-family: fantasy; font-style: italic;">
			<h3>가격 설정</h3>
			</div>
			<div style="font-family: fantasy;">
			<br>기존 설정 가격: ₩${productDTO.price}
			<div style="padding-bottom: 50px; padding-left: 20px; font-weight: bold; sfont-family: fantasy;">
				<input id="decrease-price" type="button" class="btn" value="-"
					onclick="changePrice(this)" style="font-size: 50px;">
					
				₩<input id="price" class="form-control btn" type="number" 
					name="price" value="${param.price}" min="10000"
					style="width: 600px; height: 100px; font-size: 60px;border: thin; border-color: aqua;" required>
					
				<input id="increase-price" type="button" class="btn" value="+"
					onclick="changePrice(this)" style="font-size: 50px;">
			</div>
			</div>
			<!-- 사진등록으로 이동할 버튼 -->
		</div>
	
	</form>
	
	<%@ include file="../../bottom.jsp"%>
	<script>
	function check(){
		if($("#guest-count").val() == ""){
			window.alert("최대 인원 수를 정해주세요!");
			return false;
		}
		if($("#bed-count").val() == ""){
			window.alert("침대 수를 정해주세요!");
			return false;
		}
		if($("input:checkbox[name=listAmenity]:checked").length < 1){
			alert("한 개 이상의 편의시설이 필요합니다!");
			return false;
		}
		if (f.description.value == "") {
			alert("숙소 설명을 적어 주세요!");
			f.description.focus();
			return false;
		}
		if (parseInt($('#price').val()) < 10000) {
			alert("하루 숙박비의 최소 가격은 10000원 입니다.");
			return false;
		}
		if(parseInt($('#price').val()) % 10 != 0){
			alert("숙박비 최소 단위는 10원 이상입니다!");
			return false;
		}
		return true;
	}
	
	function changeCount(button) {
		var idValueArray = button.id.split('-');
		var operation = idValueArray[0];
		var element = idValueArray[1];

		var countTag = document.querySelector("input#" + element+ "-count");
		switch (operation) {
		case "increase":
			if (countTag.value == "") {
				countTag.value = 1;
			} else {
				countTag.value++;
			}
			break;
		case "decrease":
			if (countTag.value != "") {
				if (countTag.value <= 1) {
					countTag.value = "";
				} else {
					countTag.value--;
				}
			}
			break;
		}
	}
	

	function changePrice(button) {
		var idValueArray = button.id.split('-');
		var operation = idValueArray[0]; // decrease, increase

		var priceTag = document.querySelector("input#price");
		switch (operation) {
		case "increase":
			if (priceTag.value == "") {
				priceTag.value = 10000;
			} else {
				priceTag.value= parseInt(priceTag.value) + 10000;
			}
			break;
		case "decrease":
			if (priceTag.value != "") {
				if (priceTag.value < 10000) {
					priceTag.value = "";
				} else {
					priceTag.value-=10000;
				}
			}
			break;
		}
	} 
	</script>
</body>
</html>