<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/top.jsp"%>
<div class="hoc container clear ">
	<div>
		<div class="bold fl_left" style="font-size: 4vh;">계정</div><br><br><br><br>
		<span class="bold fl_left" style="font-size: 2vh;">${memberData.name},</span>
		<span class="bold" style="font-size: 2vh; margin-left: 10px;">${memberData.tel}</span>
	</div>
  <main> 
    <!-- main body -->
    <!-- ################################################################################################ -->
    <section id="services">
      <div class="sectiontitle" style="max-width:100%"></div>
      <ul class="nospace group grid-3">
		        <li class="one_third">
		        	<div class="border rounded vw-3" style="padding-left:2vh;padding-top:2vh;padding-bottom:2vh">
		        		<a href="/myPage/profile" style="color:#89abe3">
		        			<div><svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
										  <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
										</svg></div>
		        			<div><h2>프로필 ></h2></div>
		        			<div><h4>프로필을 관리하세요</h4></div>
		        		</a>
		        	</div>
		        </li>
		        <li class="one_third">
		        	<div class="border rounded vw-3" style="padding-left:2vh;padding-top:2vh;padding-bottom:2vh">
		        		<a href="/myPage/review" style="color:#89abe3">
		        			<div><svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-chat-right-text" viewBox="0 0 16 16">
										  <path d="M2 1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h9.586a2 2 0 0 1 1.414.586l2 2V2a1 1 0 0 0-1-1H2zm12-1a2 2 0 0 1 2 2v12.793a.5.5 0 0 1-.854.353l-2.853-2.853a1 1 0 0 0-.707-.293H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h12z"/>
										  <path d="M3 3.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zM3 6a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 6zm0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
										</svg></div>
		        			<div><h2>후기 ></h2></div>
		        			<div><h4>후기를 작성하고 관리하세요</h4></div>
		        		</a>
		        	</div>
		        </li>
		        <li class="one_third">
		        	<div class="border rounded vw-3" style="padding-left:2vh;padding-top:2vh;padding-bottom:2vh">
		        		<a href="/myPage/payment" style="color:#89abe3">
		        			<div><svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-cash-coin" viewBox="0 0 16 16">
										  <path fill-rule="evenodd" d="M11 15a4 4 0 1 0 0-8 4 4 0 0 0 0 8zm5-4a5 5 0 1 1-10 0 5 5 0 0 1 10 0z"/>
										  <path d="M9.438 11.944c.047.596.518 1.06 1.363 1.116v.44h.375v-.443c.875-.061 1.386-.529 1.386-1.207 0-.618-.39-.936-1.09-1.1l-.296-.07v-1.2c.376.043.614.248.671.532h.658c-.047-.575-.54-1.024-1.329-1.073V8.5h-.375v.45c-.747.073-1.255.522-1.255 1.158 0 .562.378.92 1.007 1.066l.248.061v1.272c-.384-.058-.639-.27-.696-.563h-.668zm1.36-1.354c-.369-.085-.569-.26-.569-.522 0-.294.216-.514.572-.578v1.1h-.003zm.432.746c.449.104.655.272.655.569 0 .339-.257.571-.709.614v-1.195l.054.012z"/>
										  <path d="M1 0a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h4.083c.058-.344.145-.678.258-1H3a2 2 0 0 0-2-2V3a2 2 0 0 0 2-2h10a2 2 0 0 0 2 2v3.528c.38.34.717.728 1 1.154V1a1 1 0 0 0-1-1H1z"/>
										  <path d="M9.998 5.083 10 5a2 2 0 1 0-3.132 1.65 5.982 5.982 0 0 1 3.13-1.567z"/>
										</svg></div>
		        			<div><h2>결제 및 대금 수령 ></h2></div>
		        			<div><h4>결제,대금을 관리하세요</h4></div>
		        		</a>
		        	</div>
		        </li>
	</section>
    <!-- ################################################################################################ -->
    <!-- / main body -->
    <div class="clear"></div>
  </main>
</div>
<%@ include file="/WEB-INF/views/bottom.jsp"%>