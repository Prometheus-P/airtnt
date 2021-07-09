<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@include file= "admin_nav.jsp"%>    
<html>
<head>
</head>
<body>
	<script>
		const contentCnt = 1;
		$(document).ready(function(){
			//콘텐츠 추가 버튼 클릭시 textarea 추가
		    $("#contentAddBtn").click(function(){
		    	contentCnt += 1;
		        var txt = '<div class="form-group">'
		        		+ '<label for="exampleFormControlTextarea"'+contentCnt+'">Content'+contentCnt+'</label>'
		        	    + '<textarea class="form-control" id="content'+contentCnt+'" rows="3" name="content1"></textarea>'
		        	    + '</div>'
		    });
		})
	</script>
	<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
		<h1 class="h2">Guide Board Form</h1>
		<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom"></div>
		<button type="button" id="contentAddBtn" style="float:right;" class="btn btn-primary btn-sm" >콘텐츠 추가</button>
		<br>
		<form name="f" action="guideWrite" method="post">
			 <div class="form-group">
			   <label for="exampleFormControlInput1">Title</label>
			   <input type="text" class="form-control" id="subject" name="subject">
			 </div>
			  <div class="form-group">
			   <label for="exampleFormControlTextarea1">Explanation</label>
			   <textarea class="form-control" id="explanation" name="explanation" rows="2"></textarea>
			 </div>
			 <div class="form-group">
			   <label for="exampleFormControlTextarea1">Content1</label>
			   <textarea class="form-control" id="content1" rows="3" name="content1"></textarea>
			 </div>
			 <div align="center">
				<input type="reset" value="초기화">
				<input type="submit" value="입력">
			 </div>
		</form>
		
	</main>
</body>
</html>