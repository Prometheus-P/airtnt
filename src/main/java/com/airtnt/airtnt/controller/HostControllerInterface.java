package com.airtnt.airtnt.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

public interface HostControllerInterface {
	public ModelAndView guide_home();
	public ModelAndView guide_context(@RequestParam int id);
	public ModelAndView property_type_0() ;
	public ModelAndView property_detail_1(HttpServletRequest req, @RequestParam int propertyTypeId);
	public String property_address_2(HttpServletRequest req, @RequestParam Map<String, Integer> map1);
	public String property_detail_3(HttpServletRequest req, @RequestParam String address);
	public String property_image_4(HttpServletRequest req, @RequestParam Map<String, String> map2);
	public String property_preview_5(HttpServletRequest req, MultipartHttpServletRequest mr) ;
	public String publish_celebration_6(HttpServletRequest req) ;
	public ModelAndView host_mode(HttpServletRequest req);
	public ModelAndView host_properties_list(HttpServletRequest req);
	public ModelAndView host_property_detail(HttpServletRequest req, int propertyId);
	public ModelAndView host_property_update(HttpServletRequest req, int propertyId);
	public ModelAndView total_earnings(HttpServletRequest req);
	public ModelAndView trasaction_list(HttpServletRequest req);
	public ModelAndView host_review_list(HttpServletRequest req);
}
