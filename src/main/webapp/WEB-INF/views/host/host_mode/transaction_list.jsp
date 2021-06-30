<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- transactoin_list -->
<html>
<head>
<meta charset="UTF-8">
<title>대금 수령 내역</title>

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
		</div>
	<%@ include file="../../bottom.jsp" %>
</body>
</html>
