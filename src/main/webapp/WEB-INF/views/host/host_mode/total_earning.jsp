<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 총 수입: 수입관련 정보를 목록으로 나열 -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<%@ include file="top.jsp"%>
<meta charset="UTF-8">
<title>총 수입</title>
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
</head>
<body>
	<div class="container theme-showcase" role="main">
		<br><br><br><br>
		<!-- Main jumbotron for a primary marketing message or call to action -->
		<div class="jumbotron">
			<h1>총 수입!</h1>
			<p>
				수입을 알아봅시다!
			</p>
		</div>
	<div class="col-md-6" style="width: 80%">
			<div class="page-header">
				<br> <br> <br>
				<h1>총 수입(₩)</h1>
			</div>
			<!-- 차트 -->
			<div class="container"> <canvas id="myChart"> </canvas> </div> 
			<script>
				var ctx = document.getElementById('myChart').getContext('2d');
				var today = new Date();
				var day = today.getDate();
				var month = today.getMonth() + 1;
				var year = today.getYear()-100;
				var label = [];
				for (var i = 0; i <= 12; ++i) {
					label[12-i] = month - i;
					if (label[12-i] <= 0) {
						label[12-i] += 12
						label[12-i] = year-1 + '년' + label[12-i] + '월' + day +'일';
					}else{
						label[12-i] = year+ '년' + label[12-i] + '월' + day +'일';
					}
				}
				var check = [];
				for(var i=0; i<12 ; ++i){
					check[i] = label[i] + ' ~ ' + label[i+1];
				}
				var list1 = "<c:out value='${listTotal.get(0)}'/>";
				var list2 = "<c:out value='${listTotal.get(1)}'/>";
				var list3 = "<c:out value='${listTotal.get(2)}'/>";
				var list4 = "<c:out value='${listTotal.get(3)}'/>";
				var list5 = "<c:out value='${listTotal.get(4)}'/>";
				var list6 = "<c:out value='${listTotal.get(5)}'/>";
				var list7 = "<c:out value='${listTotal.get(6)}'/>";
				var list8 = "<c:out value='${listTotal.get(7)}'/>";
				var list9 = "<c:out value='${listTotal.get(8)}'/>";
				var list10 = "<c:out value='${listTotal.get(9)}'/>";
				var list11 = "<c:out value='${listTotal.get(10)}'/>";
				var list12 = "<c:out value='${listTotal.get(11)}'/>";
				//for(var i=0; )
				 /* for(var i in label){
					console.log('label[i]'월)
					if(i < label.size){
						console.log(', ')
					}
				}
				[ total_6, total_5, 
				total_4, total_3, total_2, total_1 ]
				 */ 
				var chart = new Chart(ctx, {
					// 챠트 종류를 선택 
					type : 'line',
					// 챠트를 그릴 데이타 
					data : {
						labels : check,
						datasets : [ {
							label : '숙소에서 얻은 수입',
							backgroundColor : '#00ffff',
							borderColor : '#0000ff',
							data : [list1, list2, list3, list4, list5, list6, list7, list8, 
								list9, list10, list11, list12]
						} ]
					},
					// 옵션
					options : {}
				});
			</script>
		</div>
	</div>
		<%@ include file="../../bottom.jsp" %>
</body>
</html>