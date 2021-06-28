<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- transactoin_list -->
<html>
<head>
<meta charset="UTF-8">
<title>대금 수령 내역</title>
</head>
<%@ include file="top.jsp"%>
<body>

	<div class="container theme-showcase" role="main">

		<div class="col-md-6" style="width: 80%">
			<div class="page-header">
				<br>
				<br>
				<br>
				<h1>대금수령 완료</h1>
			</div>
			<div class="list-group">\
			<c:forEach var="dto" items="${listTransaction}">
			<c:if test=${dto.payExptDate != null}>
				<a href="#modal" class="list-group-item active">
					<h4 class="list-group-item-heading">${dto.payExptDate}</h4>
					<p class="list-group-item-text">
					₩${dto.totalPrice + dto.totalPrice * dto.siteFee}
					</p>
					<c:if test="${dto.isRefund.equals('Y')}">
					<p class="list-group-item-text">
						*환불 되었습니다.
					</p>
					</c:if>
				</a>
			</c:if>
			</c:forEach>
			</div>
		</div>
		
		<div class="col-md-6" style="width: 80%">
			<div class="page-header">
				<br>
				<br>
				<br>
				<h1>대금 수령 예정 내역</h1>
			</div>
			<div class="list-group">
				<a href="#" class="list-group-item active">
					<h4 class="list-group-item-heading">List group item heading</h4>
					<c:forEach var="dto" items="${listTransaction}">
					
					<p class="list-group-item-text">
					예정 내역이 없습니다.
					</p>
					<p class="list-group-item-text">
					
					</p>
					</c:forEach>
				</a> 
			</div>
		</div>
		
		<div class="col-md-6" style="width: 80%">
			<div class="page-header">
				<br>
				<br>
				<br>
				<h1>총 수입</h1>
			</div>
			<div class="row">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>#</th>
							<th>First Name</th>
							<th>Last Name</th>
							<th>Username</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td rowspan="2">1</td>
							<td>Mark</td>
							<td>Otto</td>
							<td>@mdo</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
<!--< include file="../bottom.jsp" %>-->