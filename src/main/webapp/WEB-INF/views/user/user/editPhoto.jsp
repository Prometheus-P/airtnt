<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/top.jsp"%>
<div class="hoc container clear ">
	<div class="row">
		<div>
				<span class="bold fl_left" style="font-size: 2vh;"><a href="/myPage/profile" style="color: black">프로필 ></a></span>
				<span class="bold" style="font-size: 2vh; margin-left: 10px;">사진 업데이트</span><br>
			<div class="bold fl_left" style="font-size: 4vh;">사진 업데이트</div>
		</div>
	</div>
	<div class="col-sm-9 bg-light p-3 border">
			<div>
				<form action="/myPage/updateMemberImage" method="post" enctype="">
					  <div>
					  <label for="formFileLg" class="form-label">프로필사진</label>
					  <input class="form-control form-control-lg" id="formFileLg" type="file" name="member_image">
					</div>
				</form>
			</div>
		</div>
	<div class="col-sm-9 p-3 border">
		<div class="col center">
			<c:if test="${empty memberData.member_image}">
				<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
					<path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
				</svg>
			</c:if>
			<c:if test="${not empty memberData.member_image}">
				<div class="text-center">
					<img src="${memberData.member_image}" class="rounded" alt="...">
					<a href="/myPage/updateMemberImage">
						<button type="button" class="btn btn-dark fl_right" style="background-color: #001a21ad">삭제</button>
					</a>
				</div>
			</c:if>
		</div>
	</div>
	<div class="col-sm-9 p-3 border">
		<div class="col">
			<p>얼굴이 나온 프로필 사진을 통해서 다른 호스트와 게스트에게 나를 알릴 수 있습니다. 모든 에어비앤비 호스트는 프로필 사진이 있어야 합니다. 에어비앤비는 게스트에게 프로필 사진을 요청하지 않지만, 호스트는 요청할 수 있습니다. 호스트가 게스트에게 사진을 요청하는 경우에도, 예약이 확정된 후에만 사진을 볼 수 있습니다.</p>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/bottom.jsp"%>