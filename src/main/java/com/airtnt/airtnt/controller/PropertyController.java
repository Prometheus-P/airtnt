
package com.airtnt.airtnt.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.airtnt.airtnt.model.*;
import com.airtnt.airtnt.service.BookingMapper;
import com.airtnt.airtnt.service.PropertyMapper;
import com.airtnt.airtnt.service.WishListMapper;
import com.airtnt.airtnt.util.TagAttribute;

@Controller
@RequestMapping("property")
public class PropertyController {
	private final int DEBUG_INDEX = 1;
	private final boolean DEBUG;
	
	@Autowired
	private PropertyMapper propertyMapper;
	@Autowired
	private WishListMapper wishListMapper;
	@Autowired
	private BookingMapper bookingMapper;
	
	public PropertyController() {
		this.DEBUG = (this.DEBUG_INDEX != 0);
	}
	
	@GetMapping("search")
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
		// 로그인 후 돌아갈 url
		String currentURI = req.getRequestURI() + 
				(req.getQueryString() == null ? "" : "?" + req.getQueryString());
		req.setAttribute("currentURI", currentURI);
		
		if(addressKey == null) {
			addressKey = "노원";
		}
		
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
		
		// 위시리스트
		Map<String, Object> wishMap = new Hashtable<>();
		String memberId = (String)req.getSession().getAttribute("member_id");
		if(memberId != null && !memberId.trim().equals("")) {
			wishMap.put("member_id", memberId);
		}
		List<WishListDTO> wishLists = wishListMapper.selectWishLists(wishMap);
		
		
		// 검색필터 checked, disabled 값 설정
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
		
		// 숙소 wished, unwished 여부 설정
		outer: for(PropertyDTO property : properties) {
			for(WishListDTO wishList : wishLists) {
				for(PropertyDTO wishProperty : wishList.getProperties()) {
					if(property.getId() == wishProperty.getId()) {
						property.setWished(true);
						property.setWishListId(wishList.getId());
						continue outer;
					}
				}
			}
		}
		
		if(DEBUG) {
			System.out.println("현재 URI : " + currentURI);
			
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
			
			System.out.println("----- 위시리스트별 숙소 목록 -----");
			for(WishListDTO wishList : wishLists) {
				System.out.print("위시리스트[" + wishList.getName() + "] : ");
				for(PropertyDTO wishProperty : wishList.getProperties()) {
					System.out.print(wishProperty.getName() + " ");
				}
				System.out.println();
			}
			System.out.println("---------------------------");
			
			System.out.println("----- 숙소별 위시리스트 등록 여부 -----");
			for(PropertyDTO property : properties) {
				System.out.println("숙소" + property.getName() + " : " + property.isWished());
			}
			System.out.println("---------------------------------------");
		}
		
		// 숙소 목록
		req.setAttribute("properties", properties);
		
		// 검색 필터 목록
		req.setAttribute("propertyTypes", propertyTypes);
		req.setAttribute("roomTypes", roomTypes);
		req.setAttribute("amenityTypes", amenityTypes);
		
		// 위시리스트 목록
		req.setAttribute("wishLists", wishLists);
		
