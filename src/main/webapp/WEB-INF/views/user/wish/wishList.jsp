<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/top.jsp"%>

<div class="hoc container clear">
	<div>
		<span class="bold fl_left" style="font-size: 4vh; margin-right:50vh;">위시리스트</span>
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
		        	<div class="text-center">
		        		<c:if test="${not empty dto.path}">
		        			<a href="inWishList?wish_id=${dto.wish_id}&wish_name=${dto.name}"><img src="${dto.path}" style="object-fit:contain; width:300px; height:200px;"></a>
		        		</c:if>
		        		<c:if test="${empty dto.path}">
		        		<a href="inWishList?wish_id=${dto.wish_id}&wish_name=${dto.name}" style="color:black">
		        			<svg xmlns="http://www.w3.org/2000/svg" width="200" height="150" fill="currentColor" class="bi bi-house" viewBox="0 0 16 16">
							  <path fill-rule="evenodd" d="M2 13.5V7h1v6.5a.5.5 0 0 0 .5.5h9a.5.5 0 0 0 .5-.5V7h1v6.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5zm11-11V6l-2-2V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5z"/>
							  <path fill-rule="evenodd" d="M7.293 1.5a1 1 0 0 1 1.414 0l6.647 6.646a.5.5 0 0 1-.708.708L8 2.207 1.354 8.854a.5.5 0 1 1-.708-.708L7.293 1.5z"/>
							</svg></a>
		        		</c:if>
		        	</div>
		            <footer class="text-center"><span class="bold " style="font-size: 2vh;">${dto.name}</span></footer>
		        </li>
			</c:forEach>
		</c:if>
		<c:if test="${empty user_wishList}">
	      	<c:forEach var="dto" items="${admin_wishList}">
		        <li class="one_third">
		        	<div class="text-center">
			        	<c:if test="${not empty dto.path}">
		        			<a href="inWishList?wish_id=${dto.wish_id}&wish_name=${dto.name}"><img src="${dto.path}" style="object-fit:contain; width:300px; height:200px;"></a>
		        		</c:if>
		        		<c:if test="${empty dto.path}">
			        		<a href="inWishList?wish_id=${dto.wish_id}&wish_name=${dto.name}" style="color:black">
			        		<svg xmlns="http://www.w3.org/2000/svg" width="200" height="150" fill="currentColor" class="bi bi-house" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M2 13.5V7h1v6.5a.5.5 0 0 0 .5.5h9a.5.5 0 0 0 .5-.5V7h1v6.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5zm11-11V6l-2-2V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5z"/>
								  <path fill-rule="evenodd" d="M7.293 1.5a1 1 0 0 1 1.414 0l6.647 6.646a.5.5 0 0 1-.708.708L8 2.207 1.354 8.854a.5.5 0 1 1-.708-.708L7.293 1.5z"/>
								</svg></a>
		        		</c:if>
		        	</div>
		            <footer class="text-center"><span class="bold " style="font-size: 2vh;">${dto.name}</span></footer>
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
				<a href="findMember"></a>
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/bottom.jsp"%> 
