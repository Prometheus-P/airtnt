<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/top.jsp"%>
<div class="hoc container clear ">
	<div>
		<div class="bold fl_left" style="font-size: 4vh;">계정</div><br><br><br>
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
		        		<a href="profile">
		        			<div><svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
									  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
									  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
									</svg></div>
		        			<div><h2>프로필 ></h2></div>
		        			<div><h4>프로필을 관리하세요</h4></div>
		        		</a>
		        	</div>
		        </li>
		        <li class="one_third">
		        	<div class="border rounded vw-3" style="padding-left:2vh;padding-top:2vh;padding-bottom:2vh">
		        		<a href="review">
		        			<div><svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
									  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
									  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
									</svg></div>
		        			<div><h2>후기 ></h2></div>
		        			<div><h4>후기를 작성하고 관리하세요</h4></div>
		        		</a>
		        	</div>
		        </li>
		        <li class="one_third">
		        	<div class="border rounded vw-3" style="padding-left:2vh;padding-top:2vh;padding-bottom:2vh">
		        		<a href="">
		        			<div><svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
									  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
									  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
									</svg></div>
		        			<div><h2>결제 및 대금 수령 ></h2></div>
		        			<div><h4>프로필을 수정하세요</h4></div>
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