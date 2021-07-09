package com.airtnt.airtnt.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
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
	private final int debugIndex = 0;
	private final boolean debug = (this.debugIndex != 0);
	
	private final String encoding = Encoding.UTF_8;
	private final int cookieMaxAge = 5*Util.MINUTE;
	
	@Autowired
	private PropertyMapper propertyMapper;
	@Autowired
	private WishListMapper wishListMapper;
	@Autowired
	private BookingMapper bookingMapper;
	
	@GetMapping("search")
	public String search(HttpServletRequest req, HttpServletResponse resp,
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
		String currentURI = Util.getCurrentURI(req);
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
		List<PropertyTypeDTO> propertyTypes = propertyMapper.selectTypes(PropertyTypeDTO.class);
		List<RoomTypeDTO> roomTypes = propertyMapper.selectTypes(RoomTypeDTO.class);
		List<AmenityTypeDTO> amenityTypes = propertyMapper.selectTypes(AmenityTypeDTO.class);
		
		// 위시리스트
		Map<String, Object> wishMap = new Hashtable<>();
		String memberId = Util.getMemberId(req);
		if(memberId != null && !memberId.trim().equals("")) {
			wishMap.put("member_id", memberId);
		}
		List<WishListDTO> wishLists = wishListMapper.selectWishLists(wishMap);
		
		// 검색필터 checked, disabled 값 설정
		setFilter(propertyTypes, propertyTypeIdKeyArray, subPropertyTypeIdKeyArray);
		setFilter(roomTypes, roomTypeIdKeyArray);
		setFilter(amenityTypes, amenityTypeIdKeyArray);
		
		// 숙소 wished, unwished 여부 설정
		setWish(properties, wishLists);
		
		// 최근목록 조회
		List<PropertyDTO> recentProperties = loadRecentProperties(req, resp);
		
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
		
		// 달력에 비활성화를 하는 기준값
		List<BookingDTO> bookings = bookingMapper.selectFutureBookings(propertyId);
		if(debug) {
			for(BookingDTO booking : bookings) {
				System.out.println(booking);
			}
		}
		
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
		Cookie cookie = Util.getCookie(req, Util.RECENT_COOKIE_PREFIX + cookieUser);
		
		// 최근목록 조회 및 쿠키에 저장
		List<PropertyDTO> recentProperties = loadRecentProperties(cookie, resp);
		// 현재 보고있는 숙소는 현재 화면의 최근목록에 띄우지 않음
		saveRecentProperties(cookie, cookieUser, resp, propertyId);
		
		req.setAttribute("tomorrow", Util.getTomorrowString());
		req.setAttribute("dayAfterTomorrow", Util.getDayAfterTomorrowString());
		req.setAttribute("property", property);
		
		req.setAttribute("bookings", bookings);
		
		req.setAttribute("wishLists", wishLists);
		req.setAttribute("recentProperties", recentProperties);
		
		return "property/property-detail";
	}
	
	// 1. 화면에 뿌려질 값들을 설정하는 단계
	@PostMapping("booking")
	public String booking(RedirectAttributes ra, @ModelAttribute BookingDTO booking) {
		// params :
		// propertyId, hostId, guestId, dayCount, guestCount, totalPrice,
		// checkInDate, checkOutDate
		PropertyDTO property = propertyMapper.selectProperty(booking.getPropertyId());
		
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
		
		String bookingNumber = Util.getCurrentTimeStamp();
		// 타임스탬프 뒤에 0~9의 난수를 붙이고 그 뒤에 db에서 0~9의 시퀀스 사이클을 붙일 것임
		bookingNumber += String.valueOf((int)(Math.random() * 10));
		booking.setBookingNumber(bookingNumber);
		if(bookingMapper.insertBooking(booking) < 1) {
			req.setAttribute("msg", "예약 실패(DB 오류)");
			req.setAttribute("url", "/property/detail?propertyId=" + booking.getPropertyId());
			return "message";
		}
		booking = bookingMapper.selectSameBooking(booking);
		if(debug) {
			System.out.println(booking);
		}
		
		TransactionDTO transaction = new TransactionDTO();
		transaction.setBookingId(booking.getId());
		transaction.setSiteFee(0.05);
		if(bookingMapper.insertTransaction(transaction) < 1) {
			req.setAttribute("msg", "결제 실패(DB 오류)");
			req.setAttribute("url", "/property/detail?propertyId=" + booking.getPropertyId());
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
		// 헤더에 no cache 설정
		resp.setHeader("Expires", "-1"); 
		resp.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		resp.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
		resp.setHeader("Pragma", "no-cache");
		
		return "property/booking-complete";
	}
	
	public void setFilter(List<? extends AbstractTypeDTO> types, Integer[] paramArray) {
		setFilter(types, paramArray, null);
	}
	
	public void setFilter(List<? extends AbstractTypeDTO> types, Integer[] paramArray, Integer[] subParamArray) {
		if(paramArray != null && types != null) {
			outer: for(AbstractTypeDTO type : types) {
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
				}
				// 현재 유형이 체크된 유형 파라미터값이 아니면 여기로 넘어옴
				if(type instanceof PropertyTypeDTO) {
					PropertyTypeDTO propertyType = (PropertyTypeDTO)type;
					List<SubPropertyTypeDTO> subPropertyTypes = propertyType.getSubPropertyTypes();
					setFilter(subPropertyTypes, subParamArray);
				}
				
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
	
	public List<PropertyDTO> loadRecentProperties(
			HttpServletRequest req, HttpServletResponse resp) {
		// 로그인하지 않았다면 비회원 최근목록을 가져옴
		// 로그인중이라면 회원 최근목록을 가져옴
		String cookieUser = Util.getMemberId(req);
		if(cookieUser == null || cookieUser.trim().equals("")) {
			cookieUser = "non-member";
		}
		
		// 기존의 최근목록 쿠키가 있는지 찾아봄
		Cookie cookie = Util.getCookie(req, Util.RECENT_COOKIE_PREFIX + cookieUser);
		
		return loadRecentProperties(cookie, resp);
	}
	
	public List<PropertyDTO> loadRecentProperties(
			Cookie cookie, HttpServletResponse resp) {
		// 최근목록 조회
		List<PropertyDTO> recentProperties = null;
		
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
				recentProperties = propertyMapper.selectProperties(recentPropertyIdArray);

				// 쿠키에 등록되어있던 순서대로 정렬함(선택정렬)
				// 쿠키에 등록되어있던 값을 앞에서부터 읽으면서
				// id가 같은 숙소를 맨 뒤로 이동시키기를 반복하면
				// 쿠키에 등록되어있던 순서와 똑같이 정렬됨
				for(int i = 0; i < recentPropertyIdArray.length; i++) {
					inner: for(int j = 0; j < recentProperties.size(); j++) {
						PropertyDTO recentProperty = recentProperties.get(j);
						if(recentProperty.getId() == recentPropertyIdArray[i]) {
							recentProperties.remove(j);
							recentProperties.add(recentProperty);
							break inner;
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
		Cookie cookie = Util.getCookie(req, Util.RECENT_COOKIE_PREFIX + cookieUser);
		
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
				cookie = new Cookie(Util.RECENT_COOKIE_PREFIX + cookieUser, encodedCookieString);
				
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
				
				List<String> recentPropertyIdStrings =
						new ArrayList<>(Arrays.asList(decodedCookieString.split("%")));
				int[] recentPropertyIdArray =
						Numeric.toIntArray(recentPropertyIdStrings);
				if(debug) {
					System.out.print("최근목록 숙소 id :");
					for(String recentPropertyIdString : recentPropertyIdStrings) {
						System.out.print(" " + recentPropertyIdString);
					}
					System.out.println();
				}
				
				// 최근목록 변화 로직
				// 이전의 최근목록에 같은 숙소가 존재하고 있었다면 삭제함
				for(int i = 0; i < recentPropertyIdArray.length; i++) {
					if(recentPropertyIdArray[i] == propertyId) {
						recentPropertyIdStrings.remove(i);
						break;
					}
				}
				// 방금 본 목록을 쿠키 맨 앞에 추가함
				decodedCookieString = propertyId.toString();
				for(String recentPropertyIdString : recentPropertyIdStrings) {
					decodedCookieString += "%" + recentPropertyIdString;
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
