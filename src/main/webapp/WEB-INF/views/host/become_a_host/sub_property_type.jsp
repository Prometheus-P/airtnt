<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en" class="no-js">
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
		<title>room_type_group</title>
		<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="/resources_host/become_a_host/css/demo.css" />
		<link rel="stylesheet" type="text/css" href="/resources_host/become_a_host/css/component.css" />
		<!-- Modernizr is used for flexbox fallback -->
		<script src="/resources_host/become_a_host/js/modernizr.custom.js"></script>
	</head>
	<!-- 1. 호스팅할 숙소 유형을 알려주세요(아파트, 주택 ...)(property-type-group)
2. 다음 중 숙소를 가장 잘 설명 문구는 무엇인가요?(property-type)
3. 게스트가 머무르게 될 숙소의 종류는 무엇인가요?(privacy_type)
>> location으로
1. 숙소에서 맞이 할 최대 인원 수를 알려주세요(floor_plan)
2. 숙소 편의시설 정보를 추가해 주세요(amenities)
3. 이제 숙소 사진을 올릴 차례입니다(photos)
4. 숙소 이름을 만들어 주세요(room_name)
5. 숙소에 대해 설명해 주세요(description)
6. 이제 요금을 설정 하실 차례입니다!(price)
7. 마지막으로 몇 가지 질문에 답해주세요(legal)
 --> 
	<body>
		<!-- Compare basket -->
		<div class="compare-basket">
			<button class="action action--button action--compare"><i class="fa fa-check"></i><span class="action__text">Compare</span></button>
		</div>
		<!-- Main view -->
		<div class="view">
			<!-- Blueprint header -->
			<header class="bp-header cf">
				<span>AirTnT <span class="bp-icon bp-icon-about" 
				data-content="10단계의 분류를 통해 숙소를 등록하실 수 있습니다!"></span></span>
				<h1>숙소 유형</h1>
				<!-- top을 넣어서 홈으로 갈 수 있게 -->
				<nav>
					<a href="" class="bp-icon bp-icon-next"  data-info="다음 페이지"><span>다음 페이지</span></a>
				</nav>
			</header>
			<!-- Product grid -->
			<section class="grid">
				<!-- Products -->
				<div class="product">
					<div class="product__info">
						<img class="product__image" src="/resources_host/become_a_host/images/housing_icon.png" alt="" />
						<h3 class="product__title">주택</h3>
						<button class="action action--button action--buy" onclick="location.href='room_type.jsp?roomTypeGroup=1'">
						<span class="action__text">선택</span></button>
					</div>
				</div>
				<div class="product">
					<div class="product__info">
						<img class="product__image" src="/resources_host/become_a_host/images/apartment_icon.png" alt="" />
						<h3 class="product__title">아파트</h3>
						
						<button class="action action--button action--buy" onclick="location.href='room_type.jsp?roomTypeGroup=2'">
						<span class="action__text">선택</span></button>
					</div>
				</div>
				<div class="product">
					<div class="product__info">
						<img class="product__image" src="/resources_host/become_a_host/images/hotel_icon.png" alt="" />
						<h3 class="product__title">호텔</h3>
						<button class="action action--button action--buy" onclick="location.href='room_type.jsp?roomTypeGroup=3'">
						<span class="action__text">선택</span></button>
					</div>
				</div>
				<div class="product">
					<div class="product__info">
						<img class="product__image" src="/resources_host/become_a_host/images/guest_house_icon.png" alt="" />
						<h3 class="product__title">게스트 하우스</h3>
						<button class="action action--button action--buy" onclick="location.href='room_type.jsp?roomTypeGroup=4'">
						<span class="action__text">선택</span></button>
					</div>
				</div>
				<div class="product">
					<div class="product__info">
						<img class="product__image" src="/resources_host/become_a_host/images/apartment_icon.png" alt="" />
						<h3 class="product__title">아파트</h3>
						<button class="action action--button action--buy"><span class="action__text">선택</span></button>
					</div>
				</div>

			</section>
		</div>
	</body>
</html>