		return "property/property-list";
	}

	@GetMapping("detail")
	public String detail(HttpServletRequest req, HttpServletResponse resp,
			@RequestParam("propertyId") Integer propertyId) {
		// 로그인 후 돌아갈 url
		String currentURI = req.getRequestURI() + 
				(req.getQueryString() == null ? "" : "?" + req.getQueryString());
		req.setAttribute("currentURI", currentURI);
		if(DEBUG) {
			System.out.println(currentURI);
		}
		
		PropertyDTO property = propertyMapper.selectProperty(propertyId);
		
		// 위시리스트
		Map<String, Object> wishMap = new Hashtable<>();
		String memberId = (String)req.getSession().getAttribute("member_id");
		if(memberId != null && !memberId.trim().equals("")) {
			wishMap.put("member_id", memberId);
		}
		List<WishListDTO> wishLists = wishListMapper.selectWishLists(wishMap);
		
		
		outer: for(WishListDTO wishList : wishLists) {
			for(PropertyDTO wishProperty : wishList.getProperties()) {
				if(property.getId() == wishProperty.getId()) {
					property.setWished(true);
					property.setWishListId(wishList.getId());
					break outer;
				}
			}
		}
		
		// 최근목록에 저장
		Cookie[] cookieArray = req.getCookies();
		ArrayList<PropertyDTO> recentProperties = new ArrayList<>();
		if(DEBUG) {
			System.out.println("쿠키 사이즈(전) : " + cookieArray.length);
		}
		String cookieUser = "non-member";
		if(memberId != null && !memberId.trim().equals("")) {
			cookieUser = memberId;
		}
		Cookie newCookie = null;
		for(int i = 0; i < cookieArray.length; i++) {
			if(cookieArray[i].getName().equals(cookieUser + "Property")) {
				Integer recentPropertyId = Integer.valueOf(cookieArray[i].getValue());
				if(recentPropertyId == propertyId) {
					newCookie = cookieArray[i];
					cookieArray[i].setMaxAge(0);
					break;
				}
			}
		}
		if(DEBUG) {
			System.out.println("쿠키 사이즈(후) : " + cookieArray.length);
		}
		if(newCookie == null) {
			newCookie = new Cookie(cookieUser + "Property", String.valueOf(propertyId));
			newCookie.setMaxAge(2*60);
		}
		
		
		for(int i = cookieArray.length - 1; i >= 0; i--) {
			Integer recentPropertyId = Integer.valueOf(cookieArray[i].getValue());
			PropertyDTO recentProperty = propertyMapper.selectProperty(recentPropertyId);
			recentProperties.add(recentProperty);
		}
		req.setAttribute("recentProperties", recentProperties);
		
		req.setAttribute("tomorrow", getTomorrowString());
		req.setAttribute("dayAfterTomorrow", getDayAfterTomorrowString());
		req.setAttribute("property", property);
		
		req.setAttribute("wishLists", wishLists);
		
		return "property/property-detail";
	}
	
	// 1. 화면에 뿌려질 값들을 설정하는 단계
	@PostMapping("booking")
	public String booking(RedirectAttributes ra, @ModelAttribute BookingDTO booking) {
		
		PropertyDTO property = propertyMapper.selectProperty(booking.getPropertyId());
		
		ra.addFlashAttribute("booking", booking);
		ra.addFlashAttribute("property", property);
		
		return "redirect:/property/booking-check";
	}
	
	// 2. 페이지로 이동하는 단계
	// 새로고침은 여기로 바로 오기때문에 값이 없는 상태로 페이지로 가게 됨
	@GetMapping("booking-check")
	public String bookingCheck(HttpServletResponse resp){
		resp.setHeader("Expires", "-1");
		resp.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		resp.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
		resp.setHeader("Pragma", "no-cache");
		
		return "property/booking-check";
	}
	
	// 1. 결제요청 처리
	@PostMapping("booking-pay")
	public String bookingPay(HttpServletRequest req, RedirectAttributes ra,
			@ModelAttribute BookingDTO booking) {
		if(DEBUG) {
			System.out.println(booking);
		}
		
		Integer propertyId;
		try {
			propertyId = Integer.valueOf(req.getParameter("propertyId"));
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
		if(bookingMapper.insertBooking(booking) < 1) {
			req.setAttribute("msg", "예약 실패(DB 오류)");
			req.setAttribute("url", "/property/detail?propertyId=" + propertyId);
			return "message";
		}
		booking = bookingMapper.selectSameBooking(booking);
		if(DEBUG) {
			System.out.println(booking);
		}
		
		TransactionDTO transaction = new TransactionDTO();
		transaction.setBookingId(booking.getId());
		if(bookingMapper.insertTransaction(transaction) < 1) {
			req.setAttribute("msg", "결제 실패(DB 오류)");
			req.setAttribute("url", "/property/detail?propertyId=" + propertyId);
			return "message";
		}
		transaction = bookingMapper.selectSameTransaction(transaction);
		
		ra.addFlashAttribute("booking", booking);
		ra.addFlashAttribute("transaction", transaction);
		
		
		
		
		return "redirect:/property/booking-complete";
	}
	
	// 2. 화면에 결제정보 표시
	@GetMapping("booking-complete")
	public String bookingComplete(HttpServletResponse resp) {
		resp.setHeader("Expires", "-1"); 
		resp.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		resp.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
		resp.setHeader("Pragma", "no-cache");
		
		return "property/booking-complete";
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
