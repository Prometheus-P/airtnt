<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@include file= "admin_nav.jsp"%> 
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<style>
	    p { margin:20px 0px; }
	    tr, td{
		font-size:13px;
	 	}
    </style>
</head>
 <body>
 	<script>
	    $(document).ready(function(){
	    	//ajax 공통 필요 변수
	    	var token = $("input[name='_csrf']").val();
			var header = "X-CSRF-TOKEN";
			
			$("#bookingTab").click(function(){
	            alert('test');
		    });
			
			$('#searchBookingBtn').click(function(){
				var startDate = $('#bookingSearchParamTable td').eq(1).children().val();
				var endDate = $('#bookingSearchParamTable td').eq(3).children().val();
	            searchReportData(startDate, endDate, "booking");
	            alert('test');
		    });
	    })
	    
	    function searchReportData(startDate, endDate, mode){
	    	alert('searchReportData');
	    	
	    	$.ajax({
  		        url: "reports",
  		        type: "POST",
  		        beforeSend : function(xhr)
  		        {
  		        	xhr.setRequestHeader(header, token);
  		        },
  		        data: {
  		        	startDate: startDate,
  		        	endDate : endDate,
  		        	mode : mode
  		        },
  		      	success: function(){
		        	alert('성공');
		        },
  		        error: function(){
  		            alert("err");
  		        }
  		  });
	    }
	    
 	</script>
 	<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
		<h1 class="h2">Reports</h1>
		<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom"></div>
		    <div class="container">
		    	<table id ="bookingSearchParamTable">
		    		<tr>
		    			<td>예약일자</td>
		    			<td><input id="startDate" type="date" name="startDate" class="btmspace-15" value="${today}"></td>
		    			<td> ~ </td>
		    			<td><input id="endDate" type="date" name="endDate" class="btmspace-15" value="${today}"></td>
		    			<td><button type="button" id="searchBookingBtn" style="float:right;" class="btn btn-primary btn-sm" >조회</button></td>
		    		</tr>
		    	</table>
		    	
		    	<table id ="transactionSearchParamTable" style="display:none;">
		    		<tr>
		    			<td>결제일자</td>
		    			<td><input id="startDate" type="date" name="startDate" class="btmspace-15" value="${today}"></td>
		    			<td> ~ </td>
		    			<td><input id="endDate" type="date" name="endDate" class="btmspace-15" value="${today}"></td>
		    			<td><button type="button" id="searchTransacionBtn" style="float:right;" class="btn btn-primary btn-sm" >조회</button></td>
		    		</tr>
		    	</table>
	      	</div>
		    <br>
		    <div class="container">
		      <div class="row">
		        <div class="col">
		            <ul class="nav nav-tabs">
		              <li class="nav-item">
		                <a class="nav-link active" data-toggle="tab" href="#bookingTab">예약</a>
		              </li>
		              <li class="nav-item">
		                <a class="nav-link" data-toggle="tab" href="#transactionTab">결제</a>
		              </li>
		              <li class="nav-item">
		                <a class="nav-link" data-toggle="tab" href="#zxc">대금수령</a>
		              </li>
		            </ul>
		            <!-- 탭별 콘텐츠 분리 -->
		            <div class="tab-content">
		              <!-- (1)예약 -->
		              <div class="tab-pane fade show active" id="bookingTab">
		              	<div style="overflow:auto; text-align:center;">
							<div class="table-responsive">
						    	<table class="table table-striped table-sm">
						        	<tr>
							          	<th>예약일자</th>
							          	<th>예약ID</th>
							          	<th>예약번호</th>
							          	<th>숙소ID</th>
							          	<th>GUEST</th>
							          	<th>HOST</th>
							          	<th>체크인일자</th>
							          	<th>체크아웃일자</th>
							          	<th>확정일자</th>
							          	<th>결제금액</th>
									</tr>
									<c:if test="${empty bookingList}">
										<tr>
											<td colspan='10' style="text-align:center">예약건이 존재하지 않습니다</td>
										</tr>		 
									</c:if>
									<c:forEach var="dto" items="${bookingList}">
										<tr>
											<td>${dto.regDate}</td>
											<td>${dto.id}</td>
											<td>${dto.bookingNumber}</td>
											<td>${dto.propertyId}</td>
											<td>${dto.guestId}</td>
											<td>${dto.hostId}</td>
											<td>${dto.checkInDate}</td>
											<td>${dto.checkOutDate}</td>
											<td>${dto.confirmDate}</td>
											<td>${dto.totalPrice}</td>
										</tr>			
									</c:forEach>
						        </table>
						     </div>
						</div>
		              </div>
		               <!-- (2)결제 -->
		              <div class="tab-pane fade" id="transactionTab">
		              	<div style="overflow:auto; text-align:center;">
							<div class="table-responsive">
						    	<table class="table table-striped table-sm">
						        	<tr>
							          	<th>결제일자</th>
							          	<th>결제ID</th>
							          	<th>예약ID</th>
							          	<th>환불여부</th>
							          	<th>결제금액</th>
							          	<th>수수료율</th>
							          	<th>결제예정일</th>
									</tr>
									<c:if test="${empty bookingList}">
										<tr>
											<td colspan='7' style="text-align:center">결제건이 존재하지 않습니다</td>
										</tr>		 
									</c:if>
									<c:forEach var="dto" items="${transactionList}">
										<tr>
											<td>${dto.regDate}</td>
											<td>${dto.id}</td>
											<td>${dto.bookingId}</td>
											<td>${dto.isRefund}</td>
											<td>${dto.totalPrice}</td>
											<td>${dto.siteFee}</td>
											<td>${dto.payExptDate}</td>
										</tr>			
									</c:forEach>
						        </table>
						     </div>
						  </div>
		              </div>
		              <div class="tab-pane fade" id="zxc">
		                <p>Curabitur dignissim quis nunc vitae laoreet. Etiam ut mattis leo, vel fermentum tellus. Sed sagittis rhoncus venenatis. Quisque commodo consectetur faucibus. Aenean eget ultricies justo.</p>
		              </div>
		            </div>
		        </div>
		      </div>
		    </div>
		   </main>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
  </body>