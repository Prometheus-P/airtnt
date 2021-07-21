<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- transactoin_list -->
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>대금 수령 내역</title>
<meta charset="UTF-8" />
</head>
<%@ include file="host_mode_top.jsp"%>
<body>
	
	<div class="container theme-showcase" role="main">
	<br> <br> <br>
		<div class="jumbotron" style="font-style: italic; font-weight: bold;">
				<h1 >대금 목록</h1>
				<p>
					수령완료 된 대금과 수령 예정인 대금을 확인해보세요!
				</p>
		</div>
		<div class="col-md-6" style="width: 95%">
			<div class="page-header">
				<h1 style="font-style: italic; font-weight: bold;">대금수령 완료</h1>
			</div>
			<table id="csvtable" class="table table-striped"
				style="font-size: 20px">
				<thead>
					<tr>
						<th>#</th>
						<th>예약번호</th>
						<th>숙소명</th>
						<th>결재금</th>
						<th>차감 수수료</th>
						<th>총 결재대금</th>
						<th rowspan="3">대금수령일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="dto" items="${listTransaction}">
						<c:if test="${dto.payExptDate.before(today) && dto.propertyId !=null}"><!-- 돈 받는날 < 오늘 -->
							<c:set var="count_1" value="${count_1+1}" />
							<tr>
								<td>${count_1}</td>
								<td>${dto.bookingNumber}</td>
								<td>${dto.propertyName}</td>
								<td>₩${dto.totalPrice}</td>
								<td>₩${dto.totalPrice * dto.siteFee}</td>
								<td>₩${dto.totalPrice - dto.totalPrice * dto.siteFee}</td>
								<td>${dto.payExptDate}</td>
								<c:if test="${Character.compare(dto.isRefund, 'Y') == 0}">
									<td>*환불 되었습니다</td>
									<td>환불일: ${dto.modDate}</td>
								</c:if>
							</tr>
							<c:if test="${Character.compare(dto.isRefund, 'N') == 0 && dto.payExptDate.before(today) && dto.propertyId !=null}">
								<c:set var="total"
								value="${total + dto.totalPrice - dto.totalPrice * dto.siteFee}" />
							</c:if>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="col-sm-4">
			<br>
			<br>
			<br>
			<div class="panel panel-info"
				style="font-weight: bold; font-size: 20px">
				<div class="panel-heading">
					<h3 class="panel-title">총 수익 합계</h3>
				</div>
				<div class="panel-body">
					₩${total}<br><br>
					<button type="button" 
					onclick="exportTableToCsv('csvtable', '${sessionScope.member_id}님의 대금 목록')" 
					class="btn btn-lg btn-link">
					<i class="bi bi-file-spreadsheet"></i>다운로드 하기
					</button>
				</div>
			</div>
		</div>

		<div class="col-md-6" style="width: 95%">
			<div class="page-header">
				<br> <br> <br>
				<h1 style="font-style: italic; font-weight: bold;">대금 수령 예정 내역</h1>
			</div>
			<div class="list-group">
				<table class="table table-striped" style="font-size: 20px">
					<thead>
						<tr>
							<th>#</th>
							<th>예약번호</th>
							<th>예정 결재대금</th>
							<th>숙소 ID</th>
							<th>예약확정일</th>
							<th>대금수령 예정일</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${isReserv == null}">
							<td rowspan="5">예정 내역이 없습니다.</td>
						</c:if>

						<c:forEach var="dto" items="${listTransaction }">
							<!--  confirmDate<  today <checkOutDate -->
							<c:if test="${dto.confirmDate!=null && dto.payExptDate != null && dto.propertyId !=null}">
								<c:if
									test="${dto.confirmDate.before(today) && today.before(dto.payExptDate)}">
									<c:set var="count_2" value="${count_2+1}" />
									<tr>
										<td>${count_2}</td>
										<td>${dto.bookingNumber}</td>
										<td>₩${dto.totalPrice - dto.totalPrice * dto.siteFee}</td>
										<td>${dto.propertyId}</td>
										<td>${dto.confirmDate}</td>
										<td>${dto.payExptDate}</td>
									</tr>
								</c:if>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<%@ include file="../../bottom.jsp"%>

	<script>
		function exportTableToCsv(tableId, filename) {
			if (filename == null || typeof filename == undefined)
				filename = tableId;
			filename += ".csv";

			var BOM = "\uFEFF";

			var table = document.getElementById(tableId);
			var csvString = BOM;
			for (var rowCnt = 0; rowCnt < table.rows.length; rowCnt++) {
				var rowData = table.rows[rowCnt].cells;
				for (var colCnt = 0; colCnt < rowData.length; colCnt++) {
					var columnData = rowData[colCnt].innerHTML;
					if (columnData == null || columnData.length == 0) {
						columnData = "".replace(/"/g, '""');
					} else {
						columnData = columnData.toString().replace(/"/g, '""'); // escape double quotes
					}
					csvString = csvString + '"' + columnData + '",';
				}
				csvString = csvString.substring(0, csvString.length - 1);
				csvString = csvString + "\r\n";
			}
			csvString = csvString.substring(0, csvString.length - 1);

			// Deliberate 'false', see comment below
			if (window.navigator && window.navigator.msSaveOrOpenBlob) {

				var blob = new Blob([ decodeURIComponent(csvString) ], {
					type : 'text/csv;charset=utf8'
				});

				// Crashes in IE 10, IE 11 and Microsoft Edge
				// See MS Edge Issue #10396033: https://goo.gl/AEiSjJ
				// Hence, the deliberate 'false'
				// This is here just for completeness
				// Remove the 'false' at your own risk
				window.navigator.msSaveOrOpenBlob(blob, filename);

			} else if (window.Blob && window.URL) {
				// HTML5 Blob
				var blob = new Blob([ csvString ], {
					type : 'text/csv;charset=utf8'
				});
				var csvUrl = URL.createObjectURL(blob);
				var a = document.createElement('a');
				a.setAttribute('style', 'display:none');
				a.setAttribute('href', csvUrl);
				a.setAttribute('download', filename);
				document.body.appendChild(a);

				a.click()
				a.remove();
			} else {
				// Data URI
				var csvData = 'data:application/csv;charset=utf-8,'
						+ encodeURIComponent(csvString);
				var blob = new Blob([ csvString ], {
					type : 'text/csv;charset=utf8'
				});
				var csvUrl = URL.createObjectURL(blob);
				var a = document.createElement('a');
				a.setAttribute('style', 'display:none');
				a.setAttribute('target', '_blank');
				a.setAttribute('href', csvData);
				a.setAttribute('download', filename);
				document.body.appendChild(a);
				a.click()
				a.remove();
			}
		}
	</script>
</body>
</html>
