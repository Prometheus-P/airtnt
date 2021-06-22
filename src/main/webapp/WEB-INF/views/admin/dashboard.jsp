<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<html>
<body>
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
	<div style="width:100%;">
 		<canvas id="canvas"></canvas>
	</div>

<script>
	var label_arr = [];
	var data_arr = [];
	var data_arr2 = [];
	
</script>
	<c:set var="items" value="${keylist}"></c:set>
	<c:forEach items="${items}" var="item">
		<script> label_arr.push(${item}); </script>
	</c:forEach>
	
	<c:set var="datas" value="${this_valuelist}"></c:set>
	<c:forEach items="${datas}" var="item">
		<script> data_arr.push(${item}); </script>
	</c:forEach>
	
	<c:set var="datas2" value="${last_valuelist}"></c:set>
	<c:forEach items="${datas2}" var="item">
		<script> data_arr2.push(${item}); </script>
	</c:forEach>
<script>	

new Chart(document.getElementById("canvas"), {
    type: 'line',
    data: {
        labels: label_arr,
        datasets: [
        	{
	            label: '올해 기준',
	            data: data_arr,
	            borderColor: "rgba(255, 201, 14, 1)",
	            backgroundColor: "rgba(255, 201, 14, 0.5)",
	            fill: false,
	            lineTension: 0
        	},
        	{    
	        	label: '작년 기준',
	            data: data_arr2,
	            borderColor: "#c45850",
	            backgroundColor: "rgba(255, 201, 14, 0.5)",
	            fill: false,
	            lineTension: 0
        	}]
    },
    options: {
        responsive: true,
        title: {
            display: true,
            text: '일별 수수료 SUM'
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