<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- hosting_listing.jsp : 호스트가 등록한 숙소 목록 -->
<html>
<head>
<meta charset="UTF-8">
<title>숙소 목록</title>
<link href='/resources_host/calendar/main.css' rel='stylesheet' />
<script src='https://github.com/mozilla-comm/ical.js/releases/download/v1.4.0/ical.js'></script>
<script src='/resources_host/calendar/main.js'></script>
<script src='../packages/icalendar/main.global.js'></script>
<script>
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

</head>
<%@ include file="top.jsp"%>
<body>
	<div class="container theme-showcase" role="main">
		<div class="col-md-6">
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
						<th rowspan="2">숙소유형</th>
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
							<td>${dto.subPropertyTypeName}</td>
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
												<!-- <img src="#사진" class="media-object" style="width: 200px"> -->
												<div class="calendar"></div>
											</div>
											<div class="media-body">
												<h3 class="media-heading">${dto.name}</h3>
												<br>
												<p>숙소 유형 : ${dto.roomTypeName}</p>
												<p>대여 유형 : ${dto.roomTypeName}</p>
												<p>최대 수용 인원 : ${dto.maxGuest}</p>
												<p>침대 수 : ${dto.bedCount}</p>
												<p>가격 : ${dto.price}</p>
												<p>주소 : ${dto.address}</p>
												<p>숙소 설명 : ${dto.propertyDesc}</p>
												<p>수정일 : ${dto.modDate}</p>
												<p>
												<button onclick="location.href='<c:url value="/host/properties_update"/>?id=${dto.id}'" 
												type="button" class="btn btn-warning"  formmethod="get">
												수정하기</button>
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
		</div>
		<script>
			$(document).ready(function() {
				$('[data-toggle="modal"]').tooltip();
			});
		</script>
		<div class="calendar"></div>
	</div>
	<%@ include file="../../bottom.jsp"%>
</body>
</html>








