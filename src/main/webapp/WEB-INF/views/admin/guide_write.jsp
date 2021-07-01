<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@include file= "admin_nav.jsp"%>    
<html>
<head>
</head>
<body>
	<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
		<h1 class="h2">Guide Board Form</h1>
		<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom"></div>
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
			 <div class="form-group">
			   <label for="exampleFormControlTextarea1">Content2</label>
			   <textarea class="form-control" id="content2" rows="3" name="content2"></textarea>
			 </div>
			 <div class="form-group">
			   <label for="exampleFormControlTextarea1">Content3</label>
			   <textarea class="form-control" id="content3" rows="3" name="content3"></textarea>
			 </div>
			 <div align="center">
				<input type="reset" value="초기화">
				<input type="submit" value="입력">
			 </div>
		</form>
		
	</main>
</body>
</html>