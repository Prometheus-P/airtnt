<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<!--
Template Name: Nekmit
Author: <a href="https://www.os-templates.com/">OS Templates</a>
Author URI: https://www.os-templates.com/
Copyright: OS-Templates.com
Licence: Free to use under our free template licence terms
Licence URI: https://www.os-templates.com/template-terms
-->
<html lang="">
<!-- To declare your language - read more here: https://www.w3.org/International/questions/qa-html-language-declarations -->
<head>
<title>숙소/상세보기(숙소명:${property.name})</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="/resources/layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<script type="text/javascript">
function loginCheck(){
	if("${member_id}" == ""){
		document.querySelector("a#login-button").click();
		return false;
	}
	return true;
}
</script>

<!-- date range picker css -->
<link rel="stylesheet" type="text/css" href="/resources/daterangepicker/daterangepicker.css" />

</head>
<body id="top">

<jsp:include page="/WEB-INF/views/top.jsp"/>

<!-- 위시리스트 모달은 jQuery 라이브러리 적용을 위해서 top.jsp 아래 둬야함 -->
<c:import url="/WEB-INF/views/property/_wish-modal.jsp"/>

<!-- date range picker js -->
<script type="text/javascript" src="/resources/daterangepicker/jquery.min.js"></script>
<script type="text/javascript" src="/resources/daterangepicker/moment.min.js"></script>
<script type="text/javascript" src="/resources/daterangepicker/moment-with-locales.js"></script>
<script type="text/javascript" src="/resources/daterangepicker/daterangepicker.js"></script>
<script type="text/javascript">
const MILLISECONDS_PER_DAY = 24*60*60*1000;
var invalidDateStrArray = ${invalidDates};	console.log(invalidDateStrArray);
var dayCount = 0;

var applyButton;
var cancelButton;

var dateRangeInput;
var checkInDateInput;
var checkOutDateInput;
var dayCountInput;
var guestCountInput;
var totalPriceInput;
var priceDispArea;

