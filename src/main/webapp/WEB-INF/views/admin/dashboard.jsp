<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@include file= "admin_nav.jsp"%>    
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
</head>
<body>
	<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
		<h1 class="h2">Dashboard</h1>
		<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">
        </div>
		<div style="width:100%;">
	 		<canvas id="canvas"></canvas>
		</div>
		
	</main>
<script>
	var label_arr = [];
	var data_arr = [];
	var data_arr2 = [];
	
</script>
	<c:set var="items" value="${keylist}"></c:set>
	<c:forEach var="item" items="${items}" >
		<script> label_arr.push(${item}); </script>
	</c:forEach>
	
	<c:set var="datas" value="${this_valuelist}"></c:set>
	<c:forEach  var="item" items="${datas}">
		<script> data_arr.push(${item}); </script>
	</c:forEach>
	
	<c:set var="datas2" value="${last_valuelist}"></c:set>
	<c:forEach var="item" items="${datas2}" >
		<script> data_arr2.push(${item}); </script>
	</c:forEach>
<script>	
	new Chart(document.getElementById("canvas"), {
	    type: 'bar',
	    data: {
	        labels: label_arr,
	        datasets: [
	        	{
		            label: '올해 기준',
		            data: data_arr,
		            //borderColor: "rgba(255, 201, 14, 1)",
		            //backgroundColor: "rgba(255, 201, 14, 0.5)",
		            backgroundColor : "#e9c46a",
		            fill: false,
		            lineTension: 0
	        	},
	        	{    
		        	label: '작년 기준',
		            data: data_arr2,
		            //borderColor: "#c45850",
		            //backgroundColor: "rgba(255, 201, 14, 0.5)",
		            backgroundColor : "#2a9d8f",
		            fill: false,
		            lineTension: 0
	        	}]
	    },
	    options: {
	        responsive: true,
	        title: {
	            display: true,
	            text: '월별 체크인 카운트'
	        },
	        tooltips: {
	            mode: 'index',
	            intersect: false,
	        },
	        hover: {
	            mode: 'nearest',
	            intersect: true
	        }
	    }
	});
</script>

	
</body>