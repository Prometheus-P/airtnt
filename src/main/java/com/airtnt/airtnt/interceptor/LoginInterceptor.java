package com.airtnt.airtnt.interceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception { //컨트롤러로 들어가기 전
		System.out.println("로그인 인터셉터 확인 . . . ");
		HttpSession session = request.getSession();
		if (session.getAttribute("member_id") == null && session.getAttribute("member_name") == null) {
			System.out.println("로그인 중이 아님!");
			response.sendRedirect(request.getContextPath() + "/message_login"); 
			return false;
		}
		System.out.println("로그인 확인!");
		return true;
		/* return HandlerInterceptor.super.preHandle(request, response, handler); */
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception { //컨트롤러를 나오면서
		// TODO Auto-generated method stub

	}

}