$(function(){
	
	$("input#date-range").daterangepicker({
		startDate: moment().startOf("day").add(1, "day"),
		endDate: moment().startOf("day").add(2, "day"),
		locale: {
			format: "YYYY-MM-DD",
			separator: " ~ ",
			applyLabel: "적용",
			cancelLabel: "취소",
			daysOfWeek: ["일","월","화","수","목","금","토"],
			monthNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
			firstDay: 1
		},
		opens: "left",
		drops: "auto",
		autoUpdateInput: false,
		buttonClasses: "btn",
		applyButtonClasses: "btn-primary",
		cancelClass: "btn-default",
		isInvalidDate: function(date) {
			//console.log("입력 millisecond? " + date);
			var dateToTime = new Date(date).getTime();
			var todayToTime = new Date().getTime();
			//console.log("입력 " + dateToDays);
			//console.log("오늘 " + todayToDays);
			// 오늘부터 이전 날짜는 전부 비활성화
			if(dateToTime <= todayToTime){
				return true;
			}
			// 체크인 ~ 체크아웃 -1 인 예약날짜는 전부 비활성화
			for(var invalidDateStr of invalidDateStrArray){
				if (date.format("YYYY-MM-DD") == invalidDateStr) {
					return true;
				}
			}
			return false;
		}
	}, function(startDate, endDate, label) {
		console.log("A new date selection was made: " +
				startDate.format("YYYY-MM-DD") + " to " + endDate.format("YYYY-MM-DD"));
	}).attr("placeholder", "기간을 입력해주세요.");

	$("input#date-range").on("apply.daterangepicker", function(ev, picker) {
		
		var checkInDateStr = picker.startDate.format("YYYY-MM-DD");
		var checkOutDateStr = picker.endDate.format("YYYY-MM-DD");
		
		console.log(checkInDateStr);
		console.log(checkOutDateStr);
		
		var checkInDateToTime = new Date(checkInDateStr).getTime();
		var checkOutDateToTime = new Date(checkOutDateStr).getTime();
		
		if(checkInDateToTime >= checkOutDateToTime){
			this.placeholder = "1박 이상 예약해주세요.";
			initDateRangeInput();
			return;
		}
		
		if(invalidDateStrArray.length > 0){
			var checkInDateToTime = new Date(checkInDateStr).getTime();
			var checkOutDateToTime = new Date(checkOutDateStr).getTime();
			//console.log("체크인 " + checkInDateToTime);
			//console.log("체크아웃 " + checkOutDateToTime);
			for(var invalidDateStr of invalidDateStrArray){
				var invalidDateToTime = new Date(invalidDateStr).getTime();
				//console.log("안되는날 " + invalidDateToTime);
				for(var time = checkInDateToTime;
						time < checkOutDateToTime; time += MILLISECONDS_PER_DAY){
					//console.log("사이 날짜 " + time);
					if(time == invalidDateToTime){
						this.placeholder = "이미 예약되었습니다.";
						initDateRangeInput();
						return;
					}
				}
			}
		}
		
		this.value = checkInDateStr + " ~ " + checkOutDateStr;
		checkInDateInput.value = checkInDateStr;
		checkOutDateInput.value = checkOutDateStr;
		dayCountInput.value = (checkOutDateToTime - checkInDateToTime) / MILLISECONDS_PER_DAY;
		setTotalPrice();
	});
	
	$("input#date-range").on("cancel.daterangepicker", function(ev, picker) {
		this.placeholder = "기간을 입력해주세요.";
		initDateRangeInput();
	});
	
	$("input#date-range").click(function(){
		this.placeholder = "기간을 입력해주세요.";
	})
	
	applyButton = document.querySelector("button.applyBtn");
	cancelButton = document.querySelector("button.cancelBtn");
	
	// 날짜 입력에 따라 바뀌는 태그 ///////////////////////////////////
	dateRangeInput = document.querySelector("input#date-range");
	checkInDateInput = document.querySelector("input#check-in-date");
	checkOutDateInput = document.querySelector("input#check-out-date");
	dayCountInput = document.querySelector("input#day-count");
	///////////////////////////////////////////////////////////////////
	
	guestCountInput = document.querySelector("input#guest-count");
	totalPriceInput = document.querySelector("input#total-price");
	priceDispArea = document.querySelector("span#price-disp");
	
	setTotalPrice();
});

function initDateRangeInput(){
	dateRangeInput.value = "";
	checkInDateInput.value = "";
	checkOutDateInput.value = "";
	dayCountInput.value = 0;
	setTotalPrice();
}

function setTotalPrice(){
	var dayCount = dayCountInput.value;
	var guestCount = guestCountInput.value;
	var totalPrice = guestCount * dayCount * ${property.price};
	var totalPriceStr = new Intl.NumberFormat('ko-KR', {style: 'currency',currency: 'KRW', minimumFractionDigits: 0}).format(totalPrice);
	
	totalPriceInput.value = totalPrice;
	priceDispArea.innerHTML = totalPriceStr;
}

function checkParametersOnSubmit(){
	if(checkInDateInput.value == ""
			|| checkOutDateInput.value == ""
			|| parseInt(dayCountInput.value) < 1){
		alert("예약정보를 모두 입력해주세요.");
		return false;
	}
	return true;
}
</script>
<div class="wrapper row3 hoc clear">
  <div class="container position-relative" >
    <div class="position-absolute end-0 top-0">
      <!-- Button trigger modal -->
      <a href="" class="trigger-btn wish-button" id="wishProperty-${property.id}"
      data-toggle="modal" style="font-size: 15px; color:black; font-weight:bold;">
        <span class="wish-text"></span>
        <!-- 빈 하트 -->
        <img class="heart" src="" style="width: 3rem; height: 3rem">
      </a>
      <script type="text/javascript">
      	// 화면 로드 시 초기화하는 과정
      	initWish("${property.id}", "${property.wishListId}", "${property.wished}");
      </script>
    </div>
    
    <div style="margin-bottom:10px;">
    	<h2 style="font-weight: bold; color:black;">${property.name}</h2>
    	<img src="/resources/property_img/starIcon.PNG" style="width:18px; height:18px; margin-bottom:5px;">
    	<a href="#review-modal" style="font-size:15px; margin-left:10px; color:#544b4b; font-weight: bold;">후기 ${property.reviews.size()}개</a>
    </div>
    
    
    <!-- 숙소 이미지 -->
    <div class="one_half first">
      <img class="imgl borderedbox inspace-5" 
        <c:if test='${not empty property.images}'>
          src="${property.images.get(0).path}"
        </c:if>
       alt="" style="height: 41rem;">
    </div>
    <div class="one_half">
      <c:forEach var="image" items="${property.images}" begin="1" end="4" varStatus="status">
        <div class="one_half <c:if test="${status.count % 2 == 1}">first</c:if>">
          <img class="imgl borderedbox inspace-5 "
          src="${image.path}" alt="" style="height: 20rem;">
        </div>
      </c:forEach>
    </div>
    <c:if test="${not empty property.images}">
    <div class="position-absolute end-0 bottom-0" style="margin-right: 3rem">
      <a href="#image-modal" class="trigger-btn btn btn-default" data-toggle="modal" style="font-size: 15px;">
        <img src="https://img.icons8.com/fluent/50/000000/thumbnails.png" 
        style="height: 20px; width: 20px"/>더보기
      </a>
    </div>
    </c:if>
  </div>
</div>

