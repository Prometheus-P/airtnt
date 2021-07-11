package com.airtnt.airtnt.util;


import java.text.SimpleDateFormat;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class Util {
	
	public static Cookie getCookie(HttpServletRequest req, String cookieName) {
		Cookie[] cookieArray = req.getCookies();
		if(cookieArray != null) {
			for(int i = 0; i < cookieArray.length; i++) {
				if(cookieArray[i].getName().equals(cookieName)) {
					return cookieArray[i];
				}
			}
		}
		return null;
	}
	
	public static String getCurrentURI(HttpServletRequest req) {
		return req.getRequestURI() + (req.getQueryString() == null ? "" : "?" + req.getQueryString());
	}
	
	public static String getMemberId(HttpServletRequest req) {
		return getMemberId(req.getSession());
	}
	
	public static String getMemberId(HttpSession session) {
		return (String)session.getAttribute("member_id");
	}
	
	public static String getTomorrowString() {
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date now = new java.util.Date();
		java.util.Date tomorrow = new java.util.Date(now.getTime() + 24*60*60*1000);
		String strDate = sdfDate.format(tomorrow);
		return strDate;
	}
	
	public static String getDayAfterTomorrowString() {
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date now = new java.util.Date();
		java.util.Date tomorrow = new java.util.Date(now.getTime() + 2*24*60*60*1000);
		String strDate = sdfDate.format(tomorrow);
		return strDate;
	}
	
	public static String getCurrentTimeStamp() {
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		java.util.Date now = new java.util.Date();
		String strDate = sdfDate.format(now);
		return strDate;
	}
}
