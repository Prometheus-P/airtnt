<%@ page language="java" contextType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@include file= "admin_nav.jsp"%>    
<html>
<head>
</head>
<body>
	<script>
		contextCnt = 1; //디폴트 콘텐츠 아이디 : 1
		
		$(document).ready(function(){
			
			//콘텐츠 추가 버튼 클릭시 textarea 추가
		    $("#contextAddBtn").click(function(){
		    	
		    	contextCnt ++; //콘텐츠 id 증가
		    	
		        var txt = '<div class="form-group">'
		        		+ 	'<label for="exampleFormControlTextarea">context'+contextCnt+'</label>'
		        	    + 	'<textarea class="form-control" id="context"'+contextCnt+'" rows="3" name="context"'+contextCnt+'"></textarea>'
		        	    + '</div>';
		        $('#contextDiv').append(txt);
		        
		    });
		})
	</script>
	<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
		<h1 class="h2">Guide Board Form</h1>
		<div class="d-flex justify-context-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom"></div>
		<!-- 콘텐츠 추가 버튼 -->
		<button type="button" id="contextAddBtn" style="float:right;" class="btn btn-primary btn-sm" >콘텐츠 추가</button>
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
			 <div id = "contextDiv">
			 	<div class="form-group">
			   		<label for="exampleFormControlTextarea1">context1</label>
			   		<textarea class="form-control" id="context1" rows="3" name="context1"></textarea>
			 	</div>
			 </div>
			 <div align="center">
				<input type="reset" value="초기화">
				<input type="submit" value="입력">
			 </div>
		</form>
		
	</main>
</body>
</html>