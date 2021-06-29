package com.airtnt.airtnt.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.airtnt.airtnt.model.*;
import com.airtnt.airtnt.service.PropertyMapper;

@Controller
@RequestMapping("property")
public class PropertyController {
	
	@Autowired
	private PropertyMapper propertyMapper;
	
	@RequestMapping("search")
	public String search(HttpServletRequest req,
			@RequestParam(value = "addressKey", required = false) String addressKey,
			@RequestParam(value = "propertyTypeId", required = false) Integer[] propertyTypeIdKeyArray,
			@RequestParam(value = "subPropertyTypeId", required = false) Integer[] subPropertyTypeIdKeyArray,
			@RequestParam(value = "roomTypeId", required = false) Integer[] roomTypeIdKeyArray,
			@RequestParam(value = "amenityTypeId", required = false) Integer[] amenityTypeIdKeyArray,
			@RequestParam(value = "guestCount", required = false) Integer guestCountKey,
			@RequestParam(value = "bedCount", required = false) Integer bedCountKey,
			@RequestParam(value = "minPrice", required = false) Integer minPriceKey,
			@RequestParam(value = "maxPrice", required = false) Integer maxPriceKey) {
		if(addressKey == null) {
			addressKey = "노원";
		}
		
		System.out.println(Arrays.toString(propertyTypeIdKeyArray));
		System.out.println(Arrays.toString(subPropertyTypeIdKeyArray));
		System.out.println(Arrays.toString(roomTypeIdKeyArray));
		System.out.println(Arrays.toString(amenityTypeIdKeyArray));
		
		// 파라미터 처리는 자바에서 해야함
		
		List<PropertyDTO> properties = propertyMapper.searchPropertiesByAddress(addressKey);
		
		List<PropertyTypeDTO> propertyTypes = propertyMapper.selectPropertyTypes();
		List<RoomTypeDTO> roomTypes = propertyMapper.selectRoomTypes();
		List<AmenityTypeDTO> amenityTypes = propertyMapper.selectAmenityTypes();
		
		
		// 제작중
		Map<String, Object> searchKeyMap = new Hashtable<>();
		
		
		
		req.setAttribute("properties", properties);
		
		// search filters
		req.setAttribute("propertyTypes", propertyTypes);
		req.setAttribute("roomTypes", roomTypes);
		req.setAttribute("amenityTypes", amenityTypes);
		
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

	@RequestMapping("booking-confirm")
	public String bookingConfirm(HttpServletRequest req, @ModelAttribute BookingDTO booking) {
		System.out.println(booking);
		int propertyId;
		try {
			propertyId = Integer.parseInt(req.getParameter("propertyId"));
		} catch(NullPointerException | NumberFormatException e) {
			req.setAttribute("msg", "숙소정보 없음");
			req.setAttribute("url", "/");
			return "message";
		}
		String bookingNumber = getCurrentTimeStamp();
		// 타임스탬프 뒤에 0~9의 난수를 붙이고 그 뒤에 db에서 0~9의 시퀀스 사이클을 붙일 것임
		bookingNumber += String.valueOf((int)(Math.random() * 10));
		booking.setPropertyId(propertyId);
		booking.setBookingNumber(bookingNumber);
		if(propertyMapper.insertBooking(booking) < 1) {
			req.setAttribute("msg", "예약 실패(DB 오류)");
			req.setAttribute("url", "/property/detail?propertyId=" + propertyId);
			return "message";
		}
		booking = propertyMapper.selectSameBooking(booking);
		System.out.println(booking);
		
		TransactionDTO transaction = new TransactionDTO();
		transaction.setBookingId(booking.getId());
		if(propertyMapper.insertTransaction(transaction) < 1) {
			req.setAttribute("msg", "결제 실패(DB 오류)");
			req.setAttribute("url", "/property/detail?propertyId=" + propertyId);
			return "message";
		}
		transaction = propertyMapper.selectSameTransaction(transaction);
		
		req.setAttribute("booking", booking);
		req.setAttribute("transaction", transaction);
		
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
