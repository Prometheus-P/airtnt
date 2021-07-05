<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- wish list modal -->
<div id="wish-modal" class="modal fade">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header position-relative">
        <h3 class="modal-title">위시리스트 선택</h3>
        <div class="position-absolute end-0" style="padding-right: 20px;">
          <button type="button" class="close" id="wish-close-button"
          data-dismiss="modal" aria-hidden="true" style="font-size: 30px">×</button>
        </div>
      </div>
      <div class="modal-body content" style="font-size: 20px">
        <c:set var="i" value="1"/>
        <c:forEach var="wishList" items="${wishLists}">
          <div class="one_half <c:if test='${i % 2 == 1}'>first</c:if>" align="center">
            <a class="wishList-button" id="wishList-${wishList.id}" role="button">
              <img src="
                <c:if test="${wishList.properties.size() > 0}">
                  ${wishList.properties.get(0).images.get(0).path}
                </c:if>" style="width: 20rem;height: 15rem"><br>
              ${wishList.name}
            </a>
          </div>
          <c:set var="i" value="${i + 1}"/>
        </c:forEach>
          <div class="one_half <c:if test='${i % 2 == 1}'>first</c:if>">
            <a href="<c:url value='/wishList?member_id=${sessionScope.member_id}'/>"
            class="btn" id="add-wishList"
            style="width: 20rem; height: 15rem; font-size: 20px; padding-top: 6rem">
              + 위시리스트 추가
            </a>
          </div>
      </div>
      <div class="modal-footer">
        AirTnT CopyRight ⓒ TeamBit corp. All Rights Reserved.
      </div>
    </div>
  </div>
</div>
</body>
<script type="text/javascript">
var wishPropertyId;

$(function(){
	$(".wishList-button").click(function(){
		// 위시리스트 등록
		var wishListId = $(this).attr("id").split("-")[1];
		console.log("member id : ${sessionScope.member_id}");
		console.log("wish list id : " + wishListId);
		console.log("property id : " + wishPropertyId);
		
		$.ajax("/wish/async", {
			type : "get",
			data : {
				memberId : "${sessionScope.member_id}",
				wishListId : wishListId,
				wishPropertyId : wishPropertyId
			}
		})
		.done(function(result){
			console.log("sql 실행 횟수 : " + result);
			if(result < 1){
				alert("위시리스트 추가 실패 : DB 오류");
			} else {
				var imgTag = document.createElement("img");
				// 찬 하트
				imgTag.setAttribute("src", "https://img.icons8.com/fluent/48/000000/like.png");
				imgTag.setAttribute("style", "width: 3rem; height: 3rem");
				$("a#wishProperty-" + wishPropertyId)
					.addClass("unwish")
					.empty()
					.append(imgTag)
					.attr("href", "#");
			}
		})
		.fail(function(){
			alert("서버와 통신 실패");
		})
		.always(function (){
			$("button#wish-close-button").click();
		});
	});
	
	$(".wish-button").click(function(){
		if($(this).hasClass("unwish")){
			// 위시리스트 삭제
			var unwishPropertyId = $(this).attr("id").split('-')[1];
			console.log("member id : ${sessionScope.member_id}");
			console.log("property id : " + unwishPropertyId);
			
			$.ajax("/unwish/async", {
				type : "get",
				data : {
					memberId : "${sessionScope.member_id}",
					unwishPropertyId : unwishPropertyId
				}
			})
			.done(function(result){
				console.log("sql 실행 횟수 : " + result);
				if(result < 1){
					alert("위시리스트 삭제 실패 : DB 오류");
				} else {
					var imgTag = document.createElement("img");
					// 빈 하트
					imgTag.setAttribute("src", "https://img.icons8.com/fluent-systems-regular/48/000000/like--v1.png");
					imgTag.setAttribute("style", "width: 3rem; height: 3rem");
					$("a#wishProperty-" + unwishPropertyId)
						.removeClass("unwish")
						.empty()
						.append(imgTag)
						.attr("href", "#wish-modal");
				}
			})
			.fail(function(){
				alert("서버와 통신 실패");
			});
		}
	});
});
</script>
</html>