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
	   									 '<td><input type="checkbox" id="isUseSubProp"></td>' +
	   									 '<td></td>' +
	   								 '</tr>'
	   								);
	   						$('#subPropertyTypeTable').append(html);
	   					});
	   		        	
  		        	}
  		        },
  		        error: function(){
  		            alert("err");
  		        }
  		  });
	   		 
   		}
    })
  </script>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
	
	<!-- (1) 방유형코드 -->		 
		 <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">
		 	<h5 style="font-weight:bold">ROOM TYPE</h5>
            <div class="btn-toolbar mb-2 mb-md-0">
              <div class="btn-group mr-2">
                <button class="btn btn-sm btn-outline-secondary" id="addPropertyList">추가</button>
                <button class="btn btn-sm btn-outline-secondary" id="savePropertyBtn">저장</button>
              </div>
            </div>
         </div>
		
        <div style="overflow:auto; height:25%;">
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
				<c:forEach var="dto" items="${roomTypeList}">
				<script>
					var checkYn = "${dto.isUse}";
					if(checkYn=="Y") $("#isUseYnRoomType").prop("checked",true);
				</script>
					<tr>
						<td><input type="checkbox" name="chk"></td>
						<td>${dto.id}</td>
						<td><input type="text" class="form-control" name = "propName" onclick="event.cancelBubble=true"
										value="${dto.name}" style="text-align:center; height:23px; font-size:13px"></td> <!-- 해당 td 이벤트 제외 -->
						<td colspan="2"><input type="checkbox" id="isUseYnRoomType"></td>
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
                <button class="btn btn-sm btn-outline-secondary" id="addPropertyList">추가</button>
                <button class="btn btn-sm btn-outline-secondary" id="savePropertyBtn">저장</button>
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
				<script>
					var checkYn = "${dto.isUse}";
					if(checkYn=="Y") $("#isUseYnAmenityType").prop("checked",true);
				</script>
					<tr>
						<td><input type="checkbox" name="chk"></td>
						<td>${dto.id}</td>
						<td><input type="text" class="form-control" name = "propName" onclick="event.cancelBubble=true"
										value="${dto.name}" style="text-align:center; height:23px; font-size:13px"></td> <!-- 해당 td 이벤트 제외 -->
						<td colspan="2"><input type="checkbox" id="isUseYnAmenityType"></td>
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
	                <button class="btn btn-sm btn-outline-secondary" id="addPropertyList">추가</button>
	                <button class="btn btn-sm btn-outline-secondary" id="savePropertyBtn">저장</button>
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
					<script>
						var checkYn = "${dto.isUse}";
						if(checkYn=="Y") $("#isUseYnPropertyType").prop("checked",true);
					</script>
						<tr>
							<td><input type="checkbox" name="chk"></td>
							<td>${dto.id}</td>
							<td><input type="text" class="form-control" name = "propName" onclick="event.cancelBubble=true"
											value="${dto.name}" style="text-align:center; height:23px; font-size:13px"></td> <!-- 해당 td 이벤트 제외 -->
							<td colspan="2"><input type="checkbox" id="isUseYnPropertyType"></td>
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
	                <button class="btn btn-sm btn-outline-secondary" id="addPropertyList">추가</button>
	                <button class="btn btn-sm btn-outline-secondary" id="savePropertyBtn">저장</button>
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
					<script>
						var checkYn = "${dto.isUse}";
						if(checkYn=="Y") $("#isUseYnPropertyType").prop("checked",true);
					</script>
						<tr>
							<td><input type="checkbox" name="chk"></td>
							<td>${dto.propertyTypeId}</td>
							<td>${dto.propertyTypeName}</td>
							<td>${dto.id}</td>
							<td><input type="text" class="form-control" name = "propName" onclick="event.cancelBubble=true"
											value="${dto.name}" style="text-align:center; height:23px; font-size:13px"></td> <!-- 해당 td 이벤트 제외 -->
							<td colspan="2"><input type="checkbox" id="isUseYnPropertyType"></td>
						</tr>			
					</c:forEach>
				</table>
			</div>
		</div>
		
	</main>
</body>