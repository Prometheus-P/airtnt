<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- transactoin_list -->
<html>
<head>
<meta charset="UTF-8">
<title>대금 수령 내역</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
</head>
<%@ include file="top.jsp"%>
<body>

	<div class="container theme-showcase" role="main">
		<div class="col-md-6" style="width: 80%">
			<div class="page-header">
				<br> <br> <br>
				<h1>대금수령 완료</h1>
			</div>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>예약번호</th>
							<th>결재금</th>
							<th>차감 수수료</th>
							<th>총 결재대금</th>
							<th>숙소 ID</th>
							<th rowspan="3">대금수령일</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="dto" items="${listTransaction}">
					<c:if test="${dto.checkOutDate.before(today)}">
						<tr>
							<td>${dto.bookingNumber}</td>
							<td>₩${dto.totalPrice}</td>
							<td>₩${dto.totalPrice * dto.siteFee}</td>
							<td>₩${dto.totalPrice - dto.totalPrice * dto.siteFee}</td>
							<td>${dto.propertyId}</td>
							<td>${dto.payExptDate}</td>
							<c:if test="${Character.compare(dto.isRefund, y) == 0}">
								<td>*환불 되었습니다</td>
								<td>환불일: ${dto.modDate}</td>
							</c:if>
						</tr>
					</c:if>
					
					<c:set var="graph1" value="" scope="page"/>
					</c:forEach>
					</tbody>
				</table>
		</div>

		<div class="col-md-6" style="width: 80%">
			<div class="page-header">
				<br> <br> <br>
				<h1>대금 수령 예정 내역</h1>
			</div>
			<div class="list-group">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>예약번호</th>
							<th>예정 결재대금</th>
							<th>숙소 ID</th>
							<th>예약확정일</th>
							<th>대금수령 예정일</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${isTran == true}">
							<h4 class="list-group-item-heading">예정 내역이 없습니다.</h4>
						</c:if>
						
						<c:if test="${isTran == false}">
						<c:forEach var="dto" items="${listTransaction}">
						<!--  confirmDate<  today <checkOutDate -->
						<c:if test="${dto.confirmDate.before(today) && today.before(dto.checkOutDate)}">
							<tr>
								<td>${dto.bookingNumber}</td>
								<td>₩${dto.totalPrice - dto.totalPrice * dto.siteFee}</td>
								<td>${dto.propertyId}</td>
								<td>${dto.confirmDate}</td>
								<td>${dto.payExptDate}</td>
							</tr>
							</c:if>
						</c:forEach>
						</c:if>
				
					</tbody>
				</table>
			</div>
		</div>
		
		
		<div class="col-md-6" style="width: 80%">
			<div class="page-header">
				<br> <br> <br>
				<h1>총 수입</h1>
			</div>
			<!-- 차트 -->
			<div class="container"> <canvas id="myChart"> </canvas> </div> 
			<script>
				var ctx = document.getElementById('myChart').getContext('2d');
				var today = new Date();
				var month = today.getMonth() + 1;
				var label = [];
				for (var i = 0; i < 6; ++i) {
					label[i] = month - 5 + i;
					if (label[i] <= 0) {
						label[i] += 12;
					}
				}
				var chart = new Chart(ctx, {
					// 챠트 종류를 선택 
					type : 'line',
					// 챠트를 그릴 데이타 
					data : {
						labels : [ label[0] + '월', label[1] + '월',
								label[2] + '월', label[3] + '월', label[4] + '월',
								label[5] + '월' ],
						datasets : [ {
							label : '총 수입',
							backgroundColor : 'transparent',
							borderColor : 'red',
							data : [ 700, 70000, 70000, 6000, 50000, 90000, 80000 ]
						} ]
					},
					// 옵션
					options : {}
				});
			</script>
		<br><br><br><br><br><br><br><br><br><br><br><br>
		</div>
	</div>
	<%@ include file="../../bottom.jsp" %>
</body>
</html>
