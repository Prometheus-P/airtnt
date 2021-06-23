package com.airtnt.airtnt.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.airtnt.airtnt.model.AmenityDTO;
import com.airtnt.airtnt.model.PropertyDTO;
import com.airtnt.airtnt.service.AmenityMapper;
import com.airtnt.airtnt.service.PropertyMapper;

@Controller
@RequestMapping("guest")
public class GuestController {
	
	@Autowired
	private PropertyMapper propertyMapper;
	@Autowired
	private AmenityMapper amenityMapper;
	
	@RequestMapping("search")
	public String searchRoom(HttpServletRequest req,
			@RequestParam(value = "addressKey", required = false) String addressKey) {
		if(addressKey == null) {
			addressKey = "노원";
		}
		List<PropertyDTO> properties = propertyMapper.searchPropertiesByAddress(addressKey);
		for(PropertyDTO property : properties) {
			System.out.println(property);
		}
		req.setAttribute("properties", properties);
		
		return "guest/property/property_list";
	}

	@RequestMapping("property-detail")
	public String detail(HttpServletRequest req,
			@RequestParam("propertyId") int propertyId) {
		PropertyDTO property = propertyMapper.selectPropertyById(propertyId);
		
		List<AmenityDTO> amenities = amenityMapper.selectAmenities(propertyId);
		// 사진 리스트랑 편의시설 리스트랑 댓글 리스트 추가해야 함
		
		req.setAttribute("property", property);
		req.setAttribute("amenities", amenities);
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
