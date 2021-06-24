package com.airtnt.airtnt.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.airtnt.airtnt.model.BookingDTO;
import com.airtnt.airtnt.model.PropertyDTO;
import com.airtnt.airtnt.service.PropertyMapper;

@Controller
@RequestMapping("property")
public class PropertyController {
	
	@Autowired
	private PropertyMapper propertyMapper;
	
	@RequestMapping("search")
	public String searchRoom(HttpServletRequest req,
			@RequestParam(value = "addressKey", required = false) String addressKey) {
		if(addressKey == null) {
			addressKey = "노원";
		}
		List<PropertyDTO> properties = propertyMapper.searchPropertiesByAddress(addressKey);
		
		req.setAttribute("properties", properties);
		
		return "property/property_list";
	}

	@RequestMapping("detail")
	public String detail(HttpServletRequest req,
			@RequestParam("propertyId") int propertyId) {
		PropertyDTO property = propertyMapper.selectPropertyById(propertyId);
		
		req.setAttribute("tomorrow", getTomorrowString());
		req.setAttribute("dayAfterTomorrow", getDayAfterTomorrowString());
		req.setAttribute("property", property);
		
		return "property/property_detail";
	}

	@RequestMapping("booking")
	public String booking(HttpServletRequest req, @ModelAttribute BookingDTO booking) {
		PropertyDTO property = propertyMapper.selectPropertyById(booking.getPropertyId());
		req.setAttribute("booking", booking);
		req.setAttribute("property", property);
		return "property/booking";
	}

	@RequestMapping("booking_confirm")
	public String confirm() {
//		String frontBookingNumber = getCurrentTimeStamp();
//		booking.setBookingNumber(frontBookingNumber);
//		int random = (int)(Math.random() * 10);

		return "property/booking_confirm";
	}
	
	public String getTomorrowString() {
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date now = new java.util.Date();
		java.util.Date tomorrow = new java.util.Date(now.getTime() + 24*60*60*1000);
		String strDate = sdfDate.format(tomorrow);
		return strDate;
	}
	
	public String getDayAfterTomorrowString() {
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date now = new java.util.Date();
		java.util.Date tomorrow = new java.util.Date(now.getTime() + 2*24*60*60*1000);
		String strDate = sdfDate.format(tomorrow);
		return strDate;
	}
	
	public String getCurrentTimeStamp() {
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		java.util.Date now = new java.util.Date();
		String strDate = sdfDate.format(now);
		return strDate;
	}

}
