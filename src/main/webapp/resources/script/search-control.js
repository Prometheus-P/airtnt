/**
 * property list 페이지에 스크립트가 너무 많아져서 따로 옮김
 */
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

function movePage(pageButton){
	var pageNum = pageButton.id.split('-')[1];
	document.querySelector("input#page-num").value = pageNum;
	setParametersOnSubmit();
	document.querySelector("form#search-form").submit();
}

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