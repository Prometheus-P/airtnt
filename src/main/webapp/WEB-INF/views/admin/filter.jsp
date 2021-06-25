<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@include file= "admin_nav.jsp"%> 
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<style>
		#propertyList th {
		    position: sticky;
		    top: 0px;
		}	
		tr, td{
			font-size:13px;
		}
	</style>
</head>
<body>
	<script>
    $(document).ready(function(){
    	//ajax 공통 필요 변수
    	var token = $("input[name='_csrf']").val();
		var header = "X-CSRF-TOKEN";
		
		//선택한 대분류 데이터 여기에 담아두고 중분류 추가할때 화면에 보여준다
		var selectedPropCode = null;
		var selectedPropName = null;
    	
    	//[공통] 행추가 후 저장 전 삭제 
    	function deleteRow(){
    	 } 
    	
    	//[대분류][중분류] 저장
    	$("#savePropertyBtn, #saveSubPropertyBtn").click(function(){
    		//대분류 , 중분류에 따라서 변수값 지정
    		var selectedId = $(this).attr("id");
    		var url = null;
    		
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
				
				var jsonObj	= new Object();
			    
				if(selectedId == 'savePropertyBtn'){
					url = "filter/update/prop";
					//(1) 대분류ID
					jsonObj.id = td.eq(1).text();
					//(2) 대분류명
					jsonObj.name = td.eq(2).children().val();
					//(3) 대분류 사용여부  : checkbox 체크 여부 확인
					if(td.eq(3).children().is(":checked") == true) jsonObj.isUse = "Y";
					else jsonObj.isUse = "Y";
				}else{
					// selectedId == 'saveSubPropertyBtn'
					url = "filter/update/subprop";
					
					jsonObj.propertyTypeId = td.eq(1).text();
					jsonObj.id = td.eq(3).text();
					jsonObj.name = td.eq(4).children().val();
					
					if(td.eq(5).children().is(":checked") == true) jsonObj.isUse = "Y";
					else jsonObj.isUse = "Y";
				}
				console.log(jsonObj);	
				jsonObj = JSON.stringify(jsonObj);
				//String 형태로 파싱한 객체를 다시 json으로 변환
				jsonArray.push(JSON.parse(jsonObj));
			});
			
			$.ajax({
   		        url: url,
   		        type: "POST",
   		        beforeSend : function(xhr)
   		        {
   		        	xhr.setRequestHeader(header, token);
   		        },
   		        data: {
   		        	data : JSON.stringify(jsonArray)
   		        },
   		        success: function(res){
   		        	$("#alertArea").addClass("alert alert-success");
   		        	$("#alertArea").text(res);
   	                $("#alertArea").fadeTo(3000, 3000).slideUp(3000, function(){
   	                });
   		        	document.location.href = document.location.href; //페이지 새로고침
   		        },
   		        error: function(){
   		            alert("err발생");
   		        }
   		  	});
    		
    	});
    	
    	//[대분류] 테이블 컬럼 클릭 이벤트 --> 중분류 데이터 불러옴
    	 $("#propertyList tr").click(function(){
             var tr = $(this);
             selectedPropCode = tr.find("td:eq(1)").text(); //선택한 row의 id컬럼 값을 가져온다
             selectedPropName = tr.find("td:eq(2)").children().val();
             
             getSubProList(selectedPropCode);
         });
    	
    	 
    	//[대분류] 테이블 추가 버튼 실행시
    	 $("#addPropertyList").click(function() {
    		 	var row = null;
	   				row = "<tr>";
	   				row += "<td><input type='checkbox' name='chk' checked></td>";
	   				row += "<td><button></button></td>";
	   				row += "<td><input type='text' class='form-control' style='text-align:center; height:23px; font-size:13px' value=''/></td>";
	   				row += "<td><input type='checkbox' checked></td>";
	   				row += "</tr>";
	   			$("#propertyList").append(row);
	   	 });
    	
    	//[대분류] 선택한 대분류 row에 대한 중분류 리스트를 가져온다.
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
   		        	$('#subPropertyList td').remove();	 //불러온 데이터로 SubTable 새로 그릴거라서 기존 td 들은 지워준다
   		        	if(data.length<1){
   		        		html = $('<tr><td colspan="6">데이터가 존재하지 않습니다</td></tr>');
   		        		$('#subPropertyList').append(html);
   		        	}else{
	   		        	$(data).each(function(){	//sub테이블의 td부분을 for문으로 돌려서 그려준다
	   						html = $('<tr>' +
	   									 '<td><input type="checkbox" name="chk"></td>' +
	   									 '<td>' + this.propertyTypeId + '</td>' +
	   									 '<td>' + this.propertyTypeName + '</td>' +
	   									 '<td>' + this.id + '</td>' +
	   									 '<td><input type="text" class="form-control" value="' + this.name + '" style="text-align:center; height:23px; font-size:13px;"/></td>' +
	   									 '<td><input type="checkbox" id="isUseSubProp"></td>' +
	   								 '</tr>'
	   								);
	   						$('#subPropertyList').append(html);
	   					});
	   		        	
   		        	}
   		        },
   		        error: function(){
   		            alert("err");
   		        }
   		  	});
   		    
   			//[중분류] 테이블 추가 버튼 실행시
   	    	$("#addSubPropertyList").click(function() {
   	   			var row = "<tr>";
   					row += "<td><input type='checkbox' name='chk' checked></td>";
   					row += "<td>"+selectedPropCode+"</td>";
   					row += "<td>"+selectedPropName+"</td>";
   					row += "<td></td>";
   					row += "<td><input type='text' class='form-control' style='text-align:center; height:23px; font-size:13px' value=''/></td>";
   					row += "<td><input type='checkbox' checked></td>";
   					row += "</tr>";
   				$("#subPropertyList").append(row);
   				row = null;
   		 	});
	   		 
   		}
    })
  </script>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
		 
		 <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">
		 	<h5 style="font-weight:bold">ROOM FILTER MASTER</h5>
            <div class="btn-toolbar mb-2 mb-md-0">
              <div class="btn-group mr-2">
                <button class="btn btn-sm btn-outline-secondary" id="addPropertyList">추가</button>
                <button class="btn btn-sm btn-outline-secondary" id="savePropertyBtn">저장</button>
              </div>
            </div>
         </div>
        
        <div id="alertArea" role="alert">
		</div> 
		
        <div style="overflow:auto; height:200px;">
			<table class="table table-striped table-sm" id="propertyList" style="text-align:center;">
				<tr class = "thead-dark" style='position:relative;top:expression(this.offsetParent.scrollTop);'>
					<th colspan="2">대분류코드</th>
					<th>대분류명</th>
					<th colspan="2">사용여부</th>
				</tr>
				<c:if test="${empty propertyList}">
					<tr>
						<td colspan='4'>등록된 필터 대분류가 없습니다.</td>
					</tr>		 
				</c:if>
				<c:forEach var="dto" items="${propertyList}">
				<script>
					var checkYn = "${dto.isUse}";
					if(checkYn=="Y") $("#isUseProp").prop("checked",true);
				</script>
					<tr>
						<td><input type="checkbox" name="chk"></td>
						<td>${dto.id}</td>
						<td><input type="text" class="form-control" name = "propName" onclick="event.cancelBubble=true"
										value="${dto.name}" style="text-align:center; height:23px; font-size:13px"></td> <!-- 해당 td 이벤트 제외 -->
						<td colspan="2"><input type="checkbox" id="isUseProp"></td>
					</tr>			
				</c:forEach>
			</table>
		</div>
		<br>
		<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">
		 <h5 style="font-weight:bold">ROOM FILTER SUB MASTER</h5>
            <div class="btn-toolbar mb-2 mb-md-0">
              <div class="btn-group mr-2">
                <button class="btn btn-sm btn-outline-secondary" id="addSubPropertyList">추가</button>
                <button class="btn btn-sm btn-outline-secondary" id="saveSubPropertyBtn">저장</button>
              </div>
            </div>
         </div>
		
		<div style="overflow:auto; height:200px;">
			<table class="table table-bordered table-sm" id="subPropertyList" style="text-align:center;">
				<tr>
					<th>checked</th>
					<th>대분류코드</th>
					<th>대분류명</th>
					<th>중분류코드</th>
					<th>중분류명</th>
					<th>사용여부</th>
				</tr>
				<c:if test="${empty subPropertyList}">
					<tr>
						<td colspan='6'>등록된 필터 중분류가 없습니다.</td>
					</tr>		 
				</c:if>
				<c:forEach var="dto" items="${subPropertyList}">
					<tr>
						<td><input type="checkbox" name="chk"></td>
						<td>${dto.propertyTypeId}</td>
						<td>${dto.propertyTypeName}</td>
						<td>${dto.id}</td>
						<td><input type="text" class="form-control" value="${dto.name}" style="text-align:center; height:23px; font-size:13px"/></td>
						<td><input type="checkbox"></td>
					</tr>			
				</c:forEach>
			</table>
		</div>
	</main>
</body>