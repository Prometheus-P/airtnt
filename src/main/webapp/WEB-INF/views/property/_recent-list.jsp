<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>최근 본 숙소</h2>
<div id="carouselControls-recent" class="carousel slide" data-bs-interval="false">
  <div class="carousel-inner" style="margin-left: 10%; width: 80%">
    <c:forEach var="recentProperty" items="${recentProperties}" varStatus="status">
      <c:if test="${status.count % 3 == 1}">
      <div class="carousel-item <c:if test='${status.count == 1}'>active</c:if>">
      </c:if>
        <div class="one_third <c:if test='${status.count % 3 == 1}'>first</c:if>">
          <a href="<c:url value='/property/detail?propertyId=${recentProperty.id}'/>">
            <img
              <c:if test='${recentProperty.images != null && recentProperty.images.size() > 0}'>
                src="${recentProperty.images.get(0).path}"
              </c:if>
            class="d-block w-100" alt="" style="object-fit: cover; width:200px; height: 150px">
            <span style="font-size: 25px">${recentProperty.name}</span><br>
            <span style="font-size: 20px">${recentProperty.address}</span>
          </a>
        </div>
      <c:if test="${status.count % 3 == 0 || status.last}">
      </div>
      </c:if>
    </c:forEach>
  </div>
  <c:if test="${not empty recentProperties && recentProperties.size() > 3}">
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselControls-recent"
    data-bs-slide="prev">
      <img src="https://img.icons8.com/fluent/48/000000/back.png"/>
      <!-- <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Previous</span> -->
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselControls-recent"
    data-bs-slide="next">
      <img src="https://img.icons8.com/fluent/48/000000/forward.png"/>
      <!-- <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Next</span> -->
    </button>
  </c:if>
</div>
</body>
</html>