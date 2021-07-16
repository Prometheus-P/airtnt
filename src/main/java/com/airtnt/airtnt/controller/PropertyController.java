package com.airtnt.airtnt.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.airtnt.airtnt.model.*;
import com.airtnt.airtnt.service.BookingMapper;
import com.airtnt.airtnt.service.PropertyMapper;
import com.airtnt.airtnt.service.WishListMapper;
import com.airtnt.airtnt.util.*;

@Controller
@RequestMapping("property")
public class PropertyController {
	// debug index가 0이면 콘솔에 아무것도 안찍고 나머지는 다 콘솔에 찍음
	// 생성자 참고
	private final int debugIndex = 1;
	private final boolean debug = (this.debugIndex != 0);
	
	// 쿠키 수명
	// 월(1~12)*일(1~30)*시간(1~24)*분(1~60)*초(1~60)
	private static final int SECOND = 1;
	private static final int MINUTE = 60*SECOND;
	private static final int HOUR = 60*MINUTE;
	private static final int DAY = 24*HOUR;
	private static final int WEEK = 7*DAY;
	private static final int MONTH = 30*DAY;
	private static final int YEAR = 12*MONTH;
	
	private static final long MILLISECONDS_PER_DAY = 24*60*60*1000;
	
	private static final String RECENT_COOKIE_PREFIX = "AirTnT_recent_";
	
	private final String encoding = Encoding.UTF_8;
	private final int cookieMaxAge = 10*MINUTE;
	
	private final Integer numPerPage = 8;
	
	@Autowired
	private PropertyMapper propertyMapper;
	@Autowired
	private WishListMapper wishListMapper;
	@Autowired
	private BookingMapper bookingMapper;
	
	@GetMapping("search")
	public String search(HttpServletRequest req, HttpServletResponse resp,
			@RequestParam(value = "addressKey", required = false) String addressKey,
			@RequestParam(value = "tempAddressKey", required = false) String tempAddressKey,
			@RequestParam(value = "latitude", required = false) String latitude,
			@RequestParam(value = "longitude", required = false) String longitude,
			
			@RequestParam(value = "pageNum", required = false) Integer pageNum,
			
			@RequestParam(value = "propertyTypeId", required = false) Integer[] propertyTypeIdKeyArray,
			@RequestParam(value = "subPropertyTypeId", required = false) Integer[] subPropertyTypeIdKeyArray,
			@RequestParam(value = "roomTypeId", required = false) Integer[] roomTypeIdKeyArray,
			@RequestParam(value = "amenityTypeId", required = false) Integer[] amenityTypeIdKeyArray,
			@RequestParam(value = "guestCount", required = false) Integer guestCountKey,
			@RequestParam(value = "bedCount", required = false) Integer bedCountKey,
			@RequestParam(value = "minPrice", required = false) Integer minPriceKey,
			@RequestParam(value = "maxPrice", required = false) Integer maxPriceKey) {
		// 로그인 후 돌아갈 url
		String currentURI = Util.getCurrentURI(req);
		req.setAttribute("currentURI", currentURI);
		
		// 1. 예외를 일으킬 수 있는 파라미터값 보정
		if(tempAddressKey == null || tempAddressKey.trim().equals("")) {
			if(addressKey == null || addressKey.trim().equals("")) {
				addressKey = "서울";
				// 서울 시청
				latitude = "37.566826004661";
				longitude = "126.978652258309";
			} /*else {
				addressKey만 넘어왔으면 자동완성 주소로 넘어온 것임
			}*/
		} else {
			// 자동완성으로 검색하지 않아도 맨 상단에 있던 주소로 세팅
			addressKey = tempAddressKey;
		}
		
		if(addressKey == null || addressKey.trim().equals("")) {
			addressKey = "서울";
			// 서울 시청
			latitude = "37.566826004661";
			longitude = "126.978652258309";
		}
		
		if(latitude == null || latitude.trim().equals("") ||
				longitude == null || longitude.trim().equals("")) {
			addressKey = "서울";
			// 서울 시청
			latitude = "37.566826004661";
			longitude = "126.978652258309";
		}
		
		// 페이지
		if(pageNum == null || pageNum < 1) {
			pageNum = 1;
		}
		System.out.println("" + addressKey);
		System.out.println("" + tempAddressKey);
		System.out.println("" + latitude);
		System.out.println("" + longitude);
		
		// 2. 숙소목록 선택
		
		// 숙소 목록 선택 sql 조건문 맵
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
				{"maxPriceKey", maxPriceKey},
				{"latitude", latitude},
				{"longitude", longitude}
		};
		for(int i = 0; i < paramMatrix.length; i++) {
			if(paramMatrix[i][1] != null) {
				searchKeyMap.put((String)paramMatrix[i][0], paramMatrix[i][1]);
			}
		}
		
