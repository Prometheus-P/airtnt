/**
 * property list 페이지에 스크립트가 너무 많아져서 따로 옮김
 */


// 카카오 주소 검색
var locationArray = new Array();

var autoCompleteArea;

var searchInput, tempSeacrhInput;
var searchDropButton;

var latitudeInput, longitudeInput;

var mouseEnteredTag;

$(function(){
	autoCompleteArea = document.querySelector("ul#auto-complete-area");
	
	searchInput = document.querySelector("input#search");
	tempSearchInput = document.querySelector("input#temp-search");
	searchDropButton = document.querySelector("button#search-drop-button");
	
	latitudeInput = document.querySelector("input#latitude");
	longitudeInput = document.querySelector("input#longitude");
	
	$("input#search").on("input", function(){
		var keyword = this.value;
		if(keyword == ""){
			return;
		}
		$.ajax("https://dapi.kakao.com/v2/local/search/address.json", {
			type : "get",
			contentType : "text/plain",
			headers : {
				Authorization : "KakaoAK 1910e41ac4fcc8d62b6132a0758dab1c"
			},
			data : {
				query : keyword
			}
		})
		.done(function(response){
			
			autoCompleteArea.innerHTML = "";
			//console.log(response);
			var meta = response.meta;
			//console.log(meta);
			locationArray = response.documents;
			if(locationArray.length == 0){
				$(autoCompleteArea).removeClass("show");
			} else {
				$(autoCompleteArea).addClass("show");
				
				var si, gu, dong;
				var addressName;
				var latitude, longitude;
				console.log("--------------검색값---------------");
				for(var i = 0; i < locationArray.length; i++){
					var location = locationArray[i];
					
					addressName = getAddressName(location);
					
					latitude = location.address.y; // 위도가 y
					longitude = location.address.x; // 경도가 x
					
					if(i == 0){
						// 자동완성 주소를 클릭하지 않아도 전체 주소명이 넘어갈 수 있는 hidden input
						tempSearchInput.value = addressName;
						// 자동완성 주소를 클릭하지 않아도 첫번째 주소의 좌표값은 저장함
						latitudeInput.value = latitude;
						longitudeInput.value = longitude;
					}
					
					var liTag = document.createElement("li");
					liTag.setAttribute("class", "list-group-item");
					var aTag = document.createElement("a");
					aTag.setAttribute("href", "#");
					aTag.setAttribute("class", "dropdown-item");
					aTag.setAttribute("id", "address-" + i);
					
					// 생겼다 없어졌다 하는 태그이므로 생성될 때 바로 이벤트를 부여해야 함
					// blur 이벤트가 클릭 이벤트보다 빠르므로
					// 마우스가 올라갔을때 태그 자기 자신을 저장하는 이벤트가 필요
					$(aTag).click(function(){
						setAddress(this);
					}).on("mouseenter", function(){
						mouseEnteredTag = this;
					}).on("mouseleave", function(){
						mouseEnteredTag = null
					});
					
					aTag.innerHTML = addressName;
					liTag.append(aTag);
					autoCompleteArea.append(liTag);
					
					console.log(addressName);
					console.log("(" + latitude + "," + longitude + ")");
				}
				console.log("-----------------------------------");
			} // end of if-else
		})
		.fail(function(){
			console.log("외않되..");
		});
		
		// end of oninput function
		
	}).on("focus", function(){
		// input 태그 클릭시 커서 생기면 드롭다운 보이기
		if(locationArray != null && locationArray.length > 0){
			$(autoCompleteArea).addClass("show");
		}
	}).on("blur", function(){
		// input 태그 밖의 이벤트 발생 시
		// 마우스가 있었던 태그가 드롭다운이면 클릭부터 실행
		if(mouseEnteredTag != null){
			mouseEnteredTag.click();
		}
		$(autoCompleteArea).removeClass("show");
	});
});

function setAddress(addressTag){
	var index = addressTag.id.split('-')[1];
	var location = locationArray[index];
	var si, gu, dong;
	var addressName;
	var latitude, longitude;
	
	addressName = getAddressName(location);
	
	latitude = location.address.y; // 위도가 y
	longitude = location.address.x; // 경도가 x
	
	searchInput.value = addressName;
	tempSearchInput.value = "";
	
	latitudeInput.value = latitude;
	longitudeInput.value = longitude;
	
	$(autoCompleteArea).removeClass("show");
	
	console.log(addressName);
	console.log("(" + latitude + "," + longitude + ")");
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

// 폼 파라미터들 검사
function setParametersOnSubmit(){
	var numberArray = [
		document.querySelector("input#guest-count"),
		document.querySelector("input#bed-count"),
		document.querySelector("input#min-price"),
		document.querySelector("input#max-price")
	]
	
	for(var i = 0; i < numberArray.length; i++){
		var numberTag = numberArray[i];
		if(numberTag.value == 0){
			numberTag.value = "";
			numberTag.disabled = true;
		}
	}
}

// 페이지 처리
function movePage(pageButton){
	var pageNum = pageButton.id.split('-')[1];
	document.querySelector("input#page-num").value = pageNum;
	setParametersOnSubmit();
	document.querySelector("form#search-form").submit();
}

// 이하 필터 처리부분
function modSubPropertyTypes(propertyTypeTag){
	var subPropertyTypeTagArray = document.getElementsByName("subPropertyTypeId");
	for(var i = 0; i < subPropertyTypeTagArray.length; i++){
		var subPropertyTypeTag = subPropertyTypeTagArray[i];
		if(subPropertyTypeTag.id.split('-')[1] == propertyTypeTag.value){
			if(propertyTypeTag.checked) {
				subPropertyTypeTag.disabled = true;
			} else {
				subPropertyTypeTag.disabled = false;
			}
		}
	}
}

function changeCount(button){
	var idValueArray = button.id.split('-');
	var operation = idValueArray[0];
	var element = idValueArray[1];
	
	var countTag = document.querySelector("input#" + element + "-count");
	switch(operation){
	case "increase":
		if(countTag.value == ""){
			countTag.value = 1;
		} else {
			countTag.value++;
		}
		break;
	case "decrease":
		if(countTag.value != ""){
			if(countTag.value <= 1){
				countTag.value = "";
			} else {
				countTag.value--;
			}
		}
		break;
	}
}

function modMinMaxPrice(priceTag){
	var minPriceTag, maxPriceTag;
	switch(priceTag.id){
	case "min-price":
		minPriceTag = priceTag; // event source
		maxPriceTag = document.querySelector("input#max-price");
		var minPrice = parseInt(minPriceTag.value);
		var maxPrice;
		if(maxPriceTag.value != ""){
			maxPrice = parseInt(maxPriceTag.value);
			if(minPrice > maxPrice){
				maxPriceTag.value = minPrice + 10000;
			}
		}
		break;
	case "max-price":
		minPriceTag = document.querySelector("input#min-price");
		maxPriceTag = priceTag; // event source
		var minPrice;
		var maxPrice = parseInt(maxPriceTag.value);
		if(minPriceTag.value != ""){
			minPrice = parseInt(minPriceTag.value);
			if(minPrice > maxPrice){
				minPrice = maxPrice - 10000;
				if(minPrice < 10000){
					minPrice = 10000;
				}
			}
			minPriceTag.value = minPrice;
		}
		break;
	}
}

function modUnderPrice(priceTag){
	if(parseInt(priceTag.value) < 10000){
		priceTag.value = 10000;
	}
}

function resetTags(tagName){
	var tagArray;
	switch(tagName){
	case "propertyTypes":
		tagArray = document.getElementsByName("propertyTypeId");
		for(var i = 0; i < tagArray.length; i++){
			tagArray[i].checked = false;
		}
		tagArray = document.getElementsByName("subPropertyTypeId");
		for(var i = 0; i < tagArray.length; i++){
			tagArray[i].checked = false;
			tagArray[i].disabled = false;
		}
		break;
	case "roomTypes":
		tagArray = document.getElementsByName("roomTypeId");
		for(var i = 0; i < tagArray.length; i++){
			tagArray[i].checked = false;
		}
		break;
	case "amenityTypes":
		tagArray = document.getElementsByName("amenityTypeId");
		for(var i = 0; i < tagArray.length; i++){
			tagArray[i].checked = false;
		}
		break;
	case "etc":
		document.querySelector("input#guest-count").value = "";
		document.querySelector("input#bed-count").value = "";
		document.querySelector("input#min-price").value = "";
		document.querySelector("input#max-price").value = "";
		break;
	case "all":
		resetTags("propertyTypes");
		resetTags("roomTypes");
		resetTags("amenityTypes");
		resetTags("etc");
		break;
	}
}