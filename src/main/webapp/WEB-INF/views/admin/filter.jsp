<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file= "admin_nav.jsp"%> 
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<style> 
		#propertyList th {
		    position: sticky;
		    top: 0px;
		}	
		tr, td { font-size:13px; }
	</style>
</head>
<body>
	<script>
	
    $(document).ready(function(){
    	//ajax 공통 필요 변수
    	var token = $("input[name='_csrf']").val();
		var header = "X-CSRF-TOKEN";
		
		//[PROPERTY TYPE] 테이블 컬럼 클릭 이벤트 --> 중분류 데이터 불러옴
	   	$("#propertyTypeTable tr").click(function(){
            var tr = $(this);
            selectedPropCode = tr.find("td:eq(1)").text(); //선택한 row의 id컬럼 값을 가져온다
            selectedPropName = tr.find("td:eq(2)").children().val();
            getSubPropertyType(selectedPropCode);
	    });
		
		
		//[저장] json 세팅 메소드
		function setJsonObj(checkbox, mode, jsonArray){
			// 체크된 체크박스 값을 가져온다
			// checkbox.parent() : checkbox의 부모는 <td>. checkbox.parent().parent() : <td>의 부모이므로 <tr>
			checkbox.each(function(i) {
				
				var tr = checkbox.parent().parent().eq(i);
				var td = tr.children();
				
				var jsonObj	= new Object();
			    
				if(mode != 'SUB_PROPERTY'){
					//(1) 대분류ID
					jsonObj.id = td.eq(1).text();
					//(2) 대분류명
					jsonObj.name = td.eq(2).children().val();
					//(3) 대분류 사용여부  : checkbox 체크 여부 확인
					if(td.eq(3).children().is(":checked") == true) jsonObj.isUse = "Y";
					else jsonObj.isUse = "N";
					
				}else{
					//(1) 대분류id
					jsonObj.propertyTypeId = td.eq(1).text();
					//(2) 중분류id
					jsonObj.id = td.eq(3).text();
					//(3) 중분류명
					jsonObj.name = td.eq(4).children().val();
					if(td.eq(5).children().is(":checked") == true) jsonObj.isUse = "Y";
					else jsonObj.isUse = "N";
				}
				console.log(jsonObj);	
				jsonObj = JSON.stringify(jsonObj);
				//String 형태로 파싱한 객체를 다시 json으로 변환
				jsonArray.push(JSON.parse(jsonObj));
			});
		}
		
	 // [공통] 저장
	   	$("#saveRoomTypeBtn, #saveAmenityTypeBtn, #savePropertyTypeBtn, #saveSubPropertyTypeBtn").click(function(){
	   		//저장 대상으로 선택된 테이블 분류
	   		var selectedId = $(this).attr("id");
	   		var url = "filter/update/master";
	   		var type = null;
	   		
	   		var rowData = new Array();
			var tdArr = new Array();
			var checkbox = $("input[name=chk]:checked");
			
			if(selectedId == 'saveRoomTypeBtn'){
				type = "ROOM";
			}else if(selectedId == 'saveAmenityTypeBtn'){
				type = "AMENITY";
			}else if(selectedId == 'savePropertyTypeBtn'){
				type = "PROPERTY";
			}else if(selectedId == 'saveSubPropertyTypeBtn'){
				type = "SUB_PROPERTY";
				url = "filter/update/sub";
			}else{
				alert("저장버튼 다시 눌러주세요");
				return;
			}
	
			var jsonArray 	= new Array();
			setJsonObj(checkbox, type, jsonArray);
			
			$.ajax({
	  		        url: url,
	  		        type: "POST",
	  		        beforeSend : function(xhr)
	  		        {
	  		        	xhr.setRequestHeader(header, token);
	  		        },
	  		        data: {
	  		        	data : JSON.stringify(jsonArray),
	  		      		type : type
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
	 
	  	//[공통] 마스터 테이블 추가 버튼 실행시
   		$("#addRoomTypeBtn, #addAmenityTypeBtn, #addPropertyTypeBtn").click(function() {
   			var row = null;
				row = "<tr>";
				row += "<td><input type='checkbox' name='chk' checked></td>";
				row += '<td><input type="button" value="del" onclick="javascript:rowDel(this);"></td>';
				row += "<td><input type='text' class='form-control' style='text-align:center; height:23px; font-size:13px' value=''/></td>";
				row += "<td><input type='checkbox' checked></td>";
				row += "</tr>";
			var selectedId = $(this).attr("id");
			if(selectedId == 'addRoomTypeBtn'){
				$("#roomTypeTable").append(row);
			}else if(selectedId == 'addAmenityTypeBtn'){
				$("#amenityTypeTable").append(row);
			}else if(selectedId == 'addPropertyTypeBtn'){
				$("#propertyTypeTable").append(row);
			}
			
	   	});
	  	
	  	
   		//[SUB PROPERTY TYPE] 테이블 추가 버튼 실행시
   		$("#addSubPropertyTypeBtn").click(function() {
   			var row = "<tr>";
				row += "<td><input type='checkbox' name='chk' checked></td>";
				row += "<td>"+selectedPropCode+"</td>";
				row += "<td>"+selectedPropName+"</td>";
				row += "<td></td>";
				row += "<td><input type='text' class='form-control' style='text-align:center; height:23px; font-size:13px' value=''/></td>";
				row += "<td><input type='checkbox' checked></td>";
				row += "</tr>";
			$("#subPropertyTypeTable").append(row);
	 	});
   		
   		
		//[PROPERTY TYPE] 선택한 row에 대한 sub property list를 가져온다.
   	 	function getSubPropertyType(selectedId) {
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
  		        	$('#subPropertyTypeTable td').remove();	 //불러온 데이터로 SubTable 새로 그릴거라서 기존 td 들은 지워준다
  		        	if(data.length<1){
  		        		html = $('<tr><td colspan="7">데이터가 존재하지 않습니다</td></tr>');
  		        		$('#subPropertyTypeTable').append(html);
  		        	}else{
	   		        	$(data).each(function(){	//sub테이블의 td부분을 for문으로 돌려서 그려준다
	   						html = $('<tr>' +
	   									 '<td><input type="checkbox" name="chk"></td>' +
	   									 '<td>' + this.propertyTypeId + '</td>' +
	   									 '<td>' + this.propertyTypeName + '</td>' +
	   									 '<td>' + this.id + '</td>' +
	   									 '<td><input type="text" class="form-control" value="' + this.name + '" style="text-align:center; height:23px; font-size:13px;"/></td>' +
	   									 '<td><input type="checkbox" name="subUseYn'+ this.id +'"></td>' +
	   									 '<td></td>' +
	   								 '</tr>'
	   								);
	   						$('#subPropertyTypeTable').append(html);
	   						
	   		        		if(this.isUse=='Y'){ //db값에 따른 체크박스 체크 분기처리
	   		        			$('input:checkbox[name="subUseYn'+ this.id +'"]').attr("checked", true);
	   		        		}
	   		        		
	   					});
	   		        	
  		        	}
  		        },
  		        error: function(){
  		            alert("err");
  		        }
  		  });
  		    
   		}
    })
    
    //[공통] 추가 행 삭제
	 function rowDel(obj){
	    var tr = obj.parentNode.parentNode;
	    tr.parentNode.removeChild(tr);
	 }
    
    function changeContent(obj) {
    	//alert(obj);
    	// document.getElementByName('propName1').checked = true;
    	//$('input:checkbox[name="propName1"]').attr("checked", true);
    	alert(obj.checked);
    }
    
  </script>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
	
	<!-- (1) 방유형코드 : ROOM TYPE -->		 
		 <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">
		 	<h5 style="font-weight:bold">ROOM TYPE</h5>
            <div class="btn-toolbar mb-2 mb-md-0">
              <div class="btn-group mr-2">
                <button class="btn btn-sm btn-outline-secondary" id="addRoomTypeBtn">추가</button>
                <button class="btn btn-sm btn-outline-secondary" id="saveRoomTypeBtn">저장</button>
              </div>
            </div>
         </div>
		
        <div style="overflow:auto; height:18%;">
			<table class="table table-striped table-sm" id="roomTypeTable" style="text-align:center;">
				<tr class = "thead-dark" style='position:relative;top:expression(this.offsetParent.scrollTop);'>
					<th colspan="2">룸타입코드</th>
					<th>룸타입명</th>
					<th colspan="2">사용여부</th>
				</tr>
				<c:if test="${empty roomTypeList}">
					<tr>
						<td colspan='4'>등록된 룸 타입 코드가 없습니다.</td>
					</tr>		 
				</c:if>
				<c:forEach var="dto" items="${roomTypeList}" varStatus="status">
					<tr>
						<td><input type="checkbox" name="chk"></td>
						
						<td>${dto.id}</td>
						<td><input type="text" class="form-control" name = "propName" onclick="event.cancelBubble=true" 
								onchange="changeContent(this.name)" value="${dto.name}" 
								style="text-align:center; height:23px; font-size:13px"></td> <!-- event.cancelBubble=true : 해당 td는 클릭이벤트 제외 -->
						<c:set var = "chk" value="${dto.isUse}"></c:set>
						<c:set var='propertyTypeId' value="propertyTypeId"></c:set>
						<td colspan="2">
							<!-- isUse 값에 따른 체크박스 체크값 분기 처리 -->
							<input type="checkbox" name="isUseYnRoomType" <c:if test="${fn:contains(chk, 'Y')}"> checked</c:if>>
						</td>
					</tr>			
				</c:forEach>
			</table>
		</div>
		
		<br><br>
		
		<!-- (2) 편의시설코드 -->		 
		 <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">
		 	<h5 style="font-weight:bold">AMENITY TYPE</h5>
            <div class="btn-toolbar mb-2 mb-md-0">
              <div class="btn-group mr-2">
                <button class="btn btn-sm btn-outline-secondary" id="addAmenityTypeBtn">추가</button>
                <button class="btn btn-sm btn-outline-secondary" id="saveAmenityTypeBtn">저장</button>
              </div>
            </div>
         </div>
		
        <div style="overflow:auto; height:25%;">
			<table class="table table-striped table-sm" id="amenityTypeTable" style="text-align:center;">
				<tr class = "thead-dark" style='position:relative;top:expression(this.offsetParent.scrollTop);'>
					<th colspan="2">편의시설코드</th>
					<th>편의시설명</th>
					<th colspan="2">사용여부</th>
				</tr>
				<c:if test="${empty amenityTypeList}">
					<tr>
						<td colspan='4'>등록된 편의 시설 코드가 없습니다.</td>
					</tr>		 
				</c:if>
				<c:forEach var="dto" items="${amenityTypeList}">
					<tr>
						<td><input type="checkbox" name="chk"></td>
						<td>${dto.id}</td>
						<td><input type="text" class="form-control" name = "propName" onclick="event.cancelBubble=true"
										value="${dto.name}" style="text-align:center; height:23px; font-size:13px"></td> <!-- 해당 td 이벤트 제외 -->
						<c:set var = "chk" value="${dto.isUse}"></c:set>
						<td colspan="2">
							<!-- isUse 값에 따른 체크박스 체크값 분기 처리 -->
							<input type="checkbox" name="isUseYnAmenityType" <c:if test="${fn:contains(chk, 'Y')}"> checked</c:if>>
						</td>
					</tr>			
				</c:forEach>
			</table>
		</div>
		
		<br><br>
		
		<!-- (3) 숙소타입코드 -->		
		<div style="width:35%; float:left;"> 
			 <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">
			 	<h5 style="font-weight:bold">PROPERTY TYPE</h5>
	            <div class="btn-toolbar mb-2 mb-md-0">
	              <div class="btn-group mr-2">
	                <button class="btn btn-sm btn-outline-secondary" id="addPropertyTypeBtn">추가</button>
	                <button class="btn btn-sm btn-outline-secondary" id="savePropertyTypeBtn">저장</button>
	              </div>
	            </div>
	         </div>
			
	        <div style="overflow:auto; height:20%;">
				<table class="table table-striped table-sm" id="propertyTypeTable" style="text-align:center;">
					<tr class = "thead-dark" style='position:relative;top:expression(this.offsetParent.scrollTop);'>
						<th colspan="2">숙소유형코드</th>
						<th>숙소유형명</th>
						<th colspan="2">사용여부</th>
					</tr>
					<c:if test="${empty propertyTypeList}">
						<tr>
							<td colspan='4'>등록된 숙소 유형 코드가 없습니다.</td>
						</tr>		 
					</c:if>
					<c:forEach var="dto" items="${propertyTypeList}">
						<tr>
							<td><input type="checkbox" name="chk"></td>
							<td>${dto.id}</td>
							<td><input type="text" class="form-control" name = "propName" onclick="event.cancelBubble=true"
											value="${dto.name}" style="text-align:center; height:23px; font-size:13px"></td> <!-- 해당 td 이벤트 제외 -->
							<c:set var = "chk" value="${dto.isUse}"></c:set>
							<td colspan="2">
								<!-- isUse 값에 따른 체크박스 체크값 분기 처리 -->
								<input type="checkbox" name="isUseYnPropertyType" <c:if test="${fn:contains(chk, 'Y')}"> checked</c:if>>
							</td>
						</tr>			
					</c:forEach>
				</table>
			</div>
		</div>
		
		<!-- (4) 숙소타입코드 SUB -->		
		<div style="width:60%; float:right;"> 
			 <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">
			 	<h5 style="font-weight:bold">SUB PROPERTY TYPE</h5>
	            <div class="btn-toolbar mb-2 mb-md-0">
	              <div class="btn-group mr-2">
	                <button class="btn btn-sm btn-outline-secondary" id="addSubPropertyTypeBtn">추가</button>
	                <button class="btn btn-sm btn-outline-secondary" id="saveSubPropertyTypeBtn">저장</button>
	              </div>
	            </div>
	         </div>
			
	        <div style="overflow:auto; height:200px;">
				<table class="table table-striped table-sm" id="subPropertyTypeTable" style="text-align:center;">
					<tr class = "thead-dark" style='position:relative;top:expression(this.offsetParent.scrollTop);'>
						<th colspan="3">Property Type</th>
						<th colspan="2">Sub Property Type</th>
						<th colspan="2">사용여부</th>
					</tr>
					<c:if test="${empty subPropertyTypeList}">
						<tr>
							<td colspan='7'>등록된 SUB 숙소 유형 코드가 없습니다.</td>
						</tr>		 
					</c:if>
					<c:forEach var="dto" items="${subPropertyTypeList}">
						<tr>
							<td><input type="checkbox" name="chk"></td>
							<td>${dto.propertyTypeId}</td>
							<td>${dto.propertyTypeName}</td>
							<td>${dto.id}</td>
							<td><input type="text" class="form-control" name = "propName" onclick="event.cancelBubble=true"
											value="${dto.name}" style="text-align:center; height:23px; font-size:13px"></td> <!-- 해당 td 이벤트 제외 -->
							<c:set var = "chk" value="${dto.isUse}"></c:set>
							<td colspan="2">
								<!-- isUse 값에 따른 체크박스 체크값 분기 처리 -->
								<input type="checkbox" name="isUseYnSubPropertyType" <c:if test="${fn:contains(chk, 'Y')}"> checked</c:if>>
							</td>
						</tr>			
					</c:forEach>
				</table>
			</div>
		</div>
		
	</main>
</body>