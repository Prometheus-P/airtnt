<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/top.jsp"%>
<div class="wrapper row3">
  <main class="hoc container clear"> 
    <!-- main body -->
    <!-- ################################################################################################ -->
    <section id="services">
      <div class="sectiontitle" style="max-width:100%">
        <span class="bold " style="font-size: 3vh; margin-right:50vh;">위시리스트</span>
        <span><a class="btn btn-outline-primary" href="#NewWish" role="button" data-toggle="modal">새로운 위시리스트 만들기</a></span>
      </div>
      <ul class="nospace group grid-3">
      	<c:if test="${not empty user_wishlist}">
	      	<c:forEach var="dto" items="${user_wishlist}">
		        <li class="one_third">
		        	<div>
		        		<a href="inWishlist"><img src="<c:url value='/resources/img/main3.jpg'/>"></a>
		        	</div>
		            <footer><span class="bold " style="font-size: 2vh;">예시${dto.wish_name}</span></footer>
		        </li>
			</c:forEach>
		</c:if>
		<c:if test="${empty user_wishlist}">
	      	<c:forEach var="dto" items="${admin_wishlist}">
		        <li class="one_third">
		        	<div>
		        		<a href="inWishlist"><img src="<c:url value='/resources/img/main3.jpg'/>"></a>
		        	</div>
		            <footer><span class="bold " style="font-size: 2vh;">예시${dto.wish_name}</span></footer>
		        </li>
			</c:forEach>
		</c:if>
      </ul>
    </section>
    <!-- ################################################################################################ -->
    <!-- / main body -->
    <div class="clear"></div>
  </main>
</div>
<!-- NewWishModal-->
<div id="NewWish" class="modal fade">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">새로운 위시리스트 만들기</h4>	
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form action="makeWish" method="post">
					<input type="hidden" name="member_id" value="${member_id}">
					<div class="form-group">
							<input type="text" class="form-control" name="wish_name" placeholder="이름" required="required">
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
				<a href="findMember">Forgot Password?</a>
			</div>
		</div>
	</div>
</div> 