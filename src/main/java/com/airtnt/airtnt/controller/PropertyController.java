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
import com.airtnt.airtnt.util.TagAttribute;

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
		
		System.out.println("----- 검색 ------");
		System.out.println("property type : " + Arrays.toString(propertyTypeIdKeyArray));
		System.out.println("sub-property type : " + Arrays.toString(subPropertyTypeIdKeyArray));
		System.out.println("room type : " + Arrays.toString(roomTypeIdKeyArray));
		System.out.println("amenity type : " + Arrays.toString(amenityTypeIdKeyArray));
		System.out.println("guest count : " + guestCountKey);
		System.out.println("bed count : " + bedCountKey);
		System.out.println("min price : " + minPriceKey);
		System.out.println("max price : " + maxPriceKey);
		System.out.println("-----------------");
		
		// sql 조건문 맵
		Map<String, Object> searchKeyMap = new Hashtable<>();
		searchKeyMap.put("addressKey", addressKey);
		Object[][] paramMatrix = new Object[][] {
				{"propertyTypeIdKeyArray", propertyTypeIdKeyArray},
				{"subPropertyTypeIdKeyArray", subPropertyTypeIdKeyArray},
				{"roomTypeIdKeyArray", roomTypeIdKeyArray},
				{"amenityTypeIdKeyArray", amenityTypeIdKeyArray},
				{"guestCountKey", guestCountKey},
				{"bedCountKey", bedCountKey},
				{"minPriceKey", minPriceKey},
				{"maxPriceKey", maxPriceKey}
		};
		for(int i = 0; i < paramMatrix.length; i++) {
			if(paramMatrix[i][1] != null) {
				searchKeyMap.put((String)paramMatrix[i][0], paramMatrix[i][1]);
			}
		}
		
		// 숙소 목록
		List<PropertyDTO> properties = propertyMapper.searchProperties(searchKeyMap);
		
		// 검색 필터 목록
		List<PropertyTypeDTO> propertyTypes = propertyMapper.selectPropertyTypes();
		List<RoomTypeDTO> roomTypes = propertyMapper.selectRoomTypes();
		List<AmenityTypeDTO> amenityTypes = propertyMapper.selectAmenityTypes();
		
		outer: for(PropertyTypeDTO propertyType : propertyTypes) {
			// 숙소유형값이 없어도 숙소세부유형값이 있을 수 있기 때문에
			// null 체크 조건문을 for 안에 써준다.
			if(propertyTypeIdKeyArray != null) {
				for(int i = 0; i < propertyTypeIdKeyArray.length; i++) {
					if(propertyType.getId() == propertyTypeIdKeyArray[i]) {
						propertyType.putTagAttributeMapValue(TagAttribute.CHECKED);
						// 숙소유형이 checked 되어있으면 하위항목을 모두 disabled함
						for(SubPropertyTypeDTO subPropertyType : propertyType.getSubPropertyTypes()) {
							subPropertyType.putTagAttributeMapValue(TagAttribute.DISABLED);
						}
						continue outer;
					}
				}
			}
			// 현재 숙소유형이 체크된 숙소유형 파라미터값이 아니면 여기로 넘어옴.
			// 숙소세부유형값이 없으면 반복문을 실행하지 않아도 되기 때문에
			// null 체크 조건문을 for문 밖에 써준다.
			if(subPropertyTypeIdKeyArray != null) {
				for(SubPropertyTypeDTO subPropertyType : propertyType.getSubPropertyTypes()) {
					for(int i = 0; i < subPropertyTypeIdKeyArray.length; i++) {
						if(subPropertyType.getId() == subPropertyTypeIdKeyArray[i]) {
							subPropertyType.putTagAttributeMapValue(TagAttribute.CHECKED);
						}
					}
				}
			}
		}
		
		if(roomTypeIdKeyArray != null) {
			for(RoomTypeDTO roomType : roomTypes) {
				for(int i = 0; i < roomTypeIdKeyArray.length; i++) {
					if(roomType.getId() == roomTypeIdKeyArray[i]) {
						roomType.putTagAttributeMapValue(TagAttribute.CHECKED);
					}
				}
			}
		}
		
		if(amenityTypeIdKeyArray != null) {
			for(AmenityTypeDTO amenityType : amenityTypes) {
				for(int i = 0; i < amenityTypeIdKeyArray.length; i++) {
					if(amenityType.getId() == amenityTypeIdKeyArray[i]) {
						amenityType.putTagAttributeMapValue(TagAttribute.CHECKED);
					}
				}
			}
		}
		
		// 숙소 목록
		req.setAttribute("properties", properties);
		
		// 검색 필터 목록
		req.setAttribute("propertyTypes", propertyTypes);
		req.setAttribute("roomTypes", roomTypes);
		req.setAttribute("amenityTypes", amenityTypes);
		
		return "property/property_list";
	}

	@RequestMapping("detail")
	public String detail(HttpServletRequest req,
			@RequestParam("propertyId") Integer propertyId) {
		PropertyDTO property = propertyMapper.selectProperty(propertyId);
		
		req.setAttribute("tomorrow", getTomorrowString());
		req.setAttribute("dayAfterTomorrow", getDayAfterTomorrowString());
		req.setAttribute("property", property);
		
		return "property/property_detail";
	}

	@RequestMapping("booking")
	public String booking(HttpServletRequest req, @ModelAttribute BookingDTO booking) {
		PropertyDTO property = propertyMapper.selectProperty(booking.getPropertyId());
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