<div class="wrapper row3 hoc clear">
  <div class="container">
      <!-- 숙소 상세정보 나열 구역 -->
	  <div class="two_third first">
	        <div class="position-relative">
	        
	          <h3 style="font-weight: bold; color:black;">${property.host.name}님이 호스팅하는 숙소</h3>
	          <h4> 최대 인원  ${property.maxGuest}명  · 침실 ${property.bedCount}개</h4>
	          
	       	  <hr>
	        
	          <p style="font-size: 20px; font-weight: bold; color:black;">
	          	<img src="/resources/property_img/homeicon.png" style="width:25px; height:25px; margin-right:10px; margin-bottom:5px;">
	          	숙소 유형
	          </p>
	          <p style="margin-left:40px; font-size: 18px">
	            ${property.propertyType.name}/${property.subPropertyType.name}<br>
	            ${property.roomType.name}
	          </p>
	          <div class="position-absolute top-0 end-0">
	            <p style="font-size: 30px">
	              <fmt:formatNumber type="currency" value="${property.price}"/>/박
	            </p>
	          </div>
	        </div>
	        
	        <hr>
	        
	        <div>
	          <p style="font-size: 20px; font-weight: bold; color:black;">
	          	<img src="/resources/property_img/homeicon.png" style="width:25px; height:25px; margin-right:10px; margin-bottom:5px;">
	          	상세 설명
	          </p>
	          <p style="margin-left:40px; font-size: 18px">
	            ${property.propertyDesc}
	          </p>
	        </div>
	        
	        <hr>
	        
	        <div>
	           <p style="font-size: 20px; font-weight: bold; color:black;">
	           	<img src="/resources/property_img/homeicon.png" style="width:25px; height:25px; margin-right:10px; margin-bottom:5px;">
	          	편의시설
	           </p>
	            <div class="one_half first">
	              <ul style="margin-left:40px; font-size: 18px">
	                <c:forEach var="amenityType" items="${property.amenityTypes}" begin="0" step="2">
	                <li>
	                  ${amenityType.name}
	                </li>
	                </c:forEach>
	              </ul>
	            </div>
	            <div class="one_half">
	              <ul style="margin-left:40px; font-size: 18px">
	                <c:forEach var="amenityType" items="${property.amenityTypes}" begin="1" step="2">
	                <li>
	                  ${amenityType.name}
	                </li>
	                </c:forEach>
	              </ul>
	            </div>
	            
	        </div>
	        
	        <hr>
	        
	        <div class="position-relative">
	        	<h3 style="font-weight: bold; color:black;">
	          		<img src="/resources/property_img/starIcon.PNG" style="width:28px; height:28px;">${property.rating} · 후기 ${property.reviews.size()}개
	          	</h3>
	          
           		<div>
            		<table class="table">
            		<c:forEach var="review" items="${property.reviews}" end="2">
            		<tr>
            			<td rowspan="2" width=10%><img src="/resources/property_img/user.png" style="width:50px; height:50px;"></td>
            			<td style="font-weight: bold; font-size:15px; color:black;">${review.writer.name}</td>
            		</tr>
            		<tr>
            			<td>${review.reg_date}</td>
            		</tr>
            		<tr>
            			<td colspan="2" style="font-size:15px; color:#544b4b;">${review.content}</td>
            		</tr>
            		</c:forEach>
            	</table>
            	<br>
            </div>
            <hr>
	        <div class="position-absolute end-0 top-0">
	          <a href="#review-modal" class="trigger-btn btn" data-toggle="modal" style="font-size: 20px; border:1px solid black;">
	            <img src="https://img.icons8.com/fluent/48/000000/list.png"
	            style="width: 30px; height: 30px;"/> 더보기
	          </a>
	        </div>
	      </div>
	      
          <!-- 최근 목록 -->
          <c:import url="/WEB-INF/views/property/_recent-list.jsp"/>
          
	   </div><!-- end of two_third first -->
	   <div class="one_third">
	     <!-- 
	       상세정보에서 넘어가는 예약정보
	       host id, guest id, day count, guest count, total price,
	       checkin date, checkout date
	      -->
	     <form action="<c:url value='/property/booking'/>" method="post"
	     onsubmit="return loginCheck() && checkParametersOnSubmit()">
	       <input type="hidden" name="propertyId" value="${property.id}">
	       <input type="hidden" name="hostId" value="${property.host.id}">
	       <input type="hidden" name="guestId" value="${sessionScope.member_id}">
	       <input type="hidden" id="check-in-date" name="checkInDate" value=""/>
	       <input type="hidden" id="check-out-date" name="checkOutDate" value=""/>
	       <input type="hidden" id="day-count" name="dayCount" value="0">
	       <input type="hidden" id="total-price" name="totalPrice" value="">
	       <ul class="list-group" style="font-size: 20px">
	         <li class="list-group-item">
	           <div class="one_third first">
	            	기간
	           </div>
	           <div class="two_third">
	             <input type="text" id="date-range" value="" style="font-size: 16px"/>
	           </div>
	         </li>
	         <li class="list-group-item">
	           <div class="one_third first">
	            	 인원수<br>(최대 ${property.maxGuest}명)
	           </div>
	           <div class="two_third">
	             <input id="guest-count" type="number" name="guestCount"
	             min="1" max="${property.maxGuest}" value="1" onchange="setTotalPrice()">
	           </div>
	         </li>
	         <li class="list-group-item" style="font-size: 30px;color: blue">
	          	 총액 <span id="price-disp"></span>
	         </li>
	         <li class="list-group-item">
	           <input class="btn btn-primary" type="submit"
	           style="font-size: 20px; width: 15rem" value="예약하기">
	           <a href="문의url?propertyId=${property.id}" class="btn btn-info"
	           style="font-size: 20px; width: 15rem">1:1 문의하기</a>
	         </li>
	       </ul>
	     </form>
	   </div>

    </div>
</div>

<c:import url="/WEB-INF/views/bottom.jsp"/>

<a id="backtotop" href="#top"><i class="fas fa-chevron-up"></i></a>
<!-- JAVASCRIPTS -->
<!-- <script src="/resources/layout/scripts/jquery.min.js"></script> -->
<script src="/resources/layout/scripts/jquery.backtotop.js"></script>
<!-- <script src="/resources/layout/scripts/jquery.mobilemenu.js"></script> -->

<!-- image modal -->
<c:if test="${not empty property.images}">
<div id="image-modal" class="modal fade">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
    <div class="modal-content">
      <div class="modal-header position-relative">
        <h2 class="modal-title">사진 더보기</h2>
        <div class="position-absolute end-0" style="padding-right: 20px;">
          <button type="button" class="close" id="image-close-button"
          data-dismiss="modal" aria-hidden="true" style="font-size: 30px">×</button>
        </div>
      </div>
      <div class="modal-body content" style="font-size: 20px">
        <c:forEach var="image" items="${property.images}" varStatus="status">
          <div class="one_half <c:if test='${status.count % 2 == 1}'>first</c:if>">
            <img alt="" src="${image.path}" style="object-fit: cover; width:420px;height: 280px">
          </div>
        </c:forEach>
      </div>
      <div class="modal-footer">
        AirTnT CopyRight ⓒ TeamBit corp. All Rights Reserved.
      </div>
    </div>
  </div>
</div>
</c:if>

<!-- review 모달 -->

<div id="review-modal" class="modal fade">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
    <div class="modal-content">
      <div class="modal-header position-relative">
        <h2 class="modal-title" style="font-weight:bold;">
        	<img src="/resources/property_img/starIcon.PNG" style="width:18px; height:18px; margin-bottom:5px;">
			${property.rating} · 후기 ${property.reviews.size()}개
        </h2>
        <div class="position-absolute end-0" style="padding-right: 20px;">
          <button type="button" class="close" id="image-close-button"
          data-dismiss="modal" aria-hidden="true" style="font-size: 30px">×</button>
        </div>
      </div>
      <div class="modal-body content" style="height: 400px">
        <c:forEach var="review" items="${property.reviews}">
          <div class="d-flex flex-column">
            <div class="d-flex flex-row">
              <div class="d-flex p-2 flex-column">
                <img src="/resources/property_img/user.png" style="width:60px; height:60px;">
              </div>
              <div class="d-flex flex-column">
                <div><h4>${review.writer.name}</h4></div>
                <div><h5>${review.reg_date}</h5></div>
              </div>
            </div>
            <div class="d-flex p-2 flex-row">
              <p>${review.content}</p>
            </div>
          </div>
          
          <c:if test="${not empty review.content_host}">
          <div class="d-flex flex-column">
            <div class="d-flex flex-row flex-row-reverse">
              <div class="p-2">
                <img src="/resources/property_img/user.png" style="width:60px; height:60px;">
              </div>
              <div class="d-flex flex-column">
                <div><h4>호스트 답글</h4></div>
                <div><h5>${review.content_host_date}</h5></div>
              </div>
            </div>
            <div class="d-flex p-2 flex-row flex-row-reverse">
              <p>${review.content_host}</p>
            </div>
          </div>
          </c:if>
          
        </c:forEach>
      <%-- <table>
        <c:forEach var="review" items="${property.reviews}">
        	<tr>
        		<td rowspan="2" width=10%><img src="/resources/property_img/user.png" style="width:50px; height:50px;"></td>
        		<td style="font-weight: bold; font-size:15px; color:black;">${review.writer.name}</td>
        	</tr>
        	<tr>
        		<td>${review.reg_date}</td>
        	</tr>
        	<tr>
        		<td colspan="2" style="font-size:15px; color:#544b4b;">${review.content}</td>
        	</tr>
       		<tr>
        		<td style="color:white">${review.reg_date}</td>
        	</tr>
          <c:if test="${not empty review.content_host}">
        	<tr>
        		<td style="font-weight: bold; font-size:15px; color:black;">호스트 답글</td>
        		<td rowspan="2" width=10%><img src="/resources/property_img/user.png" style="width:50px; height:50px;"></td>
        	</tr>
        	<tr>
        		<td>${review.content_host_date}</td>
        	</tr>
        	<tr>
        		<td colspan="2" style="font-size:15px; color:#544b4b;">${review.content_host}</td>
        	</tr>
          </c:if>
          
        </c:forEach>
        </table> --%>
      </div>
      <div class="modal-footer">
        AirTnT CopyRight ⓒ TeamBit corp. All Rights Reserved.
      </div>
    </div>
  </div>
</div>



</body>
</html>