		// 전체 숙소 목록
		List<PropertyDTO> tempProperties = propertyMapper.searchProperties(searchKeyMap);
		// 총 페이지 수
		// = ceil(숙소 수 / 페이지당 숙소 수)
		// = floor((숙소 수 - 1 + 페이지당 숙소 수) / 페이지당 숙소 수)
		int totalPagesNum = (tempProperties.size() -1 + numPerPage) / numPerPage;
		if(totalPagesNum == 0) {
			// 로딩된 숙소가 없으면 1페이지로 유지
			totalPagesNum = 1;
		}
		// 현재 페이지 화면에 보여질 숙소 목록
		List<PropertyDTO> properties = getPageProperties(tempProperties, pageNum);
		setMainImage(properties);
		setRating(properties);
		
		
		// 3. 검색시 체크했던 필터 다시 셋팅
		
		// 검색 필터 목록
		List<PropertyTypeDTO> propertyTypes = propertyMapper.selectTypes(PropertyTypeDTO.class);
		List<RoomTypeDTO> roomTypes = propertyMapper.selectTypes(RoomTypeDTO.class);
		List<AmenityTypeDTO> amenityTypes = propertyMapper.selectTypes(AmenityTypeDTO.class);
		
		// 검색필터 checked, disabled 값 설정
		setFilter(propertyTypes, propertyTypeIdKeyArray, subPropertyTypeIdKeyArray);
		setFilter(roomTypes, roomTypeIdKeyArray);
		setFilter(amenityTypes, amenityTypeIdKeyArray);
		
		
		// 4. 숙소 목록 중 위시리스트 등록여부 체크
		
		// 위시리스트
		Map<String, Object> wishMap = new Hashtable<>();
		String memberId = Util.getMemberId(req);
		if(memberId != null && !memberId.trim().equals("")) {
			wishMap.put("member_id", memberId);
		}
		List<WishListDTO> wishLists = wishListMapper.selectWishLists(wishMap);
		
		// 숙소 wished, unwished 여부 설정
		setWish(properties, wishLists);
		
		
		// 5. 최근목록 조회
		
		// 최근목록 리스트는 LinkedList로 메모리를 배정하였으므로
		// ArrayList로 캐스팅하지 말것
		List<PropertyDTO> recentProperties = loadRecentProperties(req, resp);
		setMainImage(recentProperties);
		setRating(recentProperties);
		
		if(debug) {
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
			
			System.out.println(pageNum + "페이지");
			
			System.out.println("전체 페이지 수 : " + totalPagesNum);
			for(PropertyDTO property : properties) {
				System.out.println("rownum : " + property.getRowNum());
			}
			
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
			
			System.out.println("----- 후기 목록 -----");
			for(PropertyDTO property : properties) {
				if(property.getHost() != null) {
					System.out.println("호스트 : " +  property.getHost().getName());
				}
				System.out.println("숙소" + property.getId() + " 별점 : " + property.getRating());
				System.out.println("숙소" + property.getId() + "의 후기");
				List<ReviewDTO> reviews = property.getReviews();
				if(reviews != null) {
					for(ReviewDTO review : reviews) {
						System.out.println("이름 : " + review.getWriter().getName());
						System.out.println("내용 : " + review.getContent());
						if(review.getContent_host() != null) {
							System.out.println("호스트 답글 : " + review.getContent_host());
						}
					}
				}
			}
			System.out.println("---------------------------------------");
		}
		
		req.setAttribute("addressKey", addressKey);
		req.setAttribute("latitude", latitude);
		req.setAttribute("longitude", longitude);
		
		// 숙소 목록
		req.setAttribute("properties", properties);
		
		// 페이징 처리값
		req.setAttribute("totalPagesNum", totalPagesNum);
		
		// 검색 필터 목록
		req.setAttribute("propertyTypes", propertyTypes);
		req.setAttribute("roomTypes", roomTypes);
		req.setAttribute("amenityTypes", amenityTypes);
		
		// 위시리스트 목록
		req.setAttribute("wishLists", wishLists);
		
		// 최근 목록
		req.setAttribute("recentProperties", recentProperties);
		
		return "property/property-list";
	}

	@GetMapping("detail")
	public String detail(HttpServletRequest req, HttpServletResponse resp,
			@RequestParam("propertyId") Integer propertyId) {
		// 로그인 후 돌아갈 url
		String currentURI = Util.getCurrentURI(req);
		req.setAttribute("currentURI", currentURI);
		if(debug) {
			System.out.println(currentURI);
		}
		
		PropertyDTO property = propertyMapper.selectProperty(propertyId);
		setMainImage(property);
		
		// 달력에 비활성화를 하는 기준값
		List<BookingDTO> bookings = bookingMapper.selectFutureBookings(propertyId);
		// 체크인 날짜부터 체크아웃 전날까지 비활성화
		List<String> invalidDates = getInvalidDates(bookings);
		
		// 위시리스트
		Map<String, Object> wishMap = new Hashtable<>();
		String memberId = Util.getMemberId(req);
		if(memberId != null && !memberId.trim().equals("")) {
			wishMap.put("member_id", memberId);
		}
		List<WishListDTO> wishLists = wishListMapper.selectWishLists(wishMap);
		
		// 숙소 wished, unwished 여부 설정
		setWish(property, wishLists);
		
		// 로그인하지 않았다면 비회원 최근목록에 저장
		// 로그인중이라면 회원 최근목록에 저장
		String cookieUser = memberId;
		if(memberId == null || memberId.trim().equals("")) {
			cookieUser = "non-member";
		}
		
		// 기존의 최근목록 쿠키가 있는지 찾아봄
		Cookie cookie = Util.getCookie(req, RECENT_COOKIE_PREFIX + cookieUser);
		
		// 최근목록 조회 및 쿠키에 저장
		// 최근목록 리스트는 LinkedList로 메모리를 배정하였으므로
		// ArrayList로 캐스팅하지 말것
		List<PropertyDTO> recentProperties = loadRecentProperties(cookie, resp);
		setMainImage(recentProperties);
		setRating(property);
		
		// 현재 보고있는 숙소는 현재 화면의 최근목록에 적용시키지 않음
		saveRecentProperties(cookie, cookieUser, resp, propertyId);
		
		req.setAttribute("tomorrow", Util.getTomorrowString());
		req.setAttribute("dayAfterTomorrow", Util.getDayAfterTomorrowString());
		req.setAttribute("property", property);
		
		req.setAttribute("invalidDates", invalidDates);
		
		req.setAttribute("wishLists", wishLists);
		req.setAttribute("recentProperties", recentProperties);
		
		return "property/property-detail";
	}
	
	// 1. 화면에 뿌려질 값들을 설정하는 단계
	@PostMapping("booking")
	public String booking(HttpServletRequest req, RedirectAttributes ra, @ModelAttribute BookingDTO booking) {
		// params :
		// propertyId, hostId, guestId, dayCount, guestCount, totalPrice,
		// checkInDate, checkOutDate
		PropertyDTO property = propertyMapper.selectProperty(booking.getPropertyId());
		setMainImage(property);
		
		// 동시에 예약이 들어올 시 중복예약을 검사
		List<BookingDTO> overlapBookings =
				bookingMapper.selectOverlapBookings(booking);
		if(debug) {
			System.out.println("겹치는 예약 수 : " + overlapBookings.size());
		}
		if(overlapBookings.size() > 0) {
			if(debug) {
				System.out.println("겹치는 예약 :");
				for(int i = 0; i < overlapBookings.size(); i++) {
					BookingDTO overlapBooking = overlapBookings.get(i);
					System.out.println(i + "번");
					System.out.println("체크인 : " + overlapBooking.getCheckInDate());
					System.out.println("체크아웃 : " + overlapBooking.getCheckOutDate());
				}
			}
			req.setAttribute("msg", "이미 예약된 날짜가 존재합니다.");
			req.setAttribute("url", "/property/detail?" + booking.getPropertyId());
			return "message";
		}
		
		ra.addFlashAttribute("booking", booking);
		ra.addFlashAttribute("property", property);
		
		return "redirect:/property/booking-check";
	}
	
	// 2. 페이지로 이동하는 단계
	// 새로고침은 여기로 바로 오기때문에 값이 없는 상태로 페이지로 가게 됨
	@GetMapping("booking-check")
	public String bookingCheck(HttpServletResponse resp){
		// 헤더에 no cache 설정
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
		if(debug) {
			System.out.println(booking);
		}
		
		// 동시에 예약이 들어올 시 중복예약을 검사
		List<BookingDTO> overlapBookings =
				bookingMapper.selectOverlapBookings(booking);
		if(debug) {
			System.out.println("겹치는 예약 수 : " + overlapBookings.size());
		}
		if(overlapBookings.size() > 0) {
			if(debug) {
				System.out.println("겹치는 예약 :");
				for(int i = 0; i < overlapBookings.size(); i++) {
					BookingDTO overlapBooking = overlapBookings.get(i);
					System.out.println(i + "번");
					System.out.println("체크인 : " + overlapBooking.getCheckInDate());
					System.out.println("체크아웃 : " + overlapBooking.getCheckOutDate());
				}
			}
			req.setAttribute("msg", "이미 예약된 날짜가 존재합니다.");
			req.setAttribute("url", "/property/detail?" + booking.getPropertyId());
			return "message";
		}
		
		int bookingId = bookingMapper.selectBookingId();
		String bookingNumber = Util.getCurrentTimeStamp();
		// 타임스탬프 뒤에 0~9의 난수를 붙이고 그 뒤에 db에서 0~9의 시퀀스 사이클을 붙일 것임
		bookingNumber += String.valueOf((int)(Math.random() * 10));
		booking.setId(bookingId);
		booking.setBookingNumber(bookingNumber);
		if(bookingMapper.insertBooking(booking) < 1) {
			req.setAttribute("msg", "예약 실패(DB 오류)");
			req.setAttribute("url", "/property/detail?propertyId=" + booking.getPropertyId());
			return "message";
		}
		booking = bookingMapper.selectBooking(bookingId);
		if(debug) {
			System.out.println(booking);
		}
		
		int transactionId = bookingMapper.selectTransactionId();
		TransactionDTO transaction = new TransactionDTO();
		transaction.setId(transactionId);
		transaction.setBookingId(booking.getId());
		transaction.setSiteFee(0.05);
		if(bookingMapper.insertTransaction(transaction) < 1) {
			bookingMapper.deleteBooking(booking.getId());
			req.setAttribute("msg", "결제 실패(DB 오류)");
			req.setAttribute("url", "/property/detail?propertyId=" + booking.getPropertyId());
			return "message";
		}
		transaction = bookingMapper.selectTransaction(transactionId);
		
		ra.addFlashAttribute("booking", booking);
		ra.addFlashAttribute("transaction", transaction);
		
		return "redirect:/property/booking-complete";
	}
	
	// 2. 화면에 결제정보 표시
	@GetMapping("booking-complete")
	public String bookingComplete(HttpServletResponse resp) {
		// 헤더에 no cache 설정
		resp.setHeader("Expires", "-1"); 
		resp.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		resp.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
		resp.setHeader("Pragma", "no-cache");
		
		return "property/booking-complete";
	}
	
	public List<PropertyDTO> getPageProperties(List<PropertyDTO> tempProperties, int pageNum){
		List<PropertyDTO> properties = new ArrayList<>();
		int maxRownum = tempProperties.size();
		if(maxRownum > 0) {
			// List에 접근할 인덱스 값
			int lastIndex = maxRownum - 1;
			// List 인덱스의 이상, 미만 값
			int greaterEqualIndex, lessThanIndex;
			
			// 숙소 목록의 시작과 끝 인덱스
			// 인덱스 == rownum - 1
			// 0 ~ 4, 5 ~ 9, 10 ~ 14, ...
			greaterEqualIndex = numPerPage * (pageNum - 1);	// 이상
			lessThanIndex = numPerPage * pageNum;	// 미만
			
			// 페이지에 띄울 숙소 목록 저장
			for(int i = greaterEqualIndex; i < lessThanIndex && i <= lastIndex; i++) {
				properties.add(tempProperties.get(i));
			}
		}
		return properties;
	}
	
	public void setMainImage(PropertyDTO property) {
		if(property == null) {
			return;
		}
		List<PropertyDTO> properties = new ArrayList<>();
		properties.add(property);
		setMainImage(properties);
	}
	
	public void setMainImage(List<PropertyDTO> properties) {
		if(properties == null) {
			return;
		}
		for(PropertyDTO property : properties) {
			List<ImageDTO> images = property.getImages();
			if(images != null) {
				for(int i = 0; i < images.size(); i++) {
					ImageDTO image = images.get(i);
					if(image.getIsMain() == 'Y' || image.getIsMain() == 'y') {
						images.add(0, images.remove(i));
						break;
					}
				}
			}
		}
	}
	
	public void setFilter(List<? extends AbstractTypeDTO> types, Integer[] paramArray) {
		setFilter(types, paramArray, null);
	}
	
	public void setFilter(List<? extends AbstractTypeDTO> types, Integer[] paramArray, Integer[] subParamArray) {
		outer: for(AbstractTypeDTO type : types) {
			if(paramArray != null) {
				for(int i = 0; i < paramArray.length; i++) {
					if(type.getId() == paramArray[i]) {
						type.putTagAttributeMapValue(TagAttribute.CHECKED);
						if(type instanceof PropertyTypeDTO) {
							PropertyTypeDTO propertyType = (PropertyTypeDTO)type;
							List<SubPropertyTypeDTO> subPropertyTypes = propertyType.getSubPropertyTypes();
							if(subPropertyTypes != null) {
								for(SubPropertyTypeDTO subPropertyType : subPropertyTypes) {
									subPropertyType.putTagAttributeMapValue(TagAttribute.DISABLED);
								}
							}
						}
						continue outer;
					}
				} // end of for문 of paramArray
			}
			// 현재 유형이 체크된 유형 파라미터값이 아니면 여기로 넘어옴
			if(type instanceof PropertyTypeDTO) {
				PropertyTypeDTO propertyType = (PropertyTypeDTO)type;
				List<SubPropertyTypeDTO> subPropertyTypes = propertyType.getSubPropertyTypes();
				setFilter(subPropertyTypes, subParamArray);
			}
		}
	}
	
	public void setWish(PropertyDTO property, List<WishListDTO> wishLists) {
		List<PropertyDTO> properties = new ArrayList<>();
		properties.add(property);
		setWish(properties, wishLists);
	}
	
	public void setWish(List<PropertyDTO> properties, List<WishListDTO> wishLists) {
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
	}
	
	public List<String> getInvalidDates(List<BookingDTO> bookings) {
		List<String> invalidDates = new ArrayList<>();
		if(bookings.size() != 0) {
			long todayToTime = new java.util.Date().getTime();
			for(BookingDTO booking : bookings) {
				long checkInDateToTime = booking.getCheckInDate().getTime();
				long checkOutDateToTime = booking.getCheckOutDate().getTime();
				// 체크인 날짜부터 체크아웃 날짜 하루 전까지 돌리며 invalid 날짜 추가
				for(long time = checkInDateToTime;
						time < checkOutDateToTime; time += MILLISECONDS_PER_DAY) {
					if(time >= todayToTime) {
						// 자바스크립트에서 바로 배열로 받기위해 따옴표를 붙임
						invalidDates.add("\"" + new java.sql.Date(time).toString() + "\"");
					}
				}
			}
		}
		return invalidDates;
	}
	
	public void setRating(PropertyDTO property) {
		if(property == null) {
			return;
		}
		
		List<PropertyDTO> properties = new ArrayList<>();
		properties.add(property);
		setRating(properties);
	}
	
	public void setRating(List<PropertyDTO> properties) {
		if(properties == null) {
			return;
		}
		
		for(PropertyDTO property : properties) {
			String ratingStr = "0.00";
			List<ReviewDTO> reviews = property.getReviews();
			if(reviews != null && reviews.size() > 0) {
				double rating = 0.0;
				for(ReviewDTO review : reviews) {
					rating += review.getRating();
					System.out.println(rating);
				}
				ratingStr = String.format("%.2f", rating);
			}
			property.setRating(ratingStr);
		}
	}
	
	public List<PropertyDTO> loadRecentProperties(
			HttpServletRequest req, HttpServletResponse resp) {
		// 로그인하지 않았다면 비회원 최근목록을 가져옴
		// 로그인중이라면 회원 최근목록을 가져옴
		String cookieUser = Util.getMemberId(req);
		if(cookieUser == null || cookieUser.trim().equals("")) {
			cookieUser = "non-member";
		}
		
		// 기존의 최근목록 쿠키가 있는지 찾아봄
		Cookie cookie = Util.getCookie(req, RECENT_COOKIE_PREFIX + cookieUser);
		
		return loadRecentProperties(cookie, resp);
	}
	
	public List<PropertyDTO> loadRecentProperties(
			Cookie cookie, HttpServletResponse resp) {
		// 최근목록 조회
		LinkedList<PropertyDTO> recentProperties = null;
		
		if(cookie != null) {
			String encodedCookieString = cookie.getValue();
			String decodedCookieString = null;
			
			try {
				decodedCookieString =
						URLDecoder.decode(encodedCookieString, encoding);
				if(debug) {
					System.out.println("최근목록 로딩 : 디코딩 전");
					System.out.println(encodedCookieString);
					System.out.println("최근목록 로딩 : 디코딩 후");
					System.out.println(decodedCookieString);
				}
				
				int[] recentPropertyIdArray =
						Numeric.toIntArray(decodedCookieString.split("%"));
				recentProperties = new LinkedList<>(propertyMapper.selectProperties(recentPropertyIdArray));
				
				// 쿠키에 등록되어있던 순서대로 정렬함(선택정렬)
				// 쿠키에 등록되어있던 값을 순서대로 읽으면서
				// id가 같은 숙소를 맨 뒤로 이동시키기를 반복하면
				// 쿠키에 등록되어있던 순서와 똑같이 정렬됨
				outer: for(int i = 0; i < recentPropertyIdArray.length; i++) {
					for(int j = 0; j < recentProperties.size(); j++) {
						if(recentProperties.get(j).getId() == recentPropertyIdArray[i]) {
							recentProperties.add(recentProperties.remove(j));
							continue outer;
						}
					}
				}
				
			} catch(UnsupportedEncodingException e) {
				e.printStackTrace();
				System.out.println("최근목록 로딩 : 디코딩 문제 발생");

				cookie.setValue(null);
				cookie.setMaxAge(0);
				resp.addCookie(cookie);
			}
		}
		return recentProperties;
	}
	
	public boolean saveRecentProperties(
			HttpServletRequest req, HttpServletResponse resp, Integer propertyId) {
		// 로그인하지 않았다면 비회원 최근목록을 가져옴
		// 로그인중이라면 회원 최근목록을 가져옴
		String cookieUser = Util.getMemberId(req);
		if(cookieUser == null || cookieUser.trim().equals("")) {
			cookieUser = "non-member";
		}

		// 기존의 최근목록 쿠키가 있는지 찾아봄
		Cookie cookie = Util.getCookie(req, RECENT_COOKIE_PREFIX + cookieUser);
		
		return saveRecentProperties(cookie, cookieUser, resp, propertyId);
	}
	
	public boolean saveRecentProperties(
			Cookie cookie, String memberId, HttpServletResponse resp, Integer propertyId) {
		
		String decodedCookieString = null;
		String encodedCookieString = null;
		if(cookie == null) {
			// 기존의 최근목록 쿠키가 없으면 쿠키를 생성
			// 최근목록에는 저장하지 않음
			String cookieUser = memberId;
			if(cookieUser == null || cookieUser.trim().equals("")) {
				cookieUser = "non-member";
			}
			
			decodedCookieString = propertyId.toString();
			if(debug) {
				System.out.println("최근목록 저장 : 인코딩 전");
				System.out.println(decodedCookieString);
			}
			
			try {
				encodedCookieString =
						URLEncoder.encode(decodedCookieString, encoding);
				if(debug) {
					System.out.println("최근목록 저장 : 인코딩 후");
					System.out.println(encodedCookieString);
				}
				cookie = new Cookie(RECENT_COOKIE_PREFIX + cookieUser, encodedCookieString);
				
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
				System.out.println("최근목록 저장 : 인코딩 문제 발생");
			}
			
		} else {
			// 최근목록이 있으면 원래의 쿠키값 내에서 비교하여
			// 같은 값이 있으면 삭제하고 현재 값을 최근으로 올림
			encodedCookieString = cookie.getValue();
			if(debug) {
				System.out.println("최근목록 저장 : 디코딩 전");
				System.out.println(encodedCookieString);
			}
			
			try {
				// 여기서 예외가 발생하면 decodedCookieString은 null 이다
				decodedCookieString =
						URLDecoder.decode(encodedCookieString, encoding);
				if(debug) {
					System.out.println("최근목록 저장 : 디코딩 후");
					System.out.println(decodedCookieString);
				}
				
				LinkedList<Integer> recentPropertyIdsQueue =
						new LinkedList<>(Numeric.toIntegerList(decodedCookieString.split("%")));
				if(debug) {
					System.out.print("최근목록 숙소 id :");
					for(Integer recentPropertyId : recentPropertyIdsQueue) {
						System.out.print(" " + recentPropertyId);
					}
					System.out.println();
				}
				
				// 최근목록 변화 로직
				// 큐를 쓰면 중간의 값을 버려도 인덱스에 구애받지 않고
				// 항상 그다음 최근값을 가져올 수 있음
				
				// 방금 본 목록을 새로운 쿠키 맨 앞에 추가함
				decodedCookieString = propertyId.toString();
				// 최근목록 갯수는 최대 12개 제한
				int i = 0;
				while(i < 12 && !recentPropertyIdsQueue.isEmpty()) {
					Integer recentPropertyId = recentPropertyIdsQueue.poll();
					if(recentPropertyId != propertyId) {
						// 현재 보고있는 숙소와 같지 않은것만 저장함
						decodedCookieString += "%" + recentPropertyId.toString();
					}
				}
				
				// 브라우저에 저장될 문자열로 인코딩
				// 여기서 예외가 발생하면 decodedCookieString은 null이 아님
				encodedCookieString =
						URLEncoder.encode(decodedCookieString, encoding);
				if(debug) {
					System.out.println("최근목록 저장 : 인코딩 후");
					System.out.println(encodedCookieString);
				}
				
				cookie.setValue(encodedCookieString);
				
			} catch(UnsupportedEncodingException e) {
				e.printStackTrace();
				if(decodedCookieString == null) {
					System.out.println("최근목록 저장 : 디코딩 문제 발생");
				} else {
					System.out.println("최근목록 저장 : 인코딩 문제 발생");
				}
				
				cookie.setValue(null);
			}
		}
		
		// 새로운 쿠키 생성에서 오류가 났으면 쿠키가 아예 없음
		if(cookie != null) {
			if(cookie.getValue() != null) {
				// 인코딩 오류가 없었으면 쿠키 수명 갱신
				cookie.setMaxAge(cookieMaxAge);
				resp.addCookie(cookie);
				
				return true;
				
			} else {
				// 인코딩 오류가 있었으면 사용자 브라우저에서 쿠키 삭제
				cookie.setValue(null);
				cookie.setMaxAge(0);
				resp.addCookie(cookie);
			}
		}
		
		return false;
	}

}
