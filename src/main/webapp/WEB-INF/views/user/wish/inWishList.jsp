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
	           	if(data.length<10){
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
	
		<!-- 카카오맵 -->
        <div class="one_half" style="margin-top: 7px; width:30%">
       		<!-- 숙소리스트 : 맵 내 마커 정보 -->
          	<table id="markerPositionTb" style="display:none;">
          		<c:forEach var="property" items="${properties}">
          		<tr>
                 	<td>${property.property_id}</td>
                 	<td>${property.latitude}</td>
                 	<td>${property.longitude}</td>
                 	<td>${property.property_name}</td>
                 	<td>${property.type_name}</td>
                 	<td>${property.path}</td>
                 </tr>
          		</c:forEach>
          	</table>
          <div id="map" style="width:600px;height:600px;"></div>
          <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=62b11c585fb341eec39dbc28ac9bad71"></script>
          <script>
	      	$(document).ready(function(){
	      		var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	      		 mapOption = { 
	      			center: new kakao.maps.LatLng("${latitude}", "${longitude}"), // 지도의 중심좌표
			        level: 7 // 지도의 확대 레벨
			    };
	      		
		      	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		      	var bounds = new kakao.maps.LatLngBounds(); // 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체
		      	
		     	// 마커 객체 배열 생성(positions)
		      	var positions = []; 
		      	var selectedMarker = null; //클릭한 마커 담을 변수
		      	var table = $('#markerPositionTb tr'); //숙소 리스트
		      	for(var i=0; i<table.length; i++){
		      		
		      		var id = $('tr:eq('+i+')>td:eq(0)').html(); //숙소id
		      		var latitude = $('tr:eq('+i+')>td:eq(1)').html(); //위경도
		      		var longitude = $('tr:eq('+i+')>td:eq(2)').html();
		      		var name = $('tr:eq('+i+')>td:eq(3)').html(); //숙소명
		      		var propertyType = $('tr:eq('+i+')>td:eq(4)').html(); //숙소타입
		      		var image = $('tr:eq('+i+')>td:eq(5)').html(); //이미지
		      		
		      		if(name.length>16) name = name.substring(0, 16)+'...'; //숙소명 긴 경우

		      		//마커 각각의 객체를 positions 배열에 push
		      		positions.push({title : name,
		      						latlng : new kakao.maps.LatLng(latitude, longitude),
		      						id : id,
		      						propertyType : propertyType,
		      						image : image
		      					  });
		      	}
		        
		     	// 마커 이미지 주소
		      	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		     	
		      	for (var i=0; i<positions.length; i++) {
		      	    var data = positions[i];
		      	    displayMarker(data);
		      	}

		      	// 지도에 마커를 표시 및 오버레이 세팅 (오버레이 세팅은 나중에 함수로 따로 뺄 예정!)
		      	function displayMarker(data) { 
		      		// 마커 이미지 크기
		      	    var imageSize = new kakao.maps.Size(38, 40); 
		      	    
		      	    // 마커 이미지 생성    
		      	    var markerImage = new kakao.maps.MarkerImage("/resources/property_img/marker.png", imageSize); 
		      	    var overMarkerImage = new kakao.maps.MarkerImage("/resources/property_img/marker2.png", imageSize); 
		      	    var selectedMarkerImage = new kakao.maps.MarkerImage("/resources/property_img/marker1.png", imageSize); 
		      	    
		      	    var marker = new kakao.maps.Marker({
		      	        map: map,
		      	        position: data.latlng,
		      	      	image : markerImage // 마커 이미지 
		      	    });
		      	    
		      	 	marker.setMap(map); //마커 표시
		      	 	bounds.extend(positions[i].latlng); //최종단계에서 맵 중앙 재조정할때 사용
		      	 	
					///////////////////////////////오버레이////////////////////////////////////////
					//오버레이 생성
		      	    var overlay = new kakao.maps.CustomOverlay({
		      	        //yAnchor: 0,
		      	      	clickable: true, //지도 클릭 이벤트 막음
		      	      	position : data.latlng
		      	    });
		      	
		      	 	//오버레이 내용 구성
		      	    var content = document.createElement('div');
		      	  	content.className = 'wrap';
		      	    content.style.cssText = 'background: white; border-radius: 10px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc; box-shadow: 0px 0px 20px #000; height:330px;';
		      	    
		      	  	//오버레이 안의 이미지 구현
		      	    var imageArea = document.createElement('div');
		      	  	imageArea.id = 'carouselControls-img'+data.id;
		      	  	imageArea.className = 'carousel slide';
		      	  	imageArea.style.cssText = 'width: 300px;height: 200px;overflow: hidden; padding:0.5px; border-radius: 10px;' ;
		      	  	content.appendChild(imageArea);
		      	  	
		      		//마커객체에 담아놓았던 이미지 경로 split 하여 경로 배열(arr)에 넣음
		      	  	
		      	  	var carousel = document.createElement('div');
		      	  	carousel.className = 'carousel-inner';
		      	  	imageArea.appendChild(carousel);
		      	  	
		      	  	//img
		      	  	var image = document.createElement('div');
		      	  	image.className = 'carousel-item active';
		      	  	image.innerHTML = '<img src="'+ data.image +'" >';
		      	  	carousel.appendChild(image);
		      	  	
		      	  	//숙소 설명 및 링크 설정
		      	  	var desc = document.createElement('div');
		      	  	desc.className = "desc";
		      	  	desc.style.cssText = "position: relative;height: 90px; width:300px; padding:15px;font-size:18px;";
		      	  	desc.innerHTML =  '<img src="/resources/property_img/starIcon.PNG" style="width:18px; height:18px; margin-bottom:5px;">4.84<br>'
		      	  					  + '<a href="/property/detail?propertyId='+ data.id + '" target="_blank">'
		      	  					  + data.propertyType + '<br>'+ data.title + '<br>' + '</a>';
		      	  	content.appendChild(desc);
		      	    
		      	    overlay.setContent(content);
					
		      	    //마커 클릭 이벤트
		      	    kakao.maps.event.addListener(marker, 'click', function() {
		      	    	
		      	    	//클릭되어있는 기존 마커 over 처리
		      	    	//지금 선택한 마커가 클릭되어있는 기존 마커가 아니고, null 이 아니면
		      	    	if(selectedMarker !== marker && selectedMarker != null){
		      	    		//overlay.setMap(null);
		      	    		selectedMarker.setImage(overMarkerImage);
		      	    	}
		      	    	
		      	    	// 클릭한 마커 이미지 변경
		      	        if (!selectedMarker || selectedMarker !== marker) {
		      	            marker.setImage(selectedMarkerImage);
		      	        }

		      	        // 클릭된 마커를 현재 클릭된 마커 객체로 설정
		      	        selectedMarker = marker;
		      	        
		      	    	//맵에 오버레이 세팅
		      	    	overlay.setMap(map);
		      	    	//오버레이 위치 맞춰서 맵 이동
		      	    	map.setCenter(overlay.getPosition());
		      	    });
		      	    
		      	    //맵 클릭 이벤트
		      	  	kakao.maps.event.addListener(map, 'click', function() {
		      	  		// 클릭된 마커 객체가 null이 아니면
	      	            // 클릭된 마커의 이미지를 조회기록있는 마커이미지로 변경
		      	  		!!selectedMarker && selectedMarker.setImage(overMarkerImage);
		      	  		
		      	  		//오버레이 맵에서 제거
		      	        overlay.setMap(null);
		      	    });
		      	    
		      	}
		      	//마커 범위 재설정
		      	map.setBounds(bounds);
	        })
          </script>
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

