<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- hosting_listing.jsp : 호스트가 등록한 숙소 목록 -->
<html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<meta charset="UTF-8">
<title>숙소 목록</title>
<script src='https://github.com/mozilla-comm/ical.js/releases/download/v1.4.0/ical.js'></script>
<script src="/resources_host/calendar/main.js"></script>
<link href="/resources_host/calendar/main.css" rel='stylesheet' />

<style>
  #loading {
    display: none;
    position: absolute;
    top: 10px;
    right: 10px;
  }

  #calendar {
    max-width: 100px;
    margin: 40px auto;
    padding: 0 10px;
  }
</style>
		<script>
			$(document).ready(function() {
				$('[data-toggle="modal"]').tooltip();
			});

  			document.addEventListener('DOMContentLoaded', function() {
   			var calendarEl = document.getElementById('calendar');
			var date = new Date();
   			var calendar = new FullCalendar.Calendar(calendarEl, {
      		displayEventTime: false,
      		initialDate: date,
     		navLinks: true, // can click day/week names to navigate views
    		selectable: false,
     		selectMirror: true,
       		editable: true,
       		dayMaxEvents: true, // allow "more" link when too many events
      		events: [
          {
            title: 'All Day Event',
            start: '2021-07-01',
            url:''
          },
          {
            title: 'Long Event',
            start: '2021-07-07',
            end: '2021-07-10'
          }
        ],
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,listYear'
      },

    });

    calendar.render();
  });
</script>
</head>
<%@ include file="top.jsp"%>
<body>

	<div class="container theme-showcase" role="main">
		
			<div class="page-header">
				<br> <br> <br>
				<h1>숙소 목록</h1>
			</div>
			<table class="table table-striped" style="font-size: 15px">
				<thead>
					<tr>
						<th>#</th>
						<th>숙소명</th>
						<th>등록일</th>
						<th>주소</th>
						<th>숙소유형</th>
						<th rowspan="2">방 유형</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="dto" items="${listProperty}">
						<c:set var="count" value="${count+1}" />
						<tr>
							<td>${count}</td>
							<td>${dto.name}</td>
							<td>${dto.regDate}</td>
							<td>${dto.address}</td>
							<td>${dto.subPropertyTypeName}</td>
							<td>${dto.roomTypeName}</td>
							<td>
								<button type="button" class="btn btn-sm btn-info"
									data-toggle="modal" data-target="#${dto.id}"
									title="숙소 상세 내용을 확인 할 수 있습니다." data-placement="right">
									세부정보
								</button>
							</td>
						</tr>
						<div id="${dto.id}" class="modal fade" role="dialog">
							<div class="modal-dialog">
								<!-- Modal content-->
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">숙소 상세</h4>
									</div>
									<div class="modal-body">
										<div class="media">
											<div class="media-left" >
												<c:forEach var="listImage" items="${dto.images}">
													<img class="media-object"
													 src="${listImage.path}"  style="width: 200px"><br>
												</c:forEach>
											</div>
											<div class="media-body">
												<h3 class="media-heading">${dto.name}</h3>
												<br>
												<p>최대 수용 인원 : ${dto.maxGuest}</p>
												<p>침대 수 : ${dto.bedCount}</p>
												<p>가격 : ${dto.price}</p>
												<p>편의시설 : <br>
												<c:forEach var="listAmenity" items="${dto.amenityTypes}">
													${listAmenity.name}<br>
												</c:forEach>
												</p>
												<p>숙소 설명 : ${dto.propertyDesc}</p>
												<p>수정일 : ${dto.modDate}</p>
												<p>
												<button onclick="location.href='<c:url value="/property/detail"/>?propertyId=${dto.id}'"
												type="button" class="btn btn-primary" formmethod="get">
												게시된 숙소 확인</button>
												<button onclick="location.href='<c:url value="/host/property_update"/>?propertyId=${dto.id}'" 
												type="button" class="btn btn-warning"  formmethod="get" >
												수정하기</button>
												<button onclick="deletePro(${dto.id})" 
												type="button" class="btn btn-danger"  formmethod="get" >
												삭제하기</button>
												</p>
											</div>
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">닫기</button>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</tbody>
			</table>
			
			<div class="calendar"></div>
		</div>
	<%@ include file="../../bottom.jsp"%>
	<script>
		function deletePro(id){
			var check = window.confirm("정말 삭제하시겠습니까?");
			if(check){
				var propertyId = id
				$.ajax({
					url : "/host/property_delete",
					type : "post",
					data : {'propertyId': propertyId},
					dataType:'text',
					success : function(data) {
						if (JSON.parse(data)['result'] == "OK") {
							alert("숙소 삭제 성공!");
							location.reload(true);
							return;
						}else{
							alert("숙소 삭제 실패! 잠시 후 다시 시도해주세요.");
							return;
						}
								
							},
					error: function (xhr, status, error) {
						   	   alert("서버오류로 지연되고있습니다. 잠시 후 다시 시도해주시기 바랍니다.");
						   	    }
					});
			}
			return;
		}
	</script>
</body>
</html>








