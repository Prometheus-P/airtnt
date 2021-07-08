package com.airtnt.airtnt.util;


import java.text.SimpleDateFormat;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class Util {
	
	// 쿠키 수명
	// 월(1~12)*일(1~30)*시간(1~24)*분(1~60)*초(1~60)
	public static final int SECOND = 1;
	public static final int MINUTE = 60*SECOND;
	public static final int HOUR = 60*MINUTE;
	public static final int DAY = 24*HOUR;
	public static final int WEEK = 7*DAY;
	public static final int MONTH = 30*DAY;
	public static final int YEAR = 12*MONTH;
	
	public static final String RECENT_COOKIE_PREFIX = "AirTnT_recent_";
	
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
