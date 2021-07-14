<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/top.jsp"%>
<div class="hoc container clear ">
	<div class="row">
		<div>
			<span class="bold fl_left" style="font-size: 2vh;">
			<a href="/myPage/profile" style="color: black">프로필 ></a>
			</span> 
			<span	class="bold" style="font-size: 2vh; margin-left: 10px;">비밀번호 변경</span><br>
			<div class="bold fl_left" style="font-size: 4vh;">비밀번호 변경</div>
		</div>
	</div>
	<div class="col-sm-9 bg-light p-3 border">
		<div>
			<form name="edit" action="/myPage/editPassword" method="post">
				<div>
					<div class="mb-3 col-lg">
						    <label for="CurrentPass" class="form-label">현재 비밀번호</label>
						    <input type="password" name="passwd" class="form-control" id="CurrentPass" aria-describedby="passHelp" >
						    <div id="passHelp" class="form-text"><a href="#FindPassModal" data-toggle="modal" data-dismiss="modal" aria-hidden="true">비밀번호를 잊으셨나요?</a></div>
					 </div>
					 <div class="mb-3 col-lg">
						    <label for="NewPass" class="form-label">새 비밀번호</label>
						    <input type="password" name="Npasswd" class="form-control" id="NewPass" aria-describedby="NpassHelp" >
						    <div id="NpassHelp" class="form-text">비밀번호는 영문 대소문자와 숫자 4~20자리로 입력해야합니다</div>
					 </div>
					 <div class="mb-3 col-lg">
						    <label for="ConfirmPass" class="form-label">비밀번호 확인</label>
						    <input type="password" name="Cpasswd" class="form-control" id="ConfirmPass" onchange="samePass()" aria-describedby="NpassHelp2">
						    &nbsp;&nbsp;<span id="same"></span>
						    <div id="NpassHelp2" class="form-text"></div>
					 </div>
				</div>
				<button type="button" class="btn" onclick="PcheckAll()"
					style="background-color: #001a21ad; margin-top: 10px;">비밀번호 변경</button>
			</form>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/bottom.jsp"%>