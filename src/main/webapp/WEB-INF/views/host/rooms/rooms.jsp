<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- rooms.jsp: 숙소의 모든 정보 -->
<html>
<head>
<meta charset="UTF-8">
<title>${ROOM_NM}</title>
</head>
<body>
	<div align="left"><h2>${ROOM_NM}</h2></div>
	<div align="left"><!-- 후기, 슈퍼호스트, 주소 --></div><div align="right">공유하기, 저장</div><br>
	<!--  숙소 사진 배치 --><br>
	<div align="left">
		<div align="left">
			<h3>사용자명님이 호스팅하는 숙소중분류 privacy_type</h3><br>
			최대인원 명 / 방 갯수 / 침대 갯수 / 욕실 갯수
		</div>
		<div align="right"><!-- img: 호스터(?)의 개인 설명 페이지 >> 본 페이지의 밑으로 이동 --></div>
		
		<hr align="left" size="1" width="250" NOSHADE><br>
		<div align="left">
			privacy_type(집전체 or 방하나 . . . )<br>
			슈퍼호스트 여부<br>
			체크인 날짜 기반으로 무료 취소 날짜 공지<br>	
		</div>
		
		<hr align="left" size="1" width="250" NOSHADE><br>
		<!-- 숙소 설명(description)-->
		
		<hr align="left" size="1" width="250" NOSHADE><br>
		<h3>숙소 편의시설</h3>
		<div align="center" style="border: 1px solid blue; border-radius: 5px; float: left; width: 15%; padding:10px">
			편의시설 <b>더보기</b>
		</div>
	</div>
	<div align="right" >
	<div align="center" style="border: 1px solid blue; border-radius: 5px; float: right; width: 30%; padding:50px">
	<!-- 예약상세 내용이 들어있는 크다란 박스여 -->
		<div align="left">가격/박</div> <br>
		<table border="1">
			<tr>
				<td>체크인 날짜</td>
				<td>체크아웃 날짜</td>
			</tr>
			<tr>
				<td align="center" colspan="2">인원<!-- modal띄워서 인원체크: 성인, 어린이, 유아--></td>
			</tr>
		</table><br>
		
		<!-- <div align="center" style="border: 1px solid blue; border-radius: 5px; padding: 10px;">
			예약하기<!-- 예약하기 클릭 박스는 크기가 크다...! -->
		</div><br>-->
		<button type="button" class="btn btn-success">Success</button>
		예약확정 전에는 요금이 청구되지 않습니다.<br>
		<div align="left">가격 x ?박<br>서비스 수수료</div>
		<div align="right">\기본급<br>\수수료</div><br>
		
		<hr style="float: right" size="2" width="100" NOSHADE><br>
		<div align="left">총 합계</div>
		<div align="right">\합계 가격</div>
	</div><br>
	
	<div align="center" style="border: 1px solid red; border-radius: 5px; float: right; width: 20%;padding: 10px;">
		예약이 ~시간 후에 마감<br>
		(호스트가 해당 날짜에 대한 예약 수락을 곧 중단)
	</div><br>
	<a href="">숙소 신고하기</a>
	</div>
	<hr align="right" size="2" width="100" NOSHADE><br>
</body>
</html>