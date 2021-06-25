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
    })
  </script>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
		 
		 <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">
		 	<h5 style="font-weight:bold">ROOM TYPE</h5>
            <div class="btn-toolbar mb-2 mb-md-0">
              <div class="btn-group mr-2">
                <button class="btn btn-sm btn-outline-secondary" id="addPropertyList">추가</button>
                <button class="btn btn-sm btn-outline-secondary" id="savePropertyBtn">저장</button>
              </div>
            </div>
         </div>
		
        <div style="overflow:auto; height:200px;">
			<table class="table table-striped table-sm" id="roomTypeTable" style="text-align:center;">
				<tr class = "thead-dark" style='position:relative;top:expression(this.offsetParent.scrollTop);'>
					<th colspan="2">방유형코드</th>
					<th>방유형명</th>
					<th colspan="2">사용여부</th>
				</tr>
				<c:if test="${empty roomTypeList}">
					<tr>
						<td colspan='4'>등록된 필터 대분류가 없습니다.</td>
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
		
	</main>
</body>