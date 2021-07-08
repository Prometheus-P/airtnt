<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
<title>숙소 사진 등록</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
</head>
<body>
<%@include file='../../top.jsp' %>
<div class="container">
	<div class="page-header" style="font-style: italic; font-family: fantasy;">
			<h1 style="font-weight: bold;">
				이제 숙소 사진을 올릴 차례입니다</h1>
		</div>

		<form name="dataForm" id="dataForm" onsubmit="return registerAction()">
			<div class="data_file_txt" id="data_file_txt" style="margin: 40px;">
				<h3>첨부 파일</h3>
				<div class="row">
  					<div class="col-xs-6 col-md-3">
  					<div class="grid">
  						<div id="image_container"></div>
  						<!-- <div class="grid-item grid-item--width2">...</div>
  						<div class="grid-item">...</div>
 							 ... -->
					</div>
    					<div id="articlefileChange" style="font-family: fantasy;"></div>
  					</div>
				
					<div class="col-md-6">
						<button id="btn-upload" type="button" class="btn btn-sm btn-primary" 
						style="font-size: 17px">사진 추가 하기</button>
						<input id="input_file" multiple="multiple" type="file"  onchange="setImg(event)" style="display: none;">
						<span style="font-size: 10px; color: gray;">  
							 ※숙소 사진은 최대 10개까지 등록이 가능합니다.
						</span>
			
					</div>
				</div>
			<div class="col-md-6">
				<button type="submit" class="btn btn-lg btn-success" style="font-weight: bold; font-style: italic;">
				전송</button>
			</div>
			</div>
		</form>
		</div>
	


	<!-- 파일 업로드 스크립트 -->
	<script>
	// 파일 현재 필드 숫자 totalCount랑 비교값
	var fileCount = 0;
	// 해당 숫자를 수정하여 전체 업로드 갯수를 정한다.
	var totalCount = 10;
	// 파일 고유넘버
	var fileNum = 0;
	// 첨부파일 배열
	var content_files = new Array();

	$(document).ready(function()
			// input file 파일 첨부시 fileCheck 함수 실행
			{
				$("#input_file").on("change", fileCheck);
			});

	/**
	 * 첨부파일로직
	 */
	$(function () {
	    $('#btn-upload').click(function (e) {
	        e.preventDefault();
	       /*  $('#articlefileChange').append(
	       		'<div id="image_container'+fileNum+'" >'+'</div>'
	        ) */
	        $('#input_file').click();
	    });
	});

	function fileCheck(e) {
	    var files = e.target.files;
	    
	    // 파일 배열 담기
	    var filesArr = Array.prototype.slice.call(files);
	    
	    // 파일 개수 확인 및 제한
	    if (fileCount + filesArr.length > totalCount) {
	      $.alert('파일은 최대 '+totalCount+'개까지 업로드 할 수 있습니다.');
	      return;
	    } else {
	    	 fileCount = fileCount + filesArr.length;
	    }
	    
	    // 각각의 파일 배열담기 및 기타
	    filesArr.forEach(function (f) {
	      var reader = new FileReader();
	      reader.onload = function (e) {
	        content_files.push(f);
	        $('#articlefileChange').append(
	       		'<div id="file' + fileNum + '" onclick="fileDelete(\'file' + fileNum + '\')">'
	       		+ '<font style="font-size:14px">' + f.name + '</font>'  
	       		+ '<img src="/img/icon_minus.png" style="width:20px; height:auto; vertical-align: middle; cursor: pointer;"/>' 
	       		+ '</div>'
			);
	        fileNum ++;
	      };
	      reader.readAsDataURL(f);
	    });
	    console.log(content_files);
	    //초기화 한다.
	    $("#input_file").val("");
	  }

	// 파일 부분 삭제 함수
	function fileDelete(fileNum){
	    var no = fileNum.replace(/[^0-9]/g, "");
	    content_files[no].is_delete = true;
		$('#' + fileNum).remove();
		fileCount --;
	    console.log(content_files);
	}

	/*
	 * 폼 submit 로직
	 */
		function registerAction(){
			
		var form = $("form")[0];        
	 	var formData = new FormData(form);
			for (var x = 0; x < content_files.length; x++) {
				// 삭제 안한것만 담아 준다. 
				if(!content_files[x].is_delete){
					 formData.append("article_file", content_files[x]);
				}
			}
	   /*
	   * 파일업로드 multiple ajax처리
	   */    
			$.ajax({
				type : "POST",
				enctype : "multipart/form-data",
				url : "/host/image-upload",
				data : formData,
				processData : false,
				contentType : false,
				success : function(data) {
					if (JSON.parse(data)['result'] == "OK") {
						alert("사진업로드 성공");
					} else if (JSON.parse(data)['result'] == "NO_IMAGE") {
						alert("한장 이상의 사진을 등록해주세요!");
				} else if (JSON.parse(data)['result'] == "UNACCEPTED_EXTENSION") {
						alert("사진의 확장자는 JPG, PNG, GIF, BMP만 가능합니다!");
					} else if (JSON.parse(data)['result'] == "EXCEED_SIZE") {
						alert("사진의 크기가 너무 큽니다!(총 500MB)");
					} else
						alert("서버내 오류로 처리가 지연되고있습니다. 잠시 후 다시 시도해주세요");
				},
				error : function(xhr, status, error) {
					alert("서버오류로 지연되고있습니다. 잠시 후 다시 시도해주시기 바랍니다.");
					return false;
					}
				});
			return false;

		}
	
	
		function setImg(event) {
		      for (var file of event.target.files) {
		         var reader = new FileReader();
		         reader.onload = function(event) {
		            var filesystemName = file.name.split(".");
		            if(filesystemName.length > 1) {
		               var extension = filesystemName[filesystemName.length - 1];
		              /*  document.querySelector("div#image_container").innerHTML = "";  // 앞서 선택한 이미지 삭제 */
		               if(extension == "jpg" || extension == "png" || extension == "bmp" || extension == "gif") {
		                  var img = document.createElement("img");
		                  img.setAttribute("src", event.target.result);
		                 
		                  document.querySelector("div#image_container").appendChild(
		                		  <div class="thumbnail">img</div>);
		                 
		                		 
							//새로 선택한 이미지 div에 출력
		               }
		            }
		         }
		         console.log(file);
		         reader.readAsDataURL(file);
		      }
		   }

	</script>
</body>
</html>