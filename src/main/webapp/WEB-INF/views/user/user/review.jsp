<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/top.jsp"%>
<script>
$(document).on("click", ".open-ReviewModal", function () {
	var property_Id = $(this).data('property_Id'); 
	$(".modal-body #propert_Id").val( property_Id );
	alret("ㅋㅋ");
	// As pointed out in comments, 
	// it is superfluous to have to manually call the modal. 
	// $('#addBookDialog').modal('show');
	});

</script>
<div class="hoc container clear" style="margin-left: 4vh;">
	<div class="row">
		<div>
			<span class="bold fl_left" style="font-size: 2vh;">
			<a href="/myPage" style="color: black">계정 ></a>
			</span> 
			<span	class="bold" style="font-size: 2vh; margin-left: 10px; ">후기</span><br>
			<div class="bold fl_left" style="font-size: 4vh;">후기</div><br><br><br>
			<div class="fl_left " style="font-size: 13px;">최근 1년간 여행한 숙소에 한해 작성 가능</div>
		</div>
	</div>
	<div class="tabs" style="margin-left: 0px; margin-top:10px;">
	    <input id="all" type="radio" name="tab_item" checked>
	    <label class="tab_item" for="all">작성할 리뷰</label>
	    <input id="programming" type="radio" name="tab_item">
	    <label class="tab_item" for="programming">작성한 리뷰</label>
	    <input id="design" type="radio" name="tab_item">
	    <div class="tab_content" id="all_content">
		    <c:if test="${empty toWriteReviews}">
		       <h5>1년간 여행한 숙소가 없습니다. 여행가실 때가 되셨군요.</h5><br>
		        <h1 style="font-size: 300px">AirTnT</h1>
		        <a href="/property/search?addressKey=">
						<button id="test_btn3" style="font-size:40px; padding-left:15px; padding-right:15px;" type="button" class="btn btn-outline-primary">둘러보기</button>
				</a>
		    </c:if>
		    <c:if test="${not empty toWriteReviews}">
		    	<ul class="nospace clear " style="margin-top: 50px;">
			            <c:forEach var="dto" items="${toWriteReviews}">
			            <li>
			              <div class="one_third first text-center" style="width: 20%;">
			                <a href="/property/detail?propertyId=${dto.property_id}">
			                	<img src="${dto.path}" alt="" style="height:150px;"></a>
			              </div>
			              <div class="one_third text-left">
			                <p class="fs-2"><a style="color:black" href="/guest/property-detail?propertyId=${dto.property_id}">${dto.property_name}</a></p>
			                <p>${dto.type_name}/${dto.sub_type_name} ${dto.room_type_name}</p>
			                <p>${dto.property_address}</p>
			                <p>${dto.total_price}원</p>
			                <p>${dto.check_in_date} | ${dto.check_out_date}</p>
			              </div>
			              <div class="one_third text-right">
			              	<button data-target="#ReviewModal" data-property_id="${dto.property_id}" data-toggle="modal" id="test_btn3" style="font-size:20px;" type="button" class="btn btn-outline-primary">리뷰작성하기</button>
			              </div>
			            </li>
			            <hr>
			            </c:forEach>
			          </ul>
		    </c:if>
	    </div>
	    <div class="tab_content" id="programming_content">
		    <c:if test="${empty myReviews}">
		        <h5>작성하신 리뷰가 없습니다.</h5><br>
		        <h1 style="font-size: 400px">AirTnT</h1>
		    </c:if>
		    <c:if test="${not empty myReviews}">
		    	<ul class="nospace clear " style="margin-top: 50px;">
			            <c:forEach var="dto" items="${myReviews}">
			            <li>
			              <div class="one_third first text-center" style="width: 10%;">
			                <a href="/property/detail?propertyId=${dto.property_id}">
			                	<img src="${dto.path}" alt="" style="height:70px;"></a>
			              </div>
			              <div class="one_third text-left">
			                <p class="fs-2"><a style="color:black" href="/guest/property-detail?propertyId=${dto.property_id}">${dto.property_name}</a></p>
			                <p>${dto.type_name}/${dto.sub_type_name} ${dto.room_type_name}</p>
			                <p>${dto.property_address}</p>
			                <p>${dto.total_price}원</p>
			                <p>${dto.check_in_date} | ${dto.check_out_date}</p>
			              </div>
			              <div class="one_third text-right">
			              	<button data-target="#ReviewModal" data-toggle="modal" id="test_btn3" style="font-size:20px;" type="button" class="btn btn-outline-primary">리뷰작성하기</button>
			              </div>
			            </li>
			            <hr>
			            </c:forEach>
			          </ul>
		    </c:if>
		</div>
	</div>
</div>

<!-- ReviewModal-->
<div id="ReviewModal" class="modal fade">
	<div class="modal-dialog modal-login ">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">리뷰 작성</h4>	
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form name="findId" action="/myPage/writeReview" method="post" onsubmit="return FindIdCheck()">
					<input type="hidden" name="property_id" id="property_id" value=""/>
					<div class="form-group mb-3 col-sm-lg">
						    <label for="InputPass" class="form-label">이름</label>
						    <input type="text" name="name" class="form-control" id="FIname">
					</div>
					<div class="form-group mb-3 col-sm-lg">
						    <label for="InputEmail" class="form-label"></label>
						    <textarea rows="10" cols="58"></textarea>
						    <input type="text" name="email" class="form-control" id="FIemail" aria-describedby="EmailHelp">
						    <div id="EmailHelp" class="form-text">가입 시 입력한 이메일주소</div>
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-primary btn-lg btn-block login-btn" style="font-size: 15px">전송</button>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<p></p>
			</div>
		</div>
	</div>
</div>  
<%@ include file="/WEB-INF/views/bottom.jsp"%>