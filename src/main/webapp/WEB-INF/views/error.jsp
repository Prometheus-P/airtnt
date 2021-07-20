<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>ERROR</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<style>
* {
	position: relative;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

.centered {
	height: 100vh;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

h1 {
	margin-bottom: 50px;
	font-family: 'Lato', sans-serif;
	font-size: 50px;
	font-weight: bolder;
}

.message {
	display: inline-block;
	line-height: 1.2;
	transition: line-height .2s, width .2s;
	overflow: hidden;
}

.message, .hidden {
	font-family: '굴림', arial;
	font-size: 18px;
	font-weight: bold;
}

.hidden {
	color: #FFF;
}
</style>

</head>
<body>
	<section class="centered">
		<c:if test="${requestScope['javax.servlet.error.status_code'] == 400}">
			<h1>
				400<br>잘못 된 요청입니다.
			</h1>
		</c:if>

		<c:if test="${requestScope['javax.servlet.error.status_code'] == 404}">
			<h1>
				404<br>요청하신 페이지를 찾을 수 없습니다.
			</h1>
		</c:if>

		<c:if test="${requestScope['javax.servlet.error.status_code'] == 405}">
			<h1>
				405<br>요청된 메소드가 허용되지 않습니다.
			</h1>
		</c:if>

		<c:if test="${requestScope['javax.servlet.error.status_code'] == 500}">
			<h1>
				500<br>서버에 오류가 발생하여 요청을 수행할 수 없습니다.
			</h1>
		</c:if>

		<c:if test="${requestScope['javax.servlet.error.status_code'] == 503}">
			<h1>
				503<br>서비스를 사용할 수 없습니다.
			</h1>
		</c:if>

		<div class="container" >
			<span class="message" id="js-whoops"></span> 
			<span class="message"id="js-appears"></span> 
			<span class="message" id="js-error"></span>
			<span class="message" id="js-apology"></span>
			<div>
				<span class="hidden" id="js-hidden" >Message Here</span>
			</div>
		</div><br><br><br><br>
		<button type="button" class="btn btn-link" onclick="location.href='/index'" style="font-weight: bold;">홈으로</button><br>
		<button type="button" class="btn btn-link" onclick="javascript:history.back()" style="font-weight: bold;">이전 페이지로</button>
		</section>
	<br>
	<br>

	<script>
//Here are the different messages we'll use for creating the 500 displayable message
const messages = [
  ['o(ㅠ~ㅠ)o', ':(' , '(ToT)', '(ㅠ_ㅠ)','o(T^To)', ':<'],
  ['아마', '그게..', '아마', '저희가 생각엔'],
  ['누가 실수 했나봐요.', '서버에 문제가 생긴 것 같네요.', '미처 확인하지 못한 오류가 있었나봐요.', '실수가 있었나봐요.'],
  ['죄송합니다.', '너른 양해 부탁드립니다.', '조금만 기다려주세요.', '더 노력하겠습니다.']
];

// These are the different elements we'll be populating. They are in the same order as the messages array
const messageElements = [
  document.querySelector('#js-whoops'),
  document.querySelector('#js-appears'),
  document.querySelector('#js-error'),
  document.querySelector('#js-apology')
];

// we'll use this element for width calculations
const widthElement = document.querySelector('#js-hidden');
// keeping track of the message we just displayed last
let lastMessageType = -1;
// How often the page should swap messages
let messageTimer = 4000;

// on document load, setup the initial messages AND set a timer for setting messages
document.addEventListener('DOMContentLoaded', (event) => {
  setupMessages();
  setInterval(() => {
    swapMessage();
  }, messageTimer);
});

// Get initial messages for each message element
function setupMessages() {
  messageElements.forEach((element, index) => {
    let newMessage = getNewMessage(index);
    element.innerText = newMessage;
  });
}

// set the width of a given element to match its text's width
function calculateWidth(element, message) {
  // use our dummy hidden element to get the text's width. Then use that to set the real element's width
  widthElement.innerText = message;
  let newWidth = widthElement.getBoundingClientRect().width;
  element.style.width = `${newWidth}px`;
}

// swap a message for one of the message types
function swapMessage() {
  let toSwapIndex = getNewSwapIndex();
  let newMessage  = getNewMessage(toSwapIndex);
  // Animate the disappearing, setting width, and reappearing
  messageElements[toSwapIndex].style.lineHeight = '0';
  // once line height is done transitioning, set element width & message
  setTimeout(() => {
    // make sure the element has a width set for transitions
    checkWidthSet(toSwapIndex, messageElements[toSwapIndex].innerText);
    // set the new text
    messageElements[toSwapIndex].innerText = newMessage; 
    // set the new width
    calculateWidth(messageElements[toSwapIndex], newMessage);
  }, 200);
  // once width is done, transition the lineheight back to 1 so we can view the message
  setTimeout(() => {
    messageElements[toSwapIndex].style.lineHeight = '1.2';
  }, 400);
}

// We need to make sure that the element at the passed index has a width set so we can use transitions
function checkWidthSet(index, message) {
  if (false == messageElements[index].style.width) {
    messageElements[index].style.width = `${messageElements[index].clientWidth}px`;
  }
}

// Return a new index to swap message in. Should not be the same as the last message type swapped
function getNewSwapIndex() {
  let newMessageIndex = Math.floor(Math.random() * messages.length);
  while (lastMessageType == newMessageIndex) {
    newMessageIndex = Math.floor(Math.random() * messages.length);
  }
  return newMessageIndex;
}

// Get a new message for the message element.
function getNewMessage(toSwapIndex) {
  const messagesArray   = messages[toSwapIndex];
  const previousMessage = messageElements[toSwapIndex].innerText;
  // Get a new random index and the message at that index
  let newMessageIndex = Math.floor(Math.random() * messagesArray.length);
  let newMessage      = messagesArray[newMessageIndex];
  // let's make sure they aren't the same as the message already there
  while (newMessage == previousMessage) {
    newMessageIndex = Math.floor(Math.random() * messagesArray.length);
    newMessage      = messagesArray[newMessageIndex];
  }
  return newMessage;
}
</script>
</body>
</html>
