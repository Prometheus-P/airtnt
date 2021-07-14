<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/top.jsp"%>
<style>
	.obj {
		object-fit: cover; 
		width: 20vh;
		border-bottom-left-radius: 5px;
		border-bottom-right-radius: 5px;
		border-top-left-radius: 5px;
		border-top-right-radius: 5px;
	}
</style>
<script type="text/javascript">
			function check(){
				var imgFile = $('#isFile').val();
				var fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/;
				var maxSize = 5 * 1024 * 1024;
				var fileSize;
				
				if($('#isFile').val() == "") {
					alert("첨부파일은 필수!");
				    $("#isFile").focus();
				    return;
				}

				if(imgFile != "" && imgFile != null) {
					fileSize = document.getElementById("isFile").files[0].size;
				    
				    if(!imgFile.match(fileForm)) {
				    	alert("이미지 파일만 업로드 가능");
				        return;
				    } else if(fileSize > maxSize) {
				    	alert("파일 사이즈는 5MB까지 가능");
				        return;
				    }
				}
				
				document.update.submit()
			}
			function handleFiles(files) {
				  for (let i = 0; i < files.length; i++) {
				    const file = files[i];

				    if (!file.type.startsWith('image/')){ continue }

				    const img = document.createElement("img");
				    img.classList.add("obj");
				    img.file = file;
				   	$('#preview').empty(); // "preview"의 자식 태그 비우기
				    preview.appendChild(img); // "preview"가 결과를 보여줄 div 출력이라 가정.

				    const reader = new FileReader();
				    reader.onload = (function(aImg) { return function(e) { aImg.src = e.target.result; }; })(img);
				    reader.readAsDataURL(file);
				  }
				}
</script>
<div class="hoc container clear ">
	<div class="row">
		<div>
			<span class="bold fl_left" style="font-size: 2vh;"><a
				href="/myPage/profile" style="color: black">프로필 ></a></span> <span
				class="bold" style="font-size: 2vh; margin-left: 10px;">사진
				업데이트</span><br>
			<div class="bold fl_left" style="font-size: 4vh;">사진 업데이트</div>
		</div>
	</div>
	<div class="col-sm-9 bg-light p-3 border">
		<div>
			<form name="update" action="/myPage/updateMemberImage" method="post"
				enctype="multipart/form-data">
				<input type="hidden" name="member_image"
					value="${memberData.member_image}">
				<div>
					<label for="formFileLg" class="form-label">프로필사진</label> <input
						class="form-control form-control-lg" id="isFile" type="file" accept="image/*"
						name="filename" onchange="handleFiles(this.files)">
				</div>
				<button type="button" class="btn" onclick="check()"
					style="background-color: #001a21ad; margin-top: 10px;">저장</button>
			</form>
		</div>
	</div>
	<div class="col-sm-9 p-3 border">
		<div class="col center">
			<c:if test="${empty memberData.member_image}">
			<div id="preview">
			</div>
				<!-- <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100"
					fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
					<path
						d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z" />
				</svg> -->
			</c:if>
			<c:if test="${not empty memberData.member_image}">
				<div class="text-center">
					<img src="${memberData.member_image}"
						style="object-fit: cover; width: 20vh" class="rounded" alt="...">
					<a
						href="/myPage/updateMemberImage?del=del&member_image=${memberData.member_image}">
						<button type="button" class="btn btn-dark fl_right"
							style="background-color: #001a21ad">삭제</button>
					</a>
				</div>
			</c:if>
		</div>
	</div>
	<div class="col-sm-9 p-3 border">
		<div class="col">
			<p>얼굴이 나온 프로필 사진을 통해서 다른 호스트와 게스트에게 나를 알릴 수 있습니다. 모든 에어티앤티 호스트는
				프로필 사진이 있어야 합니다. 에어티앤티는 게스트에게 프로필 사진을 요청하지 않지만, 호스트는 요청할 수 있습니다.
				호스트가 게스트에게 사진을 요청하는 경우에도, 예약이 확정된 후에만 사진을 볼 수 있습니다.</p>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/bottom.jsp"%>