/**
 * property list 페이지에 스크립트가 너무 많아져서 따로 옮김
 */

function setParametersOnSubmit(){
	var numberArray = [
		document.getElementById("guest-count"),
		document.getElementById("bed-count"),
		document.getElementById("min-price"),
		document.getElementById("max-price")
	]
	
	for(var i = 0; i < numberArray.length; i++){
		var numberTag = numberArray[i];
		if(numberTag.value == 0){
			numberTag.value = "";
			numberTag.setAttribute("disabled", "disabled");
		}
	}
}

function setPropertyTypeFilter(propertyTypeTag){
	var subPropertyTypeTagArray = document.getElementsByName("subPropertyTypeId");
	for(var i = 0; i < subPropertyTypeTagArray.length; i++){
		var subPropertyTypeTag = subPropertyTypeTagArray[i];
		if(subPropertyTypeTag.id.split('-')[1] == propertyTypeTag.value){
			if(propertyTypeTag.getAttribute("checked") == "checked"){
				// propertyType이 checked이면 ckeck를 해제할 것이기 때문에 하위항목을 활성화
				subPropertyTypeTag.removeAttribute("disabled");
			} else {
				// propertyType이 unchecked이면 checked해줄 것이기 때문에 하위항목을 비활성화
				subPropertyTypeTag.setAttribute("disabled", "disabled");
			}
		}
	}
	
	if(propertyTypeTag.getAttribute("checked") == "checked"){
		propertyTypeTag.removeAttribute("checked");
	} else {
		propertyTypeTag.setAttribute("checked", "checked");
	}
}

function changeCount(button){
	var idValueArray = button.id.split('-');
	var operation = idValueArray[0];
	var element = idValueArray[1];
	
	var countTag = document.getElementById(element + "-count");
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

function changePrice(priceTag){
	var minPriceTag, maxPriceTag;
	switch(priceTag.id){
	case "min-price":
		minPriceTag = priceTag; // event source
		maxPriceTag = document.getElementById("max-price");
		break;
	case "ma-price":
		minPriceTag = document.getElementById("min-price");
		maxPriceTag = priceTag; // event source
		break;
	}
}