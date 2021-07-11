<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/top.jsp"%>

<div class="hoc container clear" style="margin-left: 4vh;">
	<div id="pageintro" style="padding-top: 0px; padding-bottom: 100px">
		<div class="bold fl_left" style="font-size: 4vh;">여행</div>
	</div>
	<div class="tabs" style="height:1200px; margin-left: 0px;">
	    <input id="all" type="radio" name="tab_item" checked>
	    <label class="tab_item" for="all">예정된 여행</label>
	    <input id="programming" type="radio" name="tab_item">
	    <label class="tab_item" for="programming">이전 여행	</label>
	    <input id="design" type="radio" name="tab_item">
	    <div class="tab_content" id="all_content">
		    <c:if test="${empty planedBookinglist}">
		       <h5>다시 여행을 떠나실 준비가 되면 에어티앤티가 도와드리겠습니다.</h5><br>
		        <h1 style="font-size: 300px">AirTnT</h1>
		        <a href="/property/search?addressKey=">
						<button id="test_btn3" style="font-size:20px; padding-left:15px; padding-right:15px;" type="button" class="btn btn-outline-primary">둘러보기</button>
				</a>
		    </c:if>
		    <c:if test="${not empty planedBookinglist}">
		    	<ul class="nospace clear " style="margin-top: 50px;">
			            <c:forEach var="dto" items="${planedBookinglist}">
			            <li style="height: 150px;">
			              <div class="one_third first text-center" style="width: 20%;">
			                <a href="/property/detail?propertyId=${dto.property_id}">
			                	<img src="${dto.path}" alt="" style="height:150px;"></a>
			              </div>
			              <div class="two_third text-left">
			                <p class="fs-2"><a style="color:black" href="/guest/property-detail?propertyId=${dto.property_id}">${dto.property_name}</a></p>
			                <p>${dto.type_name}/${dto.sub_type_name} ${dto.room_type_name}</p>
			                <p>${dto.property_address}</p>
			                <p>${dto.total_price}원</p>
			                <p>${dto.check_in_date} | ${dto.check_out_date}</p>
			              </div>
			            </li>
			            <hr>
			            </c:forEach>
			          </ul>
		    </c:if>
	    </div>
	    <div class="tab_content" id="programming_content">
		    <c:if test="${empty preBookinglist}">
		        <h5>과거 여행이 없습니다. 하지만 여행을 완료하면 여기에서 확인하실 수 있습니다. </h5><br>
		        <h1 style="font-size: 300px">AirTnT</h1>
		    </c:if>
		    <c:if test="${not empty preBookinglist}">
		    	<ul class="nospace clear " style="margin-top: 50px;">
			            <c:forEach var="dto" items="${preBookinglist}">
			            <li style="height: 150px;">
			              <div class="one_third first text-center" style="width: 20%;">
			                <a href="/property/detail?propertyId=${dto.property_id}">
			                	<img src="${dto.path}" alt="" style="height:150px;"></a>
			              </div>
			              <div class="two_third text-left">
			                <p class="fs-2"><a style="color:black" href="/guest/property-detail?propertyId=${dto.property_id}">${dto.property_name}</a></p>
			                <p>${dto.type_name}/${dto.sub_type_name} ${dto.room_type_name}</p>
			                <p>${dto.property_address}</p>
			                <p>${dto.total_price}원</p>
			                <p>${dto.check_in_date} | ${dto.check_out_date}</p>
			              </div>
			            </li>
			            <hr>
			            </c:forEach>
			          </ul>
		    </c:if>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/views/bottom.jsp"%> 
