<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/top.jsp"%>
<div class="hoc container clear">
	<div class="row">
		<div>
				<span class="bold fl_left" style="font-size: 2vh;"><a href="/myPage" style="color: black">계정 ></a></span>
				<span class="bold" style="font-size: 2vh; margin-left: 10px;">프로필</span><br>
			<div class="bold fl_left" style="font-size: 4vh;">프로필</div>
		</div>
		<div class="col-3 bg-light p-3">
			<div class="border rounded vw-3 center" style="padding-top:2vh;padding-bottom:2vh">
        			<div class="center">
						<c:if test="${empty memberData.member_image}">
							<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
								<path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
							</svg>
						</c:if>
						<c:if test="${not empty memberData.member_image}">
							<div class="text-center">
							  <img src="${memberData.member_image}" class="rounded" style="object-fit:cover; width:15vh; max-width:80%; margin-bottom:5px" alt="...">
							</div>
						</c:if>
					</div>
        			<div><a href="/myPage/editPhoto" style="color:black">사진 업데이트</a></div>
        	</div>
        	<div class="border rounded vw-3 center" style="padding-top:2vh;padding-bottom:2vh">
        			<div class="center"><svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-key" viewBox="0 0 16 16">
													  <path d="M0 8a4 4 0 0 1 7.465-2H14a.5.5 0 0 1 .354.146l1.5 1.5a.5.5 0 0 1 0 .708l-1.5 1.5a.5.5 0 0 1-.708 0L13 9.207l-.646.647a.5.5 0 0 1-.708 0L11 9.207l-.646.647a.5.5 0 0 1-.708 0L9 9.207l-.646.647A.5.5 0 0 1 8 10h-.535A4 4 0 0 1 0 8zm4-3a3 3 0 1 0 2.712 4.285A.5.5 0 0 1 7.163 9h.63l.853-.854a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.793-.793-1-1h-6.63a.5.5 0 0 1-.451-.285A3 3 0 0 0 4 5z"/>
													  <path d="M4 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
													</svg></div>
        			<div><a href="/myPage/editPassword" style="color:black">비밀번호변경</a></div>
        	</div>
        	<div class="border rounded vw-3 center" style="padding-top:2vh;padding-bottom:2vh">
        		<div><a href="#" style="color:black" onclick="sure('정말 탈퇴하시겠습니까?','/myPage/deleteMember')">회원탈퇴</a></div>
        	</div>
		</div>
		<div class="col-sm-9 bg-light p-3 border">
			<div>
				<form name="profileEdit" action="/myPage/updateMember" method="post" onsubmit="return profileEditCheck()">
					  <div class="mb-3 col-sm-lg">
						    <label for="InputName" class="form-label">이름</label>
						    <input type="text" name="name" class="form-control" id="Pname" value="${memberData.name}" onchange="checkChange()">
					  </div>
					  <div class="mb-3 col-lg">
						    <label for="InputBirth" class="form-label">생년월일</label>
						    <input type="text" name="birth" class="form-control" id="Pbirth" value="${memberData.birth}" onchange="checkChange()" aria-describedby="birthHelp" >
						    <div id="birthHelp" class="form-text">2000/00/00</div>
					  </div>
					  <div class="mb-3 col-lg">
						    <label for="InputTel" class="form-label">핸드폰번호</label>
						    <input type="text" name="Tel" class="form-control" id="Ptel" value="${memberData.tel}" onchange="checkChange()" aria-describedby="TelHelp">
						    <div id="TelHelp" class="form-text">010-xxxx-xxxx</div>
					  </div>
					  <div class="mb-3 col-lg">
					  		<label for="InputEmail" class="form-label">이메일</label>
						    <input type="text" name="email" class="form-control" id="Pemail" value="${memberData.email}" onchange="checkChange()" aria-describedby="EmailHelp" >
						    <div id="EmailHelp" class="form-text">xxxxx@xxxxx.xxx</div>
					  </div>
					  <div class="mb-3 col-lg">
							<label for="inputState" class="form-label">성별</label>
							    <select id="inputState" class="form-select form-select-lg" name="gender" onchange="checkChange()">
							      <c:if test="${memberData.gender eq 1}">
							      	<option selected value="1">남성</option>
							      	<option value="2">여성</option>
							      </c:if>
							      <c:if test="${memberData.gender eq 2}">
							      	<option selected value="2">여성</option>
							      	 <option value="1">남성</option>
							      </c:if>
							    </select>
						</div>
					  <button id="sButton" style="margin-top:10px" type="button" class="btn btn-primary">Submit</button>
				</form>
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/bottom.jsp"%>