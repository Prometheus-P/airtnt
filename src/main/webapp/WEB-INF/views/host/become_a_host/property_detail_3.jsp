<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>detail</title>
</head>
<body>
<h2>숙소 상세 </h2>
<form method="post" name="f" action="<c:url value='/host/property_image_4'/>"
onsubmit="check()">
<table>
	<tr>
		<td>숙소 이름: </td>
		<td><input type="text" name="name"></td>
	</tr>
	<tr>
		<td>숙소의 설명을 적어주세요: </td>
		<td><input type ="text" name="description"></td>
	</tr>
	<tr>
		<td>숙소의 가격을 정해주세요:</td>
		<td> <input type="number" name="price"></td>
	</tr>
	<tr>
		<td>어떤 편의시설을 가지고 있나요?</td>
		<c:forEach var = "dto" items="${listAmenity}">
		<td>
			<input type="checkbox" name="${dto.name}" value="${dto.id}">
		</td>
		</c:forEach>
	</tr>
	<tr>
		<td><input type="submit" name="다음페이지"></td>
	</tr>
</table>
</form>

<script type="text/javascript">
	function check(){
		if (f.name.value==""){
			alert("숙소 이름을 입력해 주세요!!")
			f.name.focus()
			return
		}
		if(f.description.value==""){
			alert("숙소 설명을 입력해 주세요!!")
			f.description.focus()
			return
		}
		if(f.price.value==""){
			alert("숙소 가격을 입력해 주세요!!")
			f.price.focus()
			return
		}
		document.f.submit()
	}
</script>
</body>
</html>