package com.airtnt.airtnt.interceptor;


import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception { //컨트롤러로 들어가기 전
		HttpSession session = request.getSession();
		if (session.getAttribute("member_id") == null && session.getAttribute("member_name") == null) {
			System.out.println("======로그인 중이 아님!======");
			Enumeration<String> enu = session.getAttributeNames();
			while(enu.hasMoreElements()) {
				String key = enu.nextElement();
				String value= request.getParameter(key);
				System.out.println("세션 내장 값 >> " + key + ": " + value);
			}
			response.sendRedirect(request.getContextPath() + "/message_login"); 
			return false;
		}
		System.out.println("======로그인 확인!======");
		Enumeration<String> enu = request.getParameterNames();
		while(enu.hasMoreElements()) {
			String key = enu.nextElement();
			String value= request.getParameter(key);
			System.out.println("파라미터 >> " + key + ": " + value);
		}
		return true;
	}

}
