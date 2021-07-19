/**
 * 카카오 주소 검색
 */

var locationArray;

var autoCompleteArea;

var searchInput;
var tempSeacrhInput;

var latitudeInput
var longitudeInput;

var mouseEnteredTag;

$(function(){
	autoCompleteArea = document.querySelector("ul#auto-complete-area");
	
	searchInput = document.querySelector("input#search");
	tempSearchInput = document.querySelector("input#temp-search");
	
	latitudeInput = document.querySelector("input#latitude");
	longitudeInput = document.querySelector("input#longitude");
	
	// oninput 이벤트시 실행 함수
	// isShow : oninput때는 dropdown을 열고 onblur때는 dropdown을 열지않는 판별값
	function updateAddress(inputTag, isShow){
		var keyword = inputTag.value;
		if(keyword == ""){
			initLocalTags();
			return;
		}
		
		$.ajax("https://dapi.kakao.com/v2/local/search/address.json", {
			type : "get",
			headers : {
				"Authorization" : "KakaoAK 1910e41ac4fcc8d62b6132a0758dab1c"
			},
			data : {
				"query" : keyword
			}
		})
		.done(function(response){
			
			autoCompleteArea.innerHTML = "";
			//console.log(response);
			var meta = response.meta;
			//console.log(meta);
			locationArray = response.documents;
			
			if(locationArray.length == 0){
				// 카카오에서 넘어온 주소가 없는 상황.
				// backspace로 지워서 없을수도 있기 때문에
				// 기존에 저장되어있던 변수들도 초기화해야한다.
				initLocalTags();
				
			} else {
				// 카카오에서 넘어온 주소가 있는 상황
				var location;
				var addressName;
				var latitude
				var longitude;
				
				console.log("--------------검색값---------------");
				for(var i = 0; i < locationArray.length; i++){
					location = locationArray[i];
					
					addressName = getAddressName(location);
					
					latitude = location.address.y; // 위도가 y
					longitude = location.address.x; // 경도가 x
					
					if(i == 0){
						// 자동완성 주소를 클릭하지 않아도 전체 주소명이 넘어갈 수 있는 hidden input
						tempSearchInput.value = addressName;
						// 자동완성 주소를 클릭하지 않아도 첫번째 주소의 좌표값은 저장함
						latitudeInput.value =  latitude;
						longitudeInput.value =  longitude;
					}
					
					var liTag = document.createElement("li");
					liTag.setAttribute("class", "list-group-item");
					var aTag = document.createElement("a");
					aTag.setAttribute("class", "dropdown-item");
					aTag.setAttribute("type", "button");
					aTag.setAttribute("id", "address-" + i);
					
					// 생겼다 없어졌다 하는 태그이므로 생성될 때 바로 이벤트를 부여해야 함
					// blur 이벤트가 클릭 이벤트보다 빠르므로
					// 마우스가 올라갔을때 태그 자기 자신을 저장하는 이벤트가 필요
					
					$(aTag).click(function(){
						setAddress(this);
					}).on("mouseenter", function(){
						mouseEnteredTag = this;
					}).on("mouseleave", function(){
						mouseEnteredTag = null;
					});
					
					aTag.innerHTML = addressName;
					autoCompleteArea.append(liTag);
					liTag.append(aTag);
					
					console.log(addressName);
					console.log("(" + latitude + "," + longitude + ")");
				}
				console.log("-----------------------------------");
				
				if(isShow){
					$(autoCompleteArea).addClass("show");
				}
			} // end of if-else
		})
		.fail(function(){
			initLocalTags();
			console.log("외않되..");
		});
		// end of oninput function
	}
	
	// 검색창에 이벤트 부여
	$(searchInput).on("keyup", function(){
		// 키보드를 눌렀다 손을 뗐을 때 실행
		updateAddress(this, true);
	}).on("click", function(){
		// input 태그 클릭시 커서 생기면 드롭다운 보이기
		updateAddress(this, true);
	}).on("blur", function(){
		// input 태그 밖의 이벤트 발생 시
		// 마우스가 있는 위치가 추천 검색어 태그이면 클릭부터 실행
		if(mouseEnteredTag != null){
			mouseEnteredTag.click();
			updateAddress(this, false);
		}
		$(autoCompleteArea).removeClass("show");
	});
	
});

function initLocalTags(){
	$(autoCompleteArea).removeClass("show");
	locationArray = null;
	tempSearchInput.value = "";
	latitudeInput.value = "";
	longitudeInput.value = "";
}

function setLocalTagsOnSubmit(){
	if(tempSearchInput.value == "" || tempSearchInput.value == searchInput.value){
		tempSearchInput.disabled = true;
	}
	if(latitudeInput.value == "" || longitudeInput.value == ""){
		latitudeInput.disabled = true;
		longitudeInput.disabled = true;
	}
}

function setAddress(aTag){
	var index = aTag.id.split('-')[1];
	// 저장되어있던 locationArray에서 값을 가져옴
	var location = locationArray[index];
	
	// 추천 검색어를 클릭하면 searchInput의 값을 세팅함
	searchInput.value = getAddressName(location);
	
	latitudeInput.value = location.address.y; // 위도가 y
	longitudeInput.value = location.address.x; // 경도가 x
	
	console.log(addressName);
	console.log("(" + latitudeInput.value + "," + longitudeInput.value + ")");
}

function getAddressName(location){
	var si = location.address.region_1depth_name; // 시
	var gu = location.address.region_2depth_name; // 군/구
	var dong = location.address.region_3depth_name; // 동/읍/리
	if(dong == ""){
		dong = location.address.region_3depth_h_name; // 행정동명
	}
	
	addressName = si;
	if(gu != ""){
		addressName += " " + gu;
	}
	if(dong != ""){
		addressName += " " + dong;
	}
	
	return addressName;
}
