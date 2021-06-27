<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- top.jsp -->
<!DOCTYPE html>
<html lang="en" class="no-js">
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="An open collection of menu styles that use the line as a creative design element" />
		<meta name="keywords" content="web design, styles, inspiration, line, pseudo-element, SVG, animation" />
		<meta name="author" content="Codrops" />
		<link rel="stylesheet" type="text/css" href="/resources_host/host_mode/css/normalize.css" />
		<link rel="stylesheet" type="text/css" href="/resources_host/host_mode/css/demo.css" />
		<link rel="stylesheet" type="text/css" href="/resources_host/host_mode/css/component.css" />
		<!--[if IE]>
			<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
	</head>
	<body>

	<div class="container">
			<section class="section section--menu" id="Prospero">
				<nav class="menu menu--prospero">
					<ul class="menu__list">
						<li class="menu__item menu__item--current"><a href="#" class="menu__link">투데이</a></li>
						<li class="menu__item"><a href="#" class="menu__link">인사이트</a></li>
						<li class="menu__item"><a href="#" class="menu__link">숙소</a></li>
						<li class="menu__item"><a href="#" class="menu__link">대금 수령 내역</a></li>
					</ul>
				</nav>
			</section>
			
		</div>
	<!-- /container -->
		<script src="/resources_host/host_mode/js/classie.js"></script>
		<script src="/resources_host/host_mode/js/clipboard.min.js"></script>
		<script>
		(function() {
			[].slice.call(document.querySelectorAll('.menu')).forEach(function(menu) {
				var menuItems = menu.querySelectorAll('.menu__link'),
					setCurrent = function(ev) {
						ev.preventDefault();

						var item = ev.target.parentNode; // li

						// return if already current
						if (classie.has(item, 'menu__item--current')) {
							return false;
						}
						// remove current
						classie.remove(menu.querySelector('.menu__item--current'), 'menu__item--current');
						// set current
						classie.add(item, 'menu__item--current');
					};

				[].slice.call(menuItems).forEach(function(el) {
					el.addEventListener('click', setCurrent);
				});
			});
		})(window);
		</script>
</body>
</html>