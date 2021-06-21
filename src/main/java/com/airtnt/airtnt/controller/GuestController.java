package com.airtnt.airtnt.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.airtnt.airtnt.model.PropertyDTO;
import com.airtnt.airtnt.service.PropertyMapper;

@Controller
@RequestMapping("guest")
public class GuestController {
	
	 @Autowired
	 private PropertyMapper propertyMapper;
	 
	@RequestMapping("search")
	public String searchRoom(HttpServletRequest req,
			@RequestParam(required = false, value = "address_key") String addressKey) {
		if(addressKey == null) {
			addressKey = "노원";
		}
		List<PropertyDTO> properties = propertyMapper.searchPropertiesByAddress(addressKey);
		req.setAttribute("properties", properties);
		
		return "guest/property/property_list";
	}

	@RequestMapping("property_detail")
	public String detail() {

		return "guest/property/property_detail";
	}

	@RequestMapping("property_booking")
	public String booking() {

		return "guest/property/booking";
	}

	@RequestMapping("booking_confirm")
	public String confirm() {

		return "guest/property/booking_confirm";
	}

}
