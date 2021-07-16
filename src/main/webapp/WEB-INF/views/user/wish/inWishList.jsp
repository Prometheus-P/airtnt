<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/top.jsp"%>
<script type="text/javascript">
const FULL_HEART = "https://img.icons8.com/fluent/48/000000/like.png";
const EMPTY_HEART = "https://img.icons8.com/fluent-systems-regular/48/000000/like--v1.png";
var wishButton;
var imgTag;
var wishPropertyId;
var count = 0;
$(function(){
	
	//[위시 등록 하트기능!]
	$(".wish-button").click(function(){
		wishButton = this;
		imgTag = this.querySelector("img.heart");
		wishPropertyId = this.getAttribute("id").split('-')[1];
		
		if($(this).hasClass("unwish")){
			// 위시리스트 삭제
			console.log("wish list id : ${wish_id}");
			console.log("property id : " + wishPropertyId);
			
			$.ajax("/unwish/async", {
				type : "get",
				data : {
					wish_id : "${wish_id}",
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
					$("a#wishProperty-" + wishPropertyId).removeClass("unwish");
				}
			})
			.fail(function(){
				alert("서버와 통신 실패");
			});
			
		} else {
			// 위시리스트 재등록
			var wishListId = this.getAttribute("id").split("-")[1];
			console.log("wish list id : ${wish_id}");
			console.log("property id : " + wishPropertyId);
			
			$.ajax("/wish/async", {
				type : "get",
				data : {
					wish_id : "${wish_id}",
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
					$("a#wishProperty-" + wishPropertyId).addClass("unwish");
				}
			})
			.fail(function(){
				alert("서버와 통신 실패");
			});
		}
	});
	
	//[more 버튼 누를때마다 리스트작성]
	$('#moreBtn').on('click', function(){
		
		count += 10;
	    var form = {
	            more: count,
	            wish_id: "${wish_id}"
	    }
	    console.log(form.more);
	    $.ajax({
	        url: "/inWishList",
	        type: "POST",
	        data: form,
	        success: function(data){
	           	console.log(data);
	           	if(data.length<1){
	           		$('#moreBtn').remove();
	           	}
	           	$(data).each(function(){
	           		html = $('<li style="height: 150px;">' +
							 '<div class="one_third first">' +
				                '<a href="/property/detail?propertyId='+this.property_id+'"><img src="'+this.path+'" alt="" style="object-fit:contain; width:200px; height:150px;"></a>' +
				              '</div>' +
				              '<div class="one_third">' +
				                '<h2><a href="/property/detail?propertyId='+this.property_id+'">'+this.property_name+'</a></h2>' +
				                '<h4>'+this.type_name+'/'+this.sub_type_name+' '+this.room_type_name+'</h4>' +
				                '<h4>'+this.property_address+'</h4>' +
				              '</div>' +
				              '<div class="one_third fl_right position-relative">' +
				                '<div class="position-absolute top-0 end-0">' +
	                               '<a href="#" class="wish-button unwish" id="wishProperty-'+this.property_id+'"' +
	                               'style="font-size: 20px">' +
	                                 '<img class="heart" src="https://img.icons8.com/fluent/48/000000/like.png"' +
	                                 'style="width: 3rem; height: 3rem">' +
	                               '</a>' +
				                '</div>' +
				              '</div>' +
							 '</li>' +
							 '<hr>'
							);
	        		$('#properties').append(html);
	           	});
	        },
	        error: function(){
	            alert("simpleWithObject err");
	        }
	    });
	});
	
});
</script>
	<style>
	 #test_btn{ border-top-left-radius: 5px; border-bottom-left-radius: 5px; border-top-right-radius: 5px; border-bottom-right-radius: 5px; margin-right:-4px; } 
	 #test_btn2{ border-top-left-radius: 20px; border-bottom-left-radius: 20px; border-top-right-radius: 20px; border-bottom-right-radius: 20px; margin-right:0px; } 
	 #test_btn3{ border-top-left-radius: 20px; border-bottom-left-radius: 20px; border-top-right-radius: 20px; border-bottom-right-radius: 20px; margin-right:0px; border: 1px solid #000000; background-color: rgba(0,0,0,0); color: #000000; padding: 5px;} 
	 #btn_group button{ border: 1px solid #a4dcf3; background-color: rgba(0,0,0,0); color: #a4dcf3; padding: 5px; }
	 #btn_group button:hover{ color:white; background-color: skyblue; } 
	 </style>
	<div class="hoc clear " style="margin-left: 0px;">
		<div class="one_half" style="margin-top: 100px;">
			<div class="container-sm">
				<div id="btn_group" class="fl_left"> 
					<a href="javascript:history.back()">
						<button id="test_btn" style="font-size:larger;">◀</button>
					</a>
			    </div>
			    <div id="btn_group" class="fl_right">
					<a href="#UpdateWish" data-toggle="modal">
						<button id="test_btn" style="font-size:small; border: 0px;">수정하기</button>
					</a>
			    </div>
			</div>
				<div class="container-sm fl_left" style="margin-top: 30px;">
					<div class="bold" style="font-size: 3vh; margin-bottom:2vh;">${wish_name}</div>
				    <div  id="btn_group" class="btn-group" role="group" aria-label="Basic outlined example">
						<a href="#Date" data-toggle="modal">
							<button id="test_btn2" style="font-size:20px; padding-left:15px; padding-right:15px;" type="button" class="btn btn-outline-primary">날짜</button>
						</a>
						<a href="#Guest" data-toggle="modal">
							<button id="test_btn2" style="font-size:20px; padding-left:15px; padding-right:15px;" type="button" class="btn btn-outline-primary">인원</button>
						</a>
					</div>
			<!-- 숙소리스트 부분 -->
				<!-- 위시리스트에 숙소가 없다면  -->
				<c:if test="${empty properties}">
					<div style="margin-top: 50px; margin-bottom: 50px;">
					<h2>저장된 항목 없음</h2><br>
					<h5>맘에 드는 게 있으면 하트 아이콘을 눌러 저장하세요. 다른 사람과의 여행을 계획하고 있다면 초대하세요. 함께 원하는 항목을 저장하고 투표할 수 있습니다.</h5>
					</div>
					<a href="/property/search?addressKey=">
						<button id="test_btn3" style="font-size:40px; padding-left:15px; padding-right:15px;" type="button" class="btn btn-outline-primary">둘러보기</button>
					</a>
				</c:if>
				<!-- 위시리스트에 숙소가 있다면  -->
				<c:if test="${not empty properties}">
					<ul id="properties" class="nospace clear " style="margin-top: 50px;">
			            <c:forEach var="dto" items="${properties}">
			            <li style="height: 150px;">
			              <div class="one_third first" >
			                <a href="/property/detail?propertyId=${dto.property_id}"><img src="${dto.path}" alt="" style="object-fit:contain; width:200px; height:150px;"></a>
			              </div>
			              <div class="one_third">
			                <h2><a href="/property/detail?propertyId=${dto.property_id}">${dto.property_name}</a></h2>
			                <h4>${dto.type_name}/${dto.sub_type_name} ${dto.room_type_name}</h4>
			                <h4>${dto.property_address}</h4>
			              </div>
			              <div class="one_third fl_right position-relative">
			                <div class="position-absolute top-0 end-0">
			                  <!-- Button trigger modal -->
                               <a href="#" class="wish-button unwish" id="wishProperty-${dto.property_id}"
                               style="font-size: 20px">
                                 <!-- 빈 하트 -->
                                 <img class="heart" src="https://img.icons8.com/fluent/48/000000/like.png"
                                 style="width: 3rem; height: 3rem">
                               </a>
			                </div>
			              </div>
			            </li>
			            <hr>
			            </c:forEach>
			            <!--more list 그려질곳-->
			          </ul>
			            <div class="text-center">
			            	<button id="moreBtn" style="font-size:13px; margin-top:10px; padding-left:8px; padding-right:8px;" type="button" class="btn">더보기</button>
			            </div>
			    </c:if>
			    </div>
	    </div>
	</div>
	
<!-- NewWishModal-->
<div id="UpdateWish" class="modal fade">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">수정</h4>	
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form action="updateWish" method="post">
					<input type="hidden" name="wish_id" value="${wish_id}">
					<div class="form-group">
							<input type="text" class="form-control" name="wish_name" placeholder="${wish_name}" required="required">
					</div>
					<!-- <div class="form-group">
							<select class="form-control" aria-label="Default select example" required="required" name="is_public">
							  <option value="0">전체공개</option>
							  <option value="1">비공개</option>
							</select>
					</div>   -->      
					<div class="form-group">
						<button type="submit" class="btn form-control">저장</button>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<a href="deleteWish?wish_id=${wish_id}">위시리스트 삭제하기</a>
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/bottom.jsp"%>