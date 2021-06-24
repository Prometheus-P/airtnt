<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/top.jsp"%>

<div class="hoc container clear" style="margin-left: 4vh;">
	<div id="pageintro" style="padding-top: 0px; padding-bottom: 100px">
		<div class="bold fl_left" style="font-size: 4vh;">여행</div>
	</div>
	<div class="tabs" style="margin-left: 0px;">
	    <input id="all" type="radio" name="tab_item" checked>
	    <label class="tab_item" for="all">예정된 여행</label>
	    <input id="programming" type="radio" name="tab_item">
	    <label class="tab_item" for="programming">이전 여행	</label>
	    <input id="design" type="radio" name="tab_item">
	    <div class="tab_content" id="all_content">
		    <c:if test="${empty bookinglist}">
		       <h5>다시 여행을 떠나실 준비가 되면 에어티앤티가 도와드리겠습니다.</h5><br>
		        <h1 style="font-size: 400px">AirTnT</h1>
		    </c:if>
		    <c:if test="${not empty bookinglist}">
		    
		    </c:if>
	    </div>
	    <div class="tab_content" id="programming_content">
		    <c:if test="${empty bookinglist}">
		        <h5>과거 여행이 없습니다. 하지만 여행을 완료하면 여기에서 확인하실 수 있습니다. </h5><br>
		        <h1 style="font-size: 400px">AirTnT</h1>
		    </c:if>
		    <c:if test="${not empty bookinglist}">
		    
		    </c:if>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/views/bottom.jsp"%> 
