package com.airtnt.airtnt.interceptor;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;

public class HostInterceptor implements HandlerInterceptor {
	protected final Logger logger = LoggerFactory.getLogger(HostInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		if (session.getAttribute("member_mode").equals("1")) {
			System.out.println("호스트 아님");
			response.sendRedirect(request.getContextPath() + "/message_host");
			return false;
		}
		System.out.println("=====호스트 확인=====");
		session.setAttribute("isHostMode", true);
		return true;
	}
}