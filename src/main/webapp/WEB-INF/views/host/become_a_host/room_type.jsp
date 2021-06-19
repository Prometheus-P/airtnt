<!DOCTYPE html>
<html lang="en" class="no-js">
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
		<title>Blueprint: Product Comparison Layout &amp; Effect</title>
		<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="/resources_host/become_a_host/css/demo.css" />
		<link rel="stylesheet" type="text/css" href="/resources_host/become_a_host/css/component.css" />
		<!-- Modernizr is used for flexbox fallback -->
		<script src="js/modernizr.custom.js"></script>
	</head>
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
				data-content="저희 AirTnT의 주 원동력 호스트가 되어 주셔서 감사합니다."></span></span>
				<h1>숙소 유형</h1>
				<nav>
					<a href="#" class="bp-icon bp-icon-prev" data-info="이전 페이지"><span>이전 페이지</span></a>
					<!--a href="" class="bp-icon bp-icon-next" data-info="next Blueprint"><span>Next Blueprint</span></a-->
					<!-- <a href="#" class="bp-icon bp-icon-drop" data-info="back to the Codrops article"><span>back to the Codrops article</span></a> -->
					<!-- <a href="http://tympanus.net/codrops/category/blueprints/" class="bp-icon bp-icon-archive" data-info="Blueprints archive"><span>Go to the archive</span></a> -->
					<a href="" class="bp-icon bp-icon-next" data-info="다음 페이지"><span>다음 페이지</span></a>
				</nav>
			</header>
			<!-- Product grid -->
			<section class="grid">
				<!-- Products -->
				<div class="product">
					<div class="product__info">
						<img class="product__image" src="/resources_host/become_a_host/images/housing_icon.png" alt="" />
						<h3 class="product__title">주택</h3>
						<button class="action action--button action--buy"><span class="action__text">선택</span></button>
					</div>
				</div>
				<div class="product">
					<div class="product__info">
						<img class="product__image" src="/resources_host/become_a_host/images/apartment_icon.png" alt="" />
						<h3 class="product__title">아파트</h3>
						
						<button class="action action--button action--buy"><span class="action__text">선택</span></button>
					</div>
				</div>
				<div class="product">
					<div class="product__info">
						<img class="product__image" src="/resources_host/become_a_host/images/apartment_icon.png" alt="" />
						<h3 class="product__title">호텔</h3>
						<button class="action action--button action--buy" onclick="location.href='room_type.jsp?roomTypeGroup=2'">
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
						<img class="product__image" src="/resources_host/become_a_host/images/apartment_icon.png" alt="" />
						<h3 class="product__title">아파트</h3>
						
						<button class="action action--button action--buy"><span class="action__text">선택</span></button>
					</div>
				</div>

			</section>
		</div><!-- /view -->
		<!-- product compare wrapper -->
		<script src="/resources_host/become_a_host/js/classie.js"></script>
		<script src="/resources_host/become_a_host/js/main.js"></script>
	</body>
</html>
