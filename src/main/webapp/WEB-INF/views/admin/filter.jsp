<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<style>
		.box1{	width: 70%;
				margin: 10px;
			}
		.box2 { overflow: auto; 
				width: 70%;
				height: 35%;
				margin: 10px;
				float: center;
			}
		#propertyList th {
		    position: sticky;
		    top: 0px;
		}	
		table tr {
		    height:5px;
		 }
	</style>
</head>
<body>
	<script>
	var subTableArea = document.getElementById("subPropertyList");
	
    $(document).ready(function(){
    	//ajax 공통 필요 변수
    	var token = $("input[name='_csrf']").val();
		var header = "X-CSRF-TOKEN";
    	
    	//[공통] 행추가 후 저장 전 삭제 
    	function deleteRow(){
    		alert('test');
 //   		var tr = $(obj).parent().parent();
 //   		tr.remove();
    	 } 
    	
    	//[대분류] 저장
    	$("#savePropertyBtn").click(function(){
    		
    		var rowData = new Array();
			var tdArr = new Array();
			var checkbox = $("input[name=chk]:checked");

			var jsonArray 	= new Array();
			
			// 체크된 체크박스 값을 가져온다
			checkbox.each(function(i) {
				// checkbox.parent() : checkbox의 부모는 <td>이다.
				// checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
				var tr = checkbox.parent().parent().eq(i);
				var td = tr.children();
				
				<!--
				// 체크된 row의 모든 값을 배열에 담는다.
				rowData.push(tr.text());
				
				// td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
				var data = td.eq(1).text()+","+td.eq(2).children().val();
				
				// 가져온 값을 배열에 담는다.
				tdArr.push(data);
				-->
				
				var jsonObj		= new Object();
				
				if(td.eq(1).text()==null || td.eq(1).text()==''){	//신규추가건은 new+i로 키값 설정(db에서 seq 딸 예정)
					jsonObj.id = 'new'+i;
				}else{
					jsonObj.id = td.eq(1).text();
				}
				jsonObj.name = td.eq(2).children().val();
					
				jsonObj = JSON.stringify(jsonObj);
				//String 형태로 파싱한 객체를 다시 json으로 변환
				jsonArray.push(JSON.parse(jsonObj));
			});
			
			console.log(jsonArray);
			
			$.ajax({
   		        url: "filter/update_prop",
   		        type: "POST",
   		        beforeSend : function(xhr)
   		        {
   		        	xhr.setRequestHeader(header, token);
   		        },
   		        data: {
   		        	data : JSON.stringify(jsonArray)
   		        },
   		        success: function(){
   		        	document.location.href = document.location.href; //페이지 새로고침
   		        },
   		        error: function(){
   		            alert("err발생");
   		        }
   		  	});
    		
    	});
    	
    	$(".del").click(function(){
    		alert('test');
    	});
    	
    	//[대분류] 테이블 컬럼 클릭 이벤트 --> 중분류 데이터 불러옴
    	 $("#propertyList tr").click(function(){
             var tr = $(this);
             var selectedId = tr.find("td:eq(0)").text(); //첫번째 행 값(id) 가져옴
             getSubProList(selectedId);
         });
    	
    	 
    	//[대분류] 테이블 추가 버튼 실행시
    	 $("#addPropertyList").click(function() {
	   			var row = "<tr>";
	   				row += "<td><input type='checkbox' name='chk' class='form-check-input' checked></td>";
	   				row += "<td></td>";
	   				row += "<td><input type='text' class='form-control' name='idx[]' value='' /></td>";
	   				row += "<td><input type='checkbox' class='form-check-input' checked></td>";
	   				row += "<td><button class='del'>삭제</button></td>";
	   				row += "</tr>";
	   			$("#propertyList").append(row);
	   	 });
    	

    	//선택한 대분류에 대한 중분류 리스트를 가져온다.
    	 function getSubProList(selectedId) {
   		    $.ajax({
   		        url: "filter",
   		        type: "POST",
   		        beforeSend : function(xhr)
   		        {
   		        	xhr.setRequestHeader(header, token);
   		        },
   		        data: {
   		        	propertyTypeId: selectedId
   		        },
   		        success: function(data){
   		        	$('#subPropertyList').empty();	 //불러온 데이터로 SubTable 새로 그릴거라서 기존꺼 지워준다
   		        	$('#subPropertyList').append('<tr><th>대분류코드</th><th>중분류코드</th><th>중분류명</th></tr>'); //sub 테이블 헤더 새로 그려서 붙이기
   		        	
   		        	$(data).each(function(){	//td 부분 for문으로 돌려서 그려준다
   						html = $('<tr>' +
   									 '<td><input type="checkbox" class="form-check-input"></td>' +
   									 '<td>' + this.propertyTypeId + '</td>' +
   									 '<td>' + this.id + '</td>' +
   									 '<td><input type="text" value="' + this.name + '"/></td>' +
   									 '<td><button class="btn btn-secondary btn-sm">삭제</button></td>' +
   								 '</tr>'
   								);
   	   		            $('#subPropertyList').append(html);
   					});
   		        },
   		        error: function(){
   		            alert("err");
   		        }
   		  	});
	   		 
   		}
    })
  </script>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<h2></h2>
	<div class='box1'>
		<button class="btn btn-secondary btn-sm" id="savePropertyBtn" style="float: right; margin: 5px">저장</button>
		<button class="btn btn-primary btn-sm" id="addPropertyList" style="float: right; margin: 5px" >추가</button>
	</div>
	<div class='box2'>
		<table class="table table-bordered" id="propertyList" border="1" width="500" style="text-align:center;">
			<tr class="table-dark">
				<th>checked</th>
				<th>대분류코드</th>
				<th>대분류명</th>
				<th>사용여부</th>
			</tr>
			<c:if test="${empty propertyList}">
				<tr>
					<td colspan='4'>등록된 필터 대분류가 없습니다.</td>
				</tr>		 
			</c:if>
			<c:forEach var="dto" items="${propertyList}">
				<tr>
					<td><input type="checkbox" class="form-check-input" name="chk"></td>
					<td>${dto.id}</td>
					<td><input type="text" class="form-control" onclick="event.cancelBubble=true" value="${dto.name}"></td> <!-- 해당 td 이벤트 제외 -->
					<td><input type="checkbox" class="form-check-input"></td>
				</tr>			
			</c:forEach>
		</table>
		<br>
	</div>
	<div class='box2'>
		<table class="table table-bordered" id="subPropertyList" border="1" style="text-align:center;">
			<tr>
				<th>checked</th>
				<th>대분류코드</th>
				<th>중분류코드</th>
				<th>중분류명</th>
				<th>사용여부</th>
			</tr>
			<c:if test="${empty subPropertyList}">
				<tr>
					<td colspan='4'>등록된 필터 중분류가 없습니다.</td>
				</tr>		 
			</c:if>
			<c:forEach var="dto" items="${subPropertyList}">
				<tr>
					<td><input type="checkbox" class="form-check-input" ></td>
					<td>${dto.propertyTypeId}</td>
					<td>${dto.id}</td>
					<td><input type="text" class="form-control" value="${dto.name}"/></td>
					<td><input type="checkbox" class="form-check-input"></td>
				</tr>			
			</c:forEach>
		</table>
	</div>
</body>