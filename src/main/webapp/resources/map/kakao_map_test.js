/**
 * 
 */

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = {
	center: new kakao.maps.LatLng(37.65579, 127.06237), // 지도의 중심좌표
	level: 6//, // 지도의 확대 레벨
	//mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
}; 

// 지도를 생성한다 
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 지도에 확대 축소 컨트롤을 생성한다
var zoomControl = new kakao.maps.ZoomControl();

// 지도의 우측에 확대 축소 컨트롤을 추가한다
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

// 지도 중심 좌표 변화 이벤트를 등록한다
kakao.maps.event.addListener(map, 'center_changed', function () {
	console.log('지도의 중심 좌표는 ' + map.getCenter().toString() +' 입니다.');
});

// 지도 확대 레벨 변화 이벤트를 등록한다
kakao.maps.event.addListener(map, 'zoom_changed', function () {
	console.log('지도의 현재 확대레벨은 ' + map.getLevel() +'레벨 입니다.');
});

// 지도 영역 변화 이벤트를 등록한다
kakao.maps.event.addListener(map, 'bounds_changed', function () {
	var mapBounds = map.getBounds(),
	message = '지도의 남서쪽, 북동쪽 영역좌표는 ' +
	mapBounds.toString() + '입니다.';

	console.log(message);	
});

// 지도 시점 변화 완료 이벤트를 등록한다
kakao.maps.event.addListener(map, 'idle', function () {
	var message = '지도의 중심좌표는 ' + map.getCenter().toString() + ' 이고,' + 
	'확대 레벨은 ' + map.getLevel() + ' 레벨 입니다.';
	console.log(message);
});

// 지도에 마커를 생성하고 표시한다
var marker = new kakao.maps.Marker({
	position: new kakao.maps.LatLng(37.65072, 127.06702), // 마커의 좌표
	draggable : true, // 마커를 드래그 가능하도록 설정한다
	map: map // 마커를 표시할 지도 객체
});

// 마커에 클릭 이벤트를 등록한다 (우클릭 : rightclick)
kakao.maps.event.addListener(marker, 'click', function() {
	alert('마커를 클릭했습니다!');
});

// 마커에 mouseover 이벤트를 등록한다
kakao.maps.event.addListener(marker, 'mouseover', function() {
	console.log('마커에 mouseover 이벤트가 발생했습니다!');
});

// 마커에 mouseout 이벤트 등록
kakao.maps.event.addListener(marker, 'mouseout', function() {
	console.log('마커에 mouseout 이벤트가 발생했습니다!');
});