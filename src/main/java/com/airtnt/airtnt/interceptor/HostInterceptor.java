package com.airtnt.airtnt.interceptor;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

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
		System.out.println("=================호스트 맞음================");
		session.setAttribute("isHostMode", true);
		@SuppressWarnings("rawtypes")
		Enumeration paramNames = request.getParameterNames();
		logger.debug(" URI: " + request.getRequestURI() + "\n");
		while (paramNames.hasMoreElements()) {
			String key = (String) paramNames.nextElement();
			String value = request.getParameter(key);
			logger.debug(" RequestParameter Data ==>  " + key + " : " + value + "\n");
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		HttpSession session = request.getSession();
		@SuppressWarnings("rawtypes")
		Enumeration sessionNames = session.getAttributeNames();
		while (sessionNames.hasMoreElements()) {
			String key = (String) sessionNames.nextElement();
			logger.debug("Session Data ==>  " + key + " : " + session.getAttribute(key) + "\n");
		}
	}
}
