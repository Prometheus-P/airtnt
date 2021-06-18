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
	<div align="left"><h2>${ROOM_NM}</h2></div><br>
	<div align="left"><!-- 후기, 슈퍼호스트, 주소 --></div><div align="right">공유하기, 저장</div><br>
	<!--  사진 배치 --><br>
	<div align="left">
		
	</div>
	<div align="right" style="border: 1px solid blue; border-radius: 5px; padding: 100px;">
	<!-- 예약상세 내용이 들어있는 크다란 박스여 -->
		<div align="left">가격/박</div> <br>
		<table>
			<tr>
				<td>체크인 날짜</td>
				<td>체크아웃 날짜</td>
			</tr>
			<tr>
				<td>인원<!-- modal띄워서 인원체크: 성인, 어린이, 유아--></td>
			</tr>
		</table><br>
		<div style="border: 1px solid blue; border-radius: 5px; padding: 10px;">
			예약하기
		</div><br>
		예약확정 전에는 요금이 청구되지 않습니다.<br>
		<div align="left">가격 x ?박<br>서비스 수수료</div>
		<div align="right">\기본급<br>\수수료</div>
		<hr size="1" width="100"NOSHADE>
	</div><br>
</body>
</html>