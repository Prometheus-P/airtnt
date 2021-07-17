<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<!--
	Caminar by TEMPLATED
	templated.co @templatedco
	Released for free under the Creative Commons Attribution 3.0 license (templated.co/license)
-->
<html>
	<head>
		<title>Guide</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="/resources_host/assets/css/main.css" />
	</head>
	<body>
		<!-- Header -->
			<header id="header">
				<div class="logo">${guideDTO.subject}<span>by AirTnT</span></div>
			</header>

		<!-- Main -->
			<section id="main">
				<div class="inner">

				<!-- One -->
					<section id="one" class="wrapper style1">

						<div class="image fit flush">
							<img src="/resources_host/images/pic02.jpg" alt="" />
						</div>
						<header class="special">
							<h2>${guideDTO.subject}</h2>
							<p>
							${guideDTO.explanation}
							</p>
						</header>
						<div class="content">
						<c:forEach var="list" items="${listGuideContext}">
							<p>
							${list.context}
							</p>
						</c:forEach>
							<ul class="actions">
								<li align="center">
								<a href="<c:url value='/host/property_insert'/>" class="button special big">
								시작하기
								</a>
								</li>
							</ul>
						</div>
					</section>
				<!-- Three -->
					<section id="three" class="wrapper">
					<c:forEach var="dto" items="${guideList}">
						<div class="spotlight">
							<div class="image flush"><img src="/resources_host/images/pic06.jpg" alt="" /></div>
							<div class="inner">
								<h3>${dto.subject}</h3>
								<p>
								${dto.explanation}
								</p>
								<ul class="actions">
									<li><a href="<c:url value='/guide_context'/>?id=${dto.id}" class="button special">더보기</a></li>
								</ul>
							</div>
						</div>
					</c:forEach>
					</section>

				</div>
			</section>
		<!-- Footer -->
			<footer id="footer">
				<div class="copyright">
					&copy; Untitled. All rights reserved. Images <a href="https://unsplash.com">Unsplash</a> Design 
					<a href="https://templated.co">TEMPLATED</a>
				</div>
			</footer>
		<!-- Scripts -->
			<script src="/resources_host/assets/js/jquery.min.js"></script>
			<script src="/resources_host/assets/js/jquery.poptrox.min.js"></script>
			<script src="/resources_host/assets/js/skel.min.js"></script>
			<script src="/resources_host/assets/js/util.js"></script>
			<script src="/resources_host/assets/js/main.js"></script>
	</body>
</html>
