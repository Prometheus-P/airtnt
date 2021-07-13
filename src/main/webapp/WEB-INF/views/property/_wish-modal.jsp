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
                <c:if test="${not empty wishList.properties && 
                not empty wishList.properties.get(0).images}">
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
const FULL_HEART = "https://img.icons8.com/fluent/48/000000/like.png";
const EMPTY_HEART = "https://img.icons8.com/fluent-systems-regular/48/000000/like--v1.png";
var wishButton;
var wishTextTag;
var imgTag;
var wishPropertyId;

//화면 로드 시 초기화하는 과정
function initWish(propertyId, wishListId, isWished){
	wishButton = document.querySelector("a#wishProperty-" + propertyId);
	wishTextTag = wishButton.querySelector("span.wish-text");
	imgTag = wishButton.querySelector("img.heart");
	if("${sessionScope.member_id}" == ""){
		wishButton.href = "#LoginModal";
		imgTag.src = EMPTY_HEART;
		if(wishTextTag != null){
			wishTextTag.innerHTML = "저장";
		}
	} else {
		if(isWished == "true"){
			wishButton.href = "#";
			wishButton.setAttribute("class",
					"trigger-btn wish-button unwish wishList-" + wishListId);
			imgTag.src = FULL_HEART;
			if(wishTextTag != null){
				wishTextTag.innerHTML = "삭제";
			}
		} else {
			wishButton.href = "#wish-modal";
			imgTag.src = EMPTY_HEART;
			if(wishTextTag != null){
				wishTextTag.innerHTML = "저장";
			}
		}
	}
}

$(function(){
	$(".wishList-button").click(function(){
		// 위시리스트 등록
		var wishListId = this.getAttribute("id").split("-")[1];
		console.log("wish list id : " + wishListId);
		console.log("property id : " + wishPropertyId);
		
		$.ajax("/wish/async", {
			type : "get",
			data : {
				wish_id : wishListId,
				property_id : wishPropertyId
			}
		})
		.done(function(result){
			console.log("sql 실행 횟수 : " + result);
			if(result < 1){
				alert("위시리스트 추가 실패 : DB 오류");
			} else {
				// 찬 하트
				imgTag.src = FULL_HEART;
				$("a#wishProperty-" + wishPropertyId)
					.addClass("unwish")
					.addClass("wishList-" + wishListId)
					.attr("href", "#");
				if(wishTextTag != null){
					wishTextTag.innerHTML = "삭제";
				}
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
		wishButton = this;
		wishTextTag = this.querySelector("span.wish-text");
		imgTag = this.querySelector("img.heart");
		wishPropertyId = this.getAttribute("id").split('-')[1];
		
		if($(this).hasClass("unwish")){
			var wishListClass = $(this).attr("class").split(' ')[3];
			console.log(wishListClass);
			var wishListId = wishListClass.split('-')[1];
			// 위시리스트 삭제
			console.log("wish list id : " + wishListId);
			console.log("property id : " + wishPropertyId);
			
			$.ajax("/unwish/async", {
				type : "get",
				data : {
					wish_id : wishListId,
					property_id : wishPropertyId
				}
			})
			.done(function(result){
				console.log("sql 실행 횟수 : " + result);
				if(result < 1){
					alert("위시리스트 삭제 실패 : DB 오류");
				} else {
					// 빈 하트
					imgTag.src = EMPTY_HEART;
					$("a#wishProperty-" + wishPropertyId)
						.removeClass("unwish")
						.removeClass(wishListClass)
						.attr("href", "#wish-modal");
					if(wishTextTag != null){
						wishTextTag.innerHTML = "저장";
					}
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