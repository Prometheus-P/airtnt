package com.airtnt.airtnt.controller;

import java.util.List;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

public interface HostControllerInterface {
	public ModelAndView guide_home();
	public ModelAndView guide_context(@RequestParam int id);
	
	public ModelAndView property_type_0();
	public ModelAndView sub_property_type_1(HttpSession session, @RequestParam Integer propertyTypeId, @RequestParam String propertyTypeName);
	public ModelAndView room_type_2(HttpSession session, @RequestParam Integer subPropertyTypeId, @RequestParam String subPropertyTypeName);
	public String address_3(HttpSession session, @RequestParam Integer roomTypeId, @RequestParam String roomTypeName);
	public String floor_plan_4(HttpSession session, @RequestParam String address, @RequestParam String addressDetail);
	public ModelAndView amenities_5(HttpSession session, @RequestParam Integer maxGuest, @RequestParam Integer bedCount);
	public String photos_6(HttpSession session, @RequestParam(value="amenities", required=true) List<Integer> amenities);
	public String photos_upload(@RequestParam("article_files") List<MultipartFile> multipartFile, HttpSession session);
	public String name_description_7();
	public String price_8(HttpSession session, @RequestParam String name, @RequestParam String description);
	public String preview_9(HttpSession session, @RequestParam int price);
	public String property_save(HttpSession session);
	
	public ModelAndView host_mode(HttpSession session);
	public ModelAndView host_properties_list(HttpSession session);
	public ModelAndView host_getProperty(@RequestParam int propertyId);
	public ModelAndView host_property_update(HttpSession session, @RequestParam Map<String, String> map, @RequestParam("files")List<MultipartFile> images);
	public ModelAndView transaction_list(HttpSession session);
	public ModelAndView total_earning(HttpSession session);
	public ModelAndView host_review_list(HttpSession session);
	public ModelAndView host_support(HttpSession session);
	
}
