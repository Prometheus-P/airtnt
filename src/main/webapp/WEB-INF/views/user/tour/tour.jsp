<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/top.jsp"%>
<script type="text/javascript">
	var count = 0;
	$(function(){
		
		/* //[planedBookinglist more 버튼]
		$('#moreBtn1').on('click', function(){
			
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
		        		$('#planedBookinglist').append(html);
		           	});
		        },
		        error: function(){
		            alert("simpleWithObject err");
		        }
		    });
		}); */
		
		//[preBookinglist more 버튼]
		$('#moreBtn2').on('click', function(){
			count += 10;
		    var form = {
		            more: count,
		    }
		    
		    $.ajax({
		        url: "/tour",
		        type: "POST",
		        data: form,
		        success: function(data){
		        	console.log(data);
		           	if(data.length<10){
		           		$('#moreBtn2').remove();
		           	}
		           	$(data).each(function(){
		           		html = $('<li style="height: 100px;">' +
						              '<div class="one_third first text-center" style="width: 20%;">' +
						                '<a href="/property/detail?propertyId='+this.property_id+'">' +
						                	'<img src="'+this.path+'" alt="" style="height:100px;"></a>' +
						              '</div>' +
						              '<div class="two_third text-left">' +
						                '<p class="fs-2"><a style="color:black" href="/guest/property-detail?propertyId='+this.property_id+'">'+this.property_name+'</a></p>' +
						                '<p>'+this.type_name+'|'+this.sub_type_name+' '+this.room_type_name+'</p>' +
						                '<p>'+this.property_address+'   |   '+this.total_price+'원   |   '+new Date(this.check_in_date).toISOString().substring(0,10)+' ~ '+new Date(this.check_out_date).toISOString().substring(0,10)+'</p>' +
						              '</div>' +
						            '</li>' +
						           '<hr>'
								);
		        		$('#preBookinglist').append(html);
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
	<div id="pageintro" style="padding-top: 0px; padding-bottom: 100px">
		<div class="bold fl_left" style="font-size: 4vh;">여행</div>
	</div>
	<div class="tabs" style="margin-left: 0px;">
	    <input id="all" type="radio" name="tab_item" checked>
	    <label class="tab_item" for="all">예정된 여행</label>
	    <input id="programming" type="radio" name="tab_item">
	    <label class="tab_item" for="programming">이전 여행	</label>
	    <input id="design" type="radio" name="tab_item">
	    <div class="tab_content" id="all_content" >
		    <c:if test="${empty planedBookinglist}">
		       <h5>다시 여행을 떠나실 준비가 되면 에어티앤티가 도와드리겠습니다.</h5><br>
		        <h1 style="font-size: 300px">AirTnT</h1>
		        <a href="/property/search?addressKey=">
						<button id="test_btn3" style="font-size:20px; padding-left:15px; padding-right:15px;" type="button" class="btn btn-outline-primary">둘러보기</button>
				</a>
		    </c:if>
		    <c:if test="${not empty planedBookinglist}">
		    	<ul id="planedBookinglist" class="nospace clear " style="margin-top: 50px;">
			            <c:forEach var="dto" items="${planedBookinglist}">
			            <li style="height: 100px;">
			              <div class="one_third first text-center" style="width: 20%;">
			                <a href="/property/detail?propertyId=${dto.property_id}">
			                	<img src="${dto.path}" alt="" style="height:100px;"></a>
			              </div>
			              <div class="two_third text-left">
			                <p class="fs-2"><a style="color:black" href="/property/detail?propertyId=${dto.property_id}">${dto.property_name}</a></p>
			                <p>${dto.type_name}/${dto.sub_type_name} ${dto.room_type_name}</p>
			                <p>${dto.property_address}</p>
			                <p>${dto.total_price}원</p>
			                <p>${dto.check_in_date} | ${dto.check_out_date}</p>
			              </div>
			            </li>
			            <hr>
			            </c:forEach>
			          </ul>
			          <!-- <div class="text-center">
			            	<button id="moreBtn1" style="font-size:13px; margin-top:10px; padding-left:8px; padding-right:8px;" type="button" class="btn">더보기</button>
			          </div> -->
		    </c:if>
	    </div>
	    <div class="tab_content" id="programming_content">
		    <c:if test="${empty preBookinglist}">
		        <h5>과거 여행이 없습니다. 하지만 여행을 완료하면 여기에서 확인하실 수 있습니다. </h5><br>
		        <h1 style="font-size: 300px">AirTnT</h1>
		    </c:if>
		    <c:if test="${not empty preBookinglist}">
		    	<ul id="preBookinglist" class="nospace clear " style="margin-top: 50px;">
			            <c:forEach var="dto" items="${preBookinglist}">
			            <li style="height: 100px;">
			              <div class="one_third first text-center" style="width: 20%;">
			                <a href="/property/detail?propertyId=${dto.property_id}">
			                	<img src="${dto.path}" alt="" style="height:100px;"></a>
			              </div>
			              <div class="two_third text-left">
			                <p class="fs-2"><a style="color:black" href="/property/detail?propertyId=${dto.property_id}">${dto.property_name}</a></p>
			                <p>${dto.type_name}    |    ${dto.sub_type_name} ${dto.room_type_name}</p>
			                <p>${dto.property_address}   |   ${dto.total_price}원   |   ${dto.check_in_date} ~ ${dto.check_out_date}</p>
			              </div>
			            </li>
			            <hr>
			            </c:forEach>
			          </ul>
			          <div class="text-center">
			            	<button id="moreBtn2" style="font-size:13px; margin-top:10px; padding-left:8px; padding-right:8px;" type="button" class="btn">더보기</button>
			          </div>
		    </c:if>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/views/bottom.jsp"%> 
