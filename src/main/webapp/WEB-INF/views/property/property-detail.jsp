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
<script type="text/javascript" src="/resources/script/json2.js"></script>
<script type="text/javascript">
const MILLISECONDS_PER_DAY = 24*60*60*1000;
const invalidDateStrArray = ${invalidDates};	console.log(invalidDateStrArray);
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
		dateRangeInput.placeholder = "";
		
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
		
		$(this).val(checkInDateStr + " ~ " + checkOutDateStr);
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
  <div class="container position-relative">
    <div class="position-absolute end-0 top-0" >
      <!-- Button trigger modal -->
      <a href="" class="trigger-btn wish-button" id="wishProperty-${property.id}"
      data-toggle="modal" style="font-size: 20px">
        <span class="wish-text"></span>
        <!-- 빈 하트 -->
        <img class="heart" src="" style="width: 3rem; height: 3rem">
      </a>
      <script type="text/javascript">
      	// 화면 로드 시 초기화하는 과정
      	initWish("${property.id}", "${property.wishListId}", "${property.wished}");
      </script>
    </div>
      
    <h1 style="font-size: 6rem">${property.name}</h1>
    
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
  <div class="container" style="padding-top: 0">
      <!-- 숙소 상세정보 나열 구역 -->
	  <div class="two_third first">
	        <div class="position-relative">
	          <h2>숙소 유형</h2>
	          <p style="font-size: 20px">
	            ${property.propertyType.name}/${property.subPropertyType.name}<br>
	            ${property.roomType.name}
	          </p>
	          <div class="position-absolute top-0 end-0">
	            <p style="font-size: 30px">
	              가격<br>
	              <fmt:formatNumber type="currency" value="${property.price}"/>
	            </p>
	          </div>
	        </div>
	        
	        <hr>
	        
	        <div>
	          <h2>상세 설명</h2>
	          <p style="font-size: 20px">
	            ${property.propertyDesc}
	          </p>
	        </div>
	        
	        <hr>
	        
	        <div>
	          <h2>편의 시설</h2><br>
	            <div class="one_half first">
	              <ul style="font-size: 20px">
	                <c:forEach var="amenityType" items="${property.amenityTypes}" begin="0" step="2">
	                <li>
	                  ${amenityType.name}
	                </li>
	                </c:forEach>
	              </ul>
	            </div>
	            <div class="one_half">
	              <ul style="font-size: 20px">
	                <c:forEach var="amenityType" items="${property.amenityTypes}" begin="1" step="2">
	                <li>
	                  ${amenityType.name}
	                </li>
	                </c:forEach>
	              </ul>
	            </div>
	            
	        </div>
	        
	        <hr>
	        
	       <div>
	        <h2>대앳그을</h2>
	        <ul>
	          <li>
	            <article>
	              <header>
	                <figure class="avatar"><img src="/resources/images/demo/avatar.png" alt=""></figure>
	                <address>
	                By <a href="#">A Name</a>
	                </address>
	                <time datetime="2045-04-06T08:15+00:00">Friday, 6<sup>th</sup> April 2045 @08:15:00</time>
	              </header>
	              <div class="comcont">
	                <p>This is an example of a comment made on a post. You can either edit the comment, delete the comment or reply to the comment. Use this as a place to respond to the post or to share what you are thinking.</p>
	              </div>
	            </article>
	          </li>
	          <li>
	            <article>
	              <header>
	                <figure class="avatar"><img src="/resources/images/demo/avatar.png" alt=""></figure>
	                <address>
	                By <a href="#">A Name</a>
	                </address>
	                <time datetime="2045-04-06T08:15+00:00">Friday, 6<sup>th</sup> April 2045 @08:15:00</time>
	              </header>
	              <div class="comcont">
	                <p>This is an example of a comment made on a post. You can either edit the comment, delete the comment or reply to the comment. Use this as a place to respond to the post or to share what you are thinking.</p>
	              </div>
	            </article>
	          </li>
	          <li>
	            <article>
	              <header>
	                <figure class="avatar"><img src="/resources/images/demo/avatar.png" alt=""></figure>
	                <address>
	                By <a href="#">A Name</a>
	                </address>
	                <time datetime="2045-04-06T08:15+00:00">Friday, 6<sup>th</sup> April 2045 @08:15:00</time>
	              </header>
	              <div class="comcont">
	                <p>This is an example of a comment made on a post. You can either edit the comment, delete the comment or reply to the comment. Use this as a place to respond to the post or to share what you are thinking.</p>
	              </div>
	            </article>
	          </li>
	        </ul>
	        
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
	       <input type="hidden" name="hostId" value="${property.hostId}">
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
	             인원수<br>
	             (최대 ${property.maxGuest}명)
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
<<<<<<< HEAD

<c:import url="/WEB-INF/views/bottom.jsp"/>

=======
<<<<<<< HEAD

<c:import url="/WEB-INF/views/bottom.jsp"/>

=======
>>>>>>> branch 'master' of https://github.com/ccd485/airtnt.git
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- <div class="wrapper row4">
  <footer id="footer" class="hoc clear"> 
    ################################################################################################
    <div class="one_quarter first">
      <h6 class="heading">Praesent id aliquam</h6>
      <p>Non tellus nec sapien lobortis lobortis mauris egestas massa ac cursus pellentesque leo risus convallis nulla et fringilla sapien magna sit amet magna aliquam tempus praesent sit amet neque sed lobortis nulla facilisi [<a href="#">&hellip;</a>]</p>
      <ul class="faico clear">
        <li><a class="faicon-facebook" href="#"><i class="fab fa-facebook"></i></a></li>
        <li><a class="faicon-google-plus" href="#"><i class="fab fa-google-plus-g"></i></a></li>
        <li><a class="faicon-linkedin" href="#"><i class="fab fa-linkedin"></i></a></li>
        <li><a class="faicon-twitter" href="#"><i class="fab fa-twitter"></i></a></li>
        <li><a class="faicon-vk" href="#"><i class="fab fa-vk"></i></a></li>
      </ul>
    </div>
    <div class="one_quarter">
      <h6 class="heading">Rutrum amet sodales</h6>
      <ul class="nospace linklist">
        <li><a href="#">Nulla tincidunt magna</a></li>
        <li><a href="#">Vel iaculis mollis mi</a></li>
        <li><a href="#">Lacus tincidunt diam ac</a></li>
        <li><a href="#">Varius purus justo pretium</a></li>
        <li><a href="#">Nunc proin tortor elit</a></li>
      </ul>
    </div>
    <div class="one_quarter">
      <h6 class="heading">At feugiat in diam</h6>
      <p class="nospace btmspace-15">In vestibulum dolor et augue fusce neque enim scelerisque at fermentum.</p>
      <form action="#" method="post">
        <fieldset>
          <legend>Newsletter:</legend>
          <input class="btmspace-15" type="text" value="" placeholder="Name">
          <input class="btmspace-15" type="text" value="" placeholder="Email">
          <button class="btn" type="submit" value="submit">Submit</button>
        </fieldset>
      </form>
    </div>
    <div class="one_quarter last">
      <h6 class="heading">Sed imperdiet pharetra</h6>
      <ul class="nospace linklist">
        <li>
          <article>
            <h6 class="nospace font-x1"><a href="#">Massa nam nulla augue</a></h6>
            <time class="font-xs block btmspace-10" datetime="2045-04-06">Friday, 6<sup>th</sup> April 2045</time>
            <p class="nospace">Faucibus nec lacinia quis ornare a eros pellentesque in orci vitae</p>
          </article>
        </li>
        <li>
          <article>
            <h6 class="nospace font-x1"><a href="#">Velit vehicula auctor</a></h6>
            <time class="font-xs block btmspace-10" datetime="2045-04-05">Thursday, 5<sup>th</sup> April 2045</time>
            <p class="nospace">Pellentesque pulvinar vestibulum bibendum blandit lectus pretium</p>
          </article>
        </li>
      </ul>
    </div>
    ################################################################################################
  </footer>
</div> -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- <div class="wrapper row5">
  <div id="copyright" class="hoc clear"> 
    ################################################################################################
    <p class="fl_left">Copyright &copy; 2018 - All Rights Reserved - <a href="#">Domain Name</a></p>
    <p class="fl_right">Template by <a target="_blank" href="https://www.os-templates.com/" title="Free Website Templates">OS Templates</a></p>
    ################################################################################################
  </div>
</div> -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
>>>>>>> branch 'master' of https://github.com/ccd485/AirTnT.git
<a id="backtotop" href="#top"><i class="fas fa-chevron-up"></i></a>
<!-- JAVASCRIPTS -->
<!-- <script src="/resources/layout/scripts/jquery.min.js"></script> -->
<script src="/resources/layout/scripts/jquery.backtotop.js"></script>
<!-- <script src="/resources/layout/scripts/jquery.mobilemenu.js"></script> -->
<!-- wish list modal -->
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
</body>
</html>