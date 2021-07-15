<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소등록</title>
<style>
footer{ 
	position:fixed; 
	left:0px; 
	bottom:0px; 
	height:20%; 
	width:100%; 
	background: #01546b ; 
	color: white; }
</style>
</head>
<body>
	<%@include file="top.jsp"%>
	<%@include file="../../top.jsp"%>
	<!-- <form name="f" method="post"
		action="<c:url value='/host/property_detail_1'/>" onsubmit="send()"> -->
	<div class="container theme-showcase" role="main">
		<div class="page-header">
			<h1 style="font-style: italic; font-weight: bold; font-family: fantasy;">
				이제 요금을 설정 하실 차례입니다!</h1>
		</div>
		<form name="f" method="post" action="<c:url value='/host/preview_9'/>"
			onsubmit="return check()">
			<div style="padding-bottom: 50px; padding-left: 20px; font-weight: bold; sfont-family: fantasy;">
				<input id="decrease-price" type="button" class="btn" value="-"
					onclick="changePrice(this)" style="font-size: 50px;">
					
				₩<input id="price" class="form-control btn" type="number" 
					name="price" value="${param.price}" min="10000"
					style="width: 600px; height: 100px; font-size: 60px;border: thin; border-color: aqua;" required>
					
				<input id="increase-price" type="button" class="btn" value="+"
					onclick="changePrice(this)" style="font-size: 50px;">
			</div>
				<footer style="font-size: 30px; font-weight: bold;">
					<div style="float: left; padding-left: 80px; padding-top: 20px">
						<button type="button" class="btn btn-lg btn-default"
							onclick="previous()" style="font-size: 30px; font-weight: bold;">
							<i class="bi bi-arrow-left-square-fill"></i> 
							이전 페이지
						</button>
					</div>
					<div style="float: right; padding-right: 80px; padding-top: 20px;">
						<button  id="next" type="submit" class="btn btn-lg btn-default"
						 style="font-size: 30px; font-weight: bold;">
							다음 페이지 <i class="bi bi-arrow-right-square-fill"></i>
						</button>
					</div>
				</footer>
		</form>
		<br> <br> <br> <br> <br> <br> <br>
		<script>
		
			function check() {
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
			function previous(){
				windo.history.back();
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
			
			/* function modMinMaxPrice(priceTag){
				var minPriceTag, maxPriceTag;
				switch(priceTag.id){
				case "min-price":
					minPriceTag = priceTag; // event source
					maxPriceTag = document.querySelector("input#max-price");
					var minPrice = parseInt(minPriceTag.value);
					var maxPrice;
					if(maxPriceTag.value != ""){
						maxPrice = parseInt(maxPriceTag.value);
						if(minPrice > maxPrice){
							maxPriceTag.value = minPrice + 10000;
						}
					}
					break;
				case "max-price":
					minPriceTag = document.querySelector("input#min-price");
					maxPriceTag = priceTag; // event source
					var minPrice;
					var maxPrice = parseInt(maxPriceTag.value);
					if(minPriceTag.value != ""){
						minPrice = parseInt(minPriceTag.value);
						if(minPrice > maxPrice){
							minPrice = maxPrice - 10000;
							if(minPrice < 10000){
								minPrice = 10000;
							}
						}
						minPriceTag.value = minPrice;
					}
					break;
				}
			}
 */
			
		</script>
</body>
</html>