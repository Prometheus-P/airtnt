package com.airtnt.airtnt.controller;

import java.text.DateFormat;

import java.util.Date;
import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */

	@RequestMapping(value = {"/", "index"}, method = {RequestMethod.GET, RequestMethod.POST})
	public String home(Locale locale, Model model, final HttpSession session, HttpServletRequest req) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		//쿠키에 saveId가 들어있는지 확인
		Cookie[] cks = req.getCookies();
		String value = null;
		if (cks != null && cks.length != 0){
			for(int i=0; i<cks.length; ++i){
				String ckName = cks[i].getName();
				if (ckName.equals("saveId")){
					value = cks[i].getValue();
					req.setAttribute("value", value);
					break;
				}
			}
		}
		
		// 우리 프로젝트 내에 파일 저장되는 실제 경로
		System.out.println(req.getSession().getServletContext().getRealPath(req.getContextPath()));
		
		return "home";
	}
	
}
