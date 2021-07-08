package com.airtnt.airtnt.controller;

import java.util.List;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

public interface HostControllerInterface {
	public ModelAndView guide_home();
	public ModelAndView guide_context(@RequestParam int id);
	
	public ModelAndView property_type_0(HttpServletRequest req);
	public ModelAndView sub_property_type_1(HttpServletRequest req, @RequestParam Integer propertyTypeId, @RequestParam String propertyTypeName);
	public ModelAndView room_type_2(HttpServletRequest req, @RequestParam Integer subPropertyTypeId, @RequestParam String subPropertyTypeName);
	public String address_3(HttpServletRequest req, @RequestParam Integer roomTypeId, @RequestParam String roomTypeName);
	public String floor_plan_4(HttpServletRequest req, @RequestParam String address, @RequestParam String addressDetail);
	public ModelAndView amenities_5(HttpServletRequest req, @RequestParam Integer maxGuest, @RequestParam Integer bedCount);
	public String photos_6(HttpServletRequest req, @RequestParam(value="amenities", required=true) List<Integer> amenities);
	public String photos_upload(@RequestParam("article_files") List<MultipartFile> multipartFile, HttpServletRequest req);
	public String name_description_7();
	public String price_8(HttpServletRequest req, @RequestParam String name, @RequestParam String description);
	public String preview_9(HttpServletRequest req, @RequestParam int price);
	public String publish_celebration_10(HttpServletRequest req);
	
	public ModelAndView host_mode(HttpServletRequest req);
	public ModelAndView host_properties_list(HttpServletRequest req);
	public ModelAndView host_getProperty(HttpServletRequest req, @RequestParam int propertyId);
	public ModelAndView host_property_update(HttpServletRequest req, @RequestParam Map<String, String> map, @RequestParam("files")List<MultipartFile> images);
	public ModelAndView transaction_list(HttpServletRequest req);
	public ModelAndView total_earning(HttpServletRequest req);
	public ModelAndView host_review_list(HttpServletRequest req);
	public ModelAndView host_support(HttpServletRequest req);
	
}
