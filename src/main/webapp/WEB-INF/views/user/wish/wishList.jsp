<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/top.jsp"%>

<div class="hoc container clear ">
	<div>
		<span class="bold fl_left" style="font-size: 3vh; margin-right:50vh;">위시리스트</span>
		<span><a class="btn btn-outline-primary fl_right" href="#NewWish" role="button" data-toggle="modal">새로운 위시리스트 만들기</a></span>
	</div>
  <main> 
    <!-- main body -->
    <!-- ################################################################################################ -->
    <section id="services">
      <div class="sectiontitle" style="max-width:100%"></div>
      <ul class="nospace group grid-3">
      	<c:if test="${not empty user_wishList}">
	      	<c:forEach var="dto" items="${user_wishList}">
		        <li class="one_third">
		        	<div>
		        		<a href="inWishList?wish_id=${dto.wish_id}"><img src="${dto.path}"></a>
		        		<c:if test="${empty dto.path}">
		        		<a href="inWishList?wish_id=${dto.wish_id}"><img src="/resources/img/main2.jpg"></a>
		        		</c:if>
		        	</div>
		            <footer><span class="bold " style="font-size: 2vh;">${dto.name}</span></footer>
		        </li>
			</c:forEach>
		</c:if>
		<c:if test="${empty user_wishList}">
	      	<c:forEach var="dto" items="${admin_wishList}">
		        <li class="one_third">
		        	<div>
		        		<a href="inWishList?wish_id=${dto.wish_id}"><img src="${dto.path}"></a>
		        		<c:if test="${empty dto.path}">
		        		<a href="inWishList?wish_id=${dto.wish_id}"><img src="/resources/img/main2.jpg"></a>
		        		</c:if>
		        	</div>
		            <footer><span class="bold " style="font-size: 2vh;">${dto.name}</span></footer>
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
							<input type="text" class="form-control" name="name" placeholder="이름" required="required">
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
<%@ include file="/WEB-INF/views/bottom.jsp"%> 
