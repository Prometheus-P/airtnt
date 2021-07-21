<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/top.jsp"%>
<script>
	function transferData(property_id,booking_id){
	$('#property_id').val(property_id)
	$('#booking_id').val(booking_id)
	
	}
	function transferDataForUpdate(id,rating,content){
		console.log(id);
		console.log(rating);
		console.log(content);
		$('#review_id').val(id)
		$('#update_rating').val(rating)
		$('#update_content').html(content)
		//$('#star2').data('score', rating)
		$('#star2').attr('data-score', rating)
		}
	$(function() {
		var count = 0;
		var starCnt = 0;
		var dataCnt =0;
		var id ="";
		var content ="";
		
        $('div#star').raty({
            score: 5
            ,path : "/resources/images"
            ,width : 200
            ,click: function(score, evt) {
                $("#review_rating").val(score);
            }
        });
		
        $('div#star2').raty({
            score: function() {
                return 2 * 2;
            }
            ,path : "/resources/images"
            ,width : 200
            ,click: function(score, evt) {
                $("#update_rating").val(score);
            }
        });
        
      //[myReviews more 버튼]
		$('#moreBtn2').on('click', function(){
			count += 10;
		    var form = {
		            more: count,
		    }
		    
		    $.ajax({
		        url: "/myPage/review",
		        type: "POST",
		        data: form,
		        success: function(data){
		        	console.log(data);
		           	if(data.length<10){
		           		$('#moreBtn2').remove();
		           	}
		           	$(data).each(function(){
		           		rating = this.rating;
		           		id = this.id;
		           		content = this.content
		           		
		           		dataCnt +=1;
		           		console.log(data.length);
		           		
		           		html = $('<li>' +
							              '<div class="one_third first text-center" style="width: 10%;">' +
							                '<a href="/property/detail?propertyId='+this.property_id+'">' +
							                	'<img src="'+this.path+'" alt="" style="height:70px; margin-bottom:5px"></a>' +
							              '</div>' +
							              '<div class="one_third text-left">' +
							                '<p class="fs-2"><a style="color:black" href="/property/detail?propertyId='+this.property_id+'">'+this.property_name+'</a></p>' +
							                '<p>'+this.property_address+'   /   '+this.price+'원   /   '+new Date(this.check_in_date).toISOString().substring(0,10)+' | '+new Date(this.check_out_date).toISOString().substring(0,10)+'</p>' +
							              '</div>' +
							              '<div class="one_third fl_right">' +
							              //여기 수정해야함
							              		'<button id="delete'+dataCnt+'" ' +
									                'type="button" class="close">&times;</button>' +
							              '</div>' +
							              '<hr style="color: #00000061;">' +
							              '<div class="two_third first text-left">' +
								             '<p id="stars'+dataCnt+'"></p>' +
							              	'<p>'+this.content+'</p>' +
							              '</div>' +
							              '<div class="one_third fl_right">' +
							              //여기 수정 해야함 
								              '<button id="update'+dataCnt+'" data-target="#updateReviewModal" ' + 
								              		'data-toggle="modal" style="font-size:12px;" type="button" class="btn">수정하기</button>' +
							              '</div><br>' +
							            '</li>' +
						           '<hr>'
								);
		        		$('#myReviews').append(html);
		        		
		        		$("button#delete"+dataCnt).on("click", function(){
		        			sure('정말 삭제하시겠습니까?','/myPage/deleteReview?id='+id);
		        		});
		        		
		        		$("button#update"+dataCnt).on("click", function(){
		        			transferDataForUpdate(id, rating, content);
		        		});
		        		
		        		/* var obj1 = document.createElement('button');
		        		obj1.setAttribute('onclick',"'sure('정말 삭제하시겠습니까?','/myPage/deleteReview?id='+this.id+')'");
		        		obj1.setAttribute('type','button');
		        		obj1.setAttribute('class','close');
		        		obj1.setAttribute('class','close');
		        		obj1.setAttribute('class','close');
		        		obj1.setAttribute('class','close');
		        		$("#delete'+dataCnt+'").append(obj1); */
		        		
		        		for(var i=0; i<rating; i++){
		                       html = '<span><img src="/resources/images/star-on.png" alt=""></span>';
		                       $('#stars'+dataCnt+'').append(html);
		                    }
		        		
		        		
	        				
		           	});
		        },
		        error: function(){
		            alert("simpleWithObject err");
		        }
		    });
		});
    });
</script>
<div class="hoc container clear" style="margin-left: 4vh;">
	<div class="row">
		<div>
			<span class="bold fl_left" style="font-size: 2vh;">
			<a href="/myPage" style="color: black">계정 ></a>
			</span> 
			<span	class="bold" style="font-size: 2vh; margin-left: 10px; ">후기</span><br>
			<div class="bold fl_left" style="font-size: 4vh;">후기</div><br><br><br>
			<div class="fl_left " style="font-size: 13px;">최근 1년간 여행한 숙소에 한해 작성 가능</div>
		</div>
	</div>
	<div class="tabs" style="margin-left: 0px; margin-top:10px;">
	    <input id="all" type="radio" name="tab_item" checked>
	    <label class="tab_item" for="all">작성할 리뷰</label>
	    <input id="programming" type="radio" name="tab_item">
	    <label class="tab_item" for="programming">작성한 리뷰</label>
	    <input id="design" type="radio" name="tab_item">
	    <div class="tab_content" id="all_content">
		    <c:if test="${empty toWriteReviews}">
		       <h5>작성하실 리뷰가 없습니다</h5><br>
		        <h1 style="font-size: 300px">AirTnT</h1>
		        <a href="/property/search?addressKey=">
						<button id="test_btn3" style="font-size:40px; padding-left:15px; padding-right:15px;" type="button" class="btn btn-outline-primary">둘러보기</button>
				</a>
		    </c:if>
		    <c:if test="${not empty toWriteReviews}">
		    	<ul class="nospace clear " style="margin-top: 50px;">
			            <c:forEach var="dto" items="${toWriteReviews}">
			            <li style="height:100px;">
			              <div class="one_third first text-center" style="width: 20%;">
			                <a href="/property/detail?propertyId=${dto.property_id}">
			                	<img src="${dto.path}" alt="" style="height:100px;"></a>
			              </div>
			              <div class="one_third text-left">
			                <p class="fs-2"><a style="color:black" href="/property/detail?propertyId=${dto.property_id}">${dto.property_name}</a></p>
			                <p>${dto.type_name}/${dto.sub_type_name} ${dto.room_type_name}</p>
			                <p>${dto.property_address}</p>
			                <p>${dto.total_price}원   /   ${dto.check_in_date} | ${dto.check_out_date}</p>
			              </div>
			              <div class="one_third text-right">
			              	<button data-target="#ReviewModal" onclick="transferData(${dto.property_id},${dto.id})" data-toggle="modal" id="test_btn3" style="font-size:20px;" type="button" class="btn btn-outline-primary">리뷰작성하기</button>
			              </div>
			            </li>
			            <hr>
			            </c:forEach>
			          </ul>
		    </c:if>
	    </div>
	    <div class="tab_content" id="programming_content">
		    <c:if test="${empty myReviews}">
		        <h5>작성하신 리뷰가 없습니다.</h5><br>
		        <h1 style="font-size: 400px">AirTnT</h1>
		    </c:if>
		    <c:if test="${not empty myReviews}">
		    	<ul id="myReviews" class="nospace clear " style="margin-top: 50px;">
			            <c:forEach var="dto" items="${myReviews}">
			            <li>
			              <hr>
			              <div class="one_third first text-center" style="width: 10%;">
			                <a href="/property/detail?propertyId=${dto.property_id}">
			                	<img src="${dto.path}" alt="" style="height:70px; margin-bottom:5px"></a>
			              </div>
			              <div class="one_third text-left">
			                <p class="fs-2"><a style="color:black" href="/property/detail?propertyId=${dto.property_id}">${dto.property_name}</a></p>
			                <p>${dto.property_address}   |   ${dto.price}원   |   ${dto.check_in_date} ~ ${dto.check_out_date}</p>
			              </div>
			              <div class="one_third fl_right">
			                <button onclick="sure('정말 삭제하시겠습니까?','/myPage/deleteReview?id=${dto.id}')" 
			                type="button" class="close">&times;</button>
			              </div>
			              <hr style="color: #00000061;">
			              <div class="two_third first text-left">
			              	<p><c:forEach begin="1" end="${dto.rating}">
			              		<span><img src="/resources/images/star-on.png" alt=""></span>
			              	</c:forEach></p>
			              	<p>${dto.content}</p>
			              </div>
			              <div class="one_third fl_right">
			              	<button data-target="#updateReviewModal" onclick="transferDataForUpdate('${dto.id}','${dto.rating}','${dto.content}')"
											data-toggle="modal" style="font-size:12px;" type="button" class="btn">수정하기</button>
			              </div><br>
			            </li>
			            </c:forEach>
			            <hr>
			          </ul>
			          <div class="text-center">
			            	<button id="moreBtn2" style="font-size:13px; margin-top:10px; padding-left:8px; padding-right:8px;" type="button" class="btn">더보기</button>
			          </div>
		    </c:if>
		</div>
	</div>
</div>

<!-- ReviewModal-->
<div id="ReviewModal" class="modal fade">
	<div class="modal-dialog modal-login ">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">리뷰 작성</h4>	
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form name="writeReview" action="/myPage/writeReview" method="post" onsubmit="return writeReviewCheck()">
					<input type="hidden" name="property_id" id="property_id" value=""/>
					<input type="hidden" name="booking_id" id="booking_id" value=""/>
					<div class="form-group mb-3 col-sm-lg">
						    <label for="InputRating" class="form-label">별점</label>
						    <div id="star"></div>
						    <input type="hidden" name="rating" class="form-control" id="review_rating" value="5">
					</div>
					<div class="form-group mb-3 col-sm-lg">
						    <label for="InputContent" class="form-label">내용</label>
						    <textarea name="content" class="form-control" id="review_content" rows="10" cols="58"></textarea>
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-primary btn-lg btn-block login-btn" style="font-size: 15px">전송</button>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<p></p>
			</div>
		</div>
	</div>
</div>  
<!-- updateReviewModal-->
<div id="updateReviewModal" class="modal fade">
	<div class="modal-dialog modal-login ">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">리뷰 수정</h4>	
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form name="updateReview" action="/myPage/updateReview" method="post" onsubmit="return updateReviewCheck()">
					<input type="hidden" name="id" id="review_id" value=""/>
					<div class="form-group mb-3 col-sm-lg">
						    <label for="" class="form-label">별점</label>
						    <div id="star2" data-score=""></div>
						    <input type="hidden" name="rating" class="form-control" id="update_rating" value="">
					</div>
					<div class="form-group mb-3 col-sm-lg">
						    <label for="" class="form-label">내용</label>
						    <textarea name="content" class="form-control" id="update_content" rows="10" cols="58" ></textarea>
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-primary btn-lg btn-block login-btn" style="font-size: 15px">전송</button>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<p></p>
			</div>
		</div>
	</div>
</div>  
<%@ include file="/WEB-INF/views/bottom.jsp"%>