package com.airtnt.airtnt.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class LoginCheckFilter implements Filter {
	private List<String> excludeUrls;
	private List<String> staticReosurceList;
	
	public void init(FilterConfig config) throws ServletException {
		String excludePattern = config.getInitParameter("excludedUrls");
		excludeUrls = Arrays.asList(excludePattern.split(","));

		//resources
		staticReosurceList = new ArrayList<String>();
		staticReosurceList.add("/resources/");
		staticReosurceList.add("/resources_host/");
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpSession session = httpRequest.getSession(false);

		httpRequest.setCharacterEncoding("UTF-8");
		String path = ((HttpServletRequest) request).getServletPath();
		
        System.out.println("user path : " + path);
        System.out.println(!excludeUrls.contains(path));
        
		boolean login = false;
		if (session != null) {
			if (session.getAttribute("member_id") != null) {
				login = true; // 세션변수가 null이 아닐경우 true로 설정.
			}
		}
		if (login) {
			System.out.println("login true");
			// 세션변수가 null이 아닐경우, 필터 체인을 거친 후, 요청한 페이지로 이동한다.
			chain.doFilter(request, response);
		} else {
			// 세션변수가 null일 경우, 로그인 폼으로 이동한다.
			System.out.println("login false");
			if(!excludeUrls.contains(path)) { 
				//제외한 url이 아니면
				boolean isURIResource = false;
				for(String staticResource : staticReosurceList) {
					if (path.startsWith(staticResource)) {
						isURIResource = true;
						break;
					}
				}
				if(!isURIResource) { //resource url 이 아니면
					RequestDispatcher dispatcher = null;
					if(path.contains("admin")) {
						dispatcher = request.getRequestDispatcher("/admin");
					}else {
						dispatcher = request.getRequestDispatcher("/index");
					}
					dispatcher.forward(request, response);
				}else {
					chain.doFilter(request, response);
				}
				
			}else{
				chain.doFilter(request, response);
			}
		}
		
	}

	public void destroy() {

	}
}