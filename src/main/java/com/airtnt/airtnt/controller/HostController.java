package com.airtnt.airtnt.controller;

import java.io.File;

import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.airtnt.airtnt.interceptor.LoginInterceptor;
import com.airtnt.airtnt.model.AmenityDTO;
import com.airtnt.airtnt.model.AmenityTypeDTO;
import com.airtnt.airtnt.model.BookingDTO;
import com.airtnt.airtnt.model.GuideContextDTO;
import com.airtnt.airtnt.model.GuideDTO;
import com.airtnt.airtnt.model.ImageDTO;
import com.airtnt.airtnt.model.PropertyDTO;
import com.airtnt.airtnt.model.PropertyTypeDTO;
import com.airtnt.airtnt.model.ReviewDTO;
import com.airtnt.airtnt.model.RoomTypeDTO;
import com.airtnt.airtnt.model.SubPropertyTypeDTO;
import com.airtnt.airtnt.model.TransactionDTO;
import com.airtnt.airtnt.service.HostMapper;

@Controller
@SuppressWarnings("unchecked")
public class HostController implements HostControllerInterface {
	@Autowired
	private HostMapper hostMapper;

	// 1. 호스트 시작하기 >>으로 이동
	// 나머지는 게시판
	@Override
	@RequestMapping("guide_home")
	public ModelAndView guide_home() {
		List<GuideDTO> listGuide = hostMapper.getGuideList();
		// System.out.print(guideList.get(0).getId());
		return new ModelAndView("host/guide/guide_home", "listGuide", listGuide);
	}

	@Override
	@RequestMapping("guide_context")
	public ModelAndView guide_context(@RequestParam int id) {
		GuideDTO guideDTO = hostMapper.getGuide(id);
		List<GuideDTO> guideList = hostMapper.getGuideList();
		guideList.removeIf(dto -> {
			boolean isRemove = false;
			if (dto.getId() == id)
				isRemove = true;
			return isRemove;
		});
		List<GuideContextDTO> listGuideContext = hostMapper.getGuideContext(id);
		ModelAndView mav = new ModelAndView("host/guide/guide_context");
		mav.addObject("guideDTO", guideDTO);
		mav.addObject("listGuideContext", listGuideContext);
		mav.addObject("guideList", guideList);
		return mav;
	}

	//////////////////////////////////////////////////////////////////////////////////////
	// 2. property_type_0으로 이동해서 분류 시작
	//////////////////////////////////////////////////////////////////////////////////////

	@RequestMapping("host/property_insert")
	public ModelAndView property_type_0_new(HttpSession session) {
		session.removeAttribute("propertyTypeId");
		session.removeAttribute("propertyTypeName");
		session.removeAttribute("subPropertyTypeId");
		session.removeAttribute("subPropertyTypeName");
		session.removeAttribute("roomTypeId");
		session.removeAttribute("roomTypeName");
		session.removeAttribute("address");
		session.removeAttribute("bedCount");
		session.removeAttribute("maxGuest");
		session.removeAttribute("listImgUrl");
		session.removeAttribute("description");
		session.removeAttribute("name");
		session.removeAttribute("listAmenity");
		session.removeAttribute("price");
		Enumeration<String> emu = session.getAttributeNames();
		System.out.println("====세션에 담긴 값====");
		while (emu.hasMoreElements()) {
			String name = emu.nextElement();
			Object attrValue = session.getAttribute(name);
			System.out.println(name + ": " + attrValue);
		}
		List<PropertyTypeDTO> listPropertyType = hostMapper.getPropertyType();
		return new ModelAndView("host/property_insert/property_type_0", "listPropertyType", listPropertyType);
	}

	@Override
	@RequestMapping("host/property_type_0")
	public ModelAndView property_type_0() {
		List<PropertyTypeDTO> listPropertyType = hostMapper.getPropertyType();
		return new ModelAndView("host/property_insert/property_type_0", "listPropertyType", listPropertyType);
	}

	@Override
	@RequestMapping("host/sub_property_type_1")
	public ModelAndView sub_property_type_1(HttpSession session,
			@RequestParam(value = "propertyTypeId") Integer propertyTypeId,
			@RequestParam(value = "propertyTypeName") String propertyTypeName) {
		session.setAttribute("propertyTypeId", propertyTypeId);
		session.setAttribute("propertyTypeName", propertyTypeName);
		List<SubPropertyTypeDTO> listSubPropertyType = hostMapper.getSubPropertyType(propertyTypeId);
		return new ModelAndView("host/property_insert/sub_property_type_1", "listSubPropertyType", listSubPropertyType);
	}

	@Override
	@RequestMapping("host/room_type_2")
	public ModelAndView room_type_2(HttpSession session,
			@RequestParam(value = "subPropertyTypeId") Integer subPropertyTypeId,
			@RequestParam(value = "subPropertyTypeName") String subPropertyTypeName) {
		session.setAttribute("subPropertyTypeId", subPropertyTypeId);
		session.setAttribute("subPropertyTypeName", subPropertyTypeName);
		List<RoomTypeDTO> listRoomType = hostMapper.getRoomType();
		ModelAndView mav = new ModelAndView("host/property_insert/room_type_2");
		mav.addObject("listRoomType", listRoomType);
		return mav;
	}

	@Override
	@RequestMapping("host/address_3")
	public String address_3(HttpSession session, @RequestParam(value = "roomTypeId") Integer roomTypeId,
			@RequestParam(value = "roomTypeName") String roomTypeName) {
		session.setAttribute("roomTypeId", roomTypeId);
		session.setAttribute("roomTypeName", roomTypeName);
		return "host/property_insert/address_3";
	}

	@Override
	@RequestMapping("host/floor_plan_4")
	public String floor_plan_4(HttpSession session, @RequestParam Map<String, String> param) {
		session.setAttribute("checkAddress", param.get("address"));
		session.setAttribute("address", param.get("address") + " " + param.get("addressDetail"));
		session.setAttribute("latitude", param.get("latitude"));
		session.setAttribute("logitude", param.get("longitude"));

		System.out.println("위도: " + param.get("latitude"));
		System.out.println("경도: " + param.get("longitude"));
		System.out.println(param.get("address"));
		System.out.println("상세: " + param.get("addressDetail"));
		return "host/property_insert/floor_plan_4";
	}

	@Override
	@RequestMapping("host/amenities_5")
	public ModelAndView amenities_5(HttpSession session, @RequestParam(value = "maxGuest") Integer maxGuest,
			@RequestParam(value = "bedCount") Integer bedCount) {
		session.setAttribute("maxGuest", maxGuest);
		session.setAttribute("bedCount", bedCount);
		List<AmenityTypeDTO> list = hostMapper.getAmenityTypeList();
		session.setAttribute("list", list);
		return new ModelAndView("/host/property_insert/amenities_5", "listAmenityType", list);
	}

	@Override
	@RequestMapping("host/photos_6")
	public String photos_6(HttpSession session,
			@RequestParam(value = "listAmenity", required = true) List<Integer> amenities) {
		List<AmenityTypeDTO> listAmenity = (List<AmenityTypeDTO>) session.getAttribute("list");
		listAmenity.removeIf(dto -> {
			boolean isRemove = true;
			for (int id : amenities) {
				if (dto.getId() == id) {
					isRemove = false;
					break;
				}
			}
			return isRemove;
		});
		session.removeAttribute("list");
		session.setAttribute("listAmenity", listAmenity);

		return "/host/property_insert/photos_6";
	}

	@Override
	@ResponseBody
	@RequestMapping(value = "/host/file-upload", method = RequestMethod.POST)
	public String photos_upload(@RequestParam("article_file") List<MultipartFile> multipartFile, HttpSession session) {
		String strResult = "{ \"result\":\"FAIL\" }";
		long sizeSum = 0;
		List<ImageDTO> listImgUrl = new ArrayList<>();
		try {
			// 파일이 있을때 탄다.
			if (multipartFile.size() > 0 && !multipartFile.get(0).getOriginalFilename().equals("")) {
				for (MultipartFile file : multipartFile) {
					String originalFileName = file.getOriginalFilename(); // 오리지날 파일명
					long time = System.currentTimeMillis();
					String savedFileName = time + "-" + originalFileName; // 저장될 파일 명
					// String upPath =
					// "C:\\Users\\Haseong\\git\\airtnt\\src\\main\\webapp\\resources\\files\\property\\property-";
					String upPath = "C:\\Users\\woosuki\\git\\airtnt\\src\\main\\webapp\\resources\files\\property\\sproperty-";
					// 정석
					// String upPath =
					// "C:\\Spring\\EZEN\\workspace\\AirTnT\\src\\main\\webapp\\resources\\files\\property\\property-";
					// HS >>
					// D:\bigdata\study3\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\airtnt\resources\files\property

					if (!isValidExtension(originalFileName)) { // 확장자 검사
						return strResult = "{ \"result\":\"UNACCEPTED_EXTENSION\" }";
					}

					sizeSum += file.getSize(); // 사진의 총 사이즈 검사
					if (sizeSum >= 5 * 1024 * 1024) { // 500MB
						return strResult = "{ \"result\":\"EXCEED_SIZE\" }";
					}

					String nameForShow = "/resources/files/property/property-" + savedFileName;
					File targetFile = new File(upPath + savedFileName);
					try {
						InputStream fileStream = file.getInputStream();
						FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
						ImageDTO dto = new ImageDTO();
						dto.setFileSize(file.getSize());
						dto.setPath(nameForShow);
						listImgUrl.add(dto);
						System.out.println("사진 주소: " + nameForShow);
					} catch (Exception e) {
						// 파일삭제
						FileUtils.deleteQuietly(targetFile); // 저장된 현재 파일 삭제
						e.printStackTrace();
						break;
					}
				}
				session.setAttribute("listImgUrl", listImgUrl); // 바로 img 태그의 src에 넣으면 됨
				strResult = "{ \"result\":\"OK\" }";
			} else {
				strResult = "{ \"result\":\"NO_IMAGE\" }";
			}
		} catch (Exception e) {
			System.out.println("예외발생!!");
			e.printStackTrace();
		}
		return strResult;
	}

	private boolean isValidExtension(String originalName) {
		String originalNameExtension = originalName.substring(originalName.lastIndexOf(".") + 1);
		switch (originalNameExtension) {
		case "jpg":
		case "png":
		case "gif":
		case "bmp":
			return true;
		}
		return false;
	}

	@Override
	@RequestMapping("host/name_description_7")
	public String name_description_7() {
		return "/host/property_insert/name_description_7";
	}

	@Override
	@RequestMapping("host/price_8")
	public String price_8(HttpSession session, @RequestParam(value = "name") String name,
			@RequestParam(value = "description") String description) {
		session.setAttribute("name", name);
		session.setAttribute("description", description);
		return "/host/property_insert/price_8";
	}

	@Override
	@RequestMapping("host/preview_9")
	public String preview_9(HttpSession session, @RequestParam(value = "price") int price) {
		session.setAttribute("price", price);
		return "/host/property_insert/preview_9";
	}

	@Override
	@ResponseBody
	@RequestMapping("host/property_save")
	public String property_save(HttpSession session) {
		session.setAttribute("isMemberMode", true);
		List<AmenityTypeDTO> listAmenity = (List<AmenityTypeDTO>) session.getAttribute("listAmenity");
		List<ImageDTO> listImgUrl = (List<ImageDTO>) session.getAttribute("listImgUrl");
		String hostId = (String) session.getAttribute("member_id");

		PropertyDTO dtoPro = new PropertyDTO();
		dtoPro.setHostId(hostId);
		dtoPro.setPropertyTypeId((int) session.getAttribute("propertyTypeId"));
		dtoPro.setSubPropertyTypeId((int) session.getAttribute("subPropertyTypeId"));
		dtoPro.setRoomTypeId((int) session.getAttribute("roomTypeId"));
		dtoPro.setAddress((String) session.getAttribute("address"));
		dtoPro.setBedCount((int) session.getAttribute("bedCount"));
		dtoPro.setMaxGuest((int) session.getAttribute("maxGuest"));
		dtoPro.setName((String) session.getAttribute("name"));
		dtoPro.setPropertyDesc((String) session.getAttribute("description"));
		dtoPro.setPrice((int) session.getAttribute("price"));
		dtoPro.setLatitude((String) session.getAttribute("latitude"));
		dtoPro.setLongitude((String) session.getAttribute("longitude"));

		int propertyOk = hostMapper.insertProperty(dtoPro); // 1. property입력

		int propertyId = hostMapper.getPropertyId(hostId); // 2. propertyId 가져오기
		for (AmenityTypeDTO dto : listAmenity) {
			dto.setPropertyId(propertyId);
		}
		for (ImageDTO dto : listImgUrl) {
			dto.setPropertyId(propertyId);
		}
		listImgUrl.get(0).setIsMain('Y'); // 메인 사진 설정
		int amenityOk = hostMapper.insertListAmenity(listAmenity); // 3. 편의시설 입력
		int imageOk = hostMapper.imageInsert(listImgUrl); // 4. 숙소 사진 입력
		int memberChangeOk = hostMapper.updateMemberMode(hostId); // 5. 멤버모드 변경 1 -> 2

		if (propertyOk <= 0) {
			System.out.println("PROPERTY_ERROR");
			return "{ \"result\":\"PROPERTY_ERROR\" }";
		} else if (amenityOk <= 0) {
			System.out.println("AMENITY_ERROR");
			return "{ \"result\":\"AMENITY_ERROR\" }";
		} else if (imageOk <= 0) {
			System.out.println("IMAGE_ERROR");
			return "{ \"result\":\"IMAGE_ERROR\" }";
		} else if (memberChangeOk <= 0) {
			System.out.println("MEMBER_CHANGE_ERROR");
			return "{ \"result\":\"MEMBER_CHANGE_ERROR\" }";
		}
		session.removeAttribute("propertyTypeId");
		session.removeAttribute("propertyTypeName");
		session.removeAttribute("subPropertyTypeId");
		session.removeAttribute("subPropertyTypeName");
		session.removeAttribute("roomTypeId");
		session.removeAttribute("roomTypeName");
		session.removeAttribute("address");
		session.removeAttribute("bedCount");
		session.removeAttribute("maxGuest");
		session.removeAttribute("description");
		session.removeAttribute("name");
		session.removeAttribute("listAmenities");
		session.removeAttribute("price");
		session.removeAttribute("listImgUrl");
		session.removeAttribute("latitude");
		session.removeAttribute("longitude");
		// 사진도 지우기
		return "{ \"result\":\"OK\" }";
	}

	//////////////////////////////////////////////////////////////////////////////////////
	// 3. host_mode 페이지
	//////////////////////////////////////////////////////////////////////////////////////

	@Override
	@RequestMapping("host/host_mode")
	public ModelAndView host_mode(HttpSession session) {
		String hostId = (String) session.getAttribute("member_id");
		List<BookingDTO> listBooking = hostMapper.getBookingList(hostId);

		listBooking.removeIf(dto -> {
			boolean isRemove = false;
			if (dto.getBookingNumber().equals("-1"))
				isRemove = true;
			return isRemove;
		});
		/*
		 * for(int i=0; i<listBooking.size(); ++i) {
		 * if(listBooking.get(i).getBooking_number().equals("-1")) {
		 * listBooking.remove(i); } }
		 */
		java.sql.Date today = hostMapper.getSysdate();
		ModelAndView mav = new ModelAndView("/host/host_mode/host_mode");
		mav.addObject("listBooking", listBooking);
		mav.addObject("today", today);
		return mav;
	}

	@ResponseBody
	@RequestMapping(value = "host/bookConfirm", method = RequestMethod.POST)
	public String bookConfirm(@RequestParam Map<String, Object> param) {
		int bookingId = Integer.valueOf((String) param.get("bookingId"));
		java.text.DateFormat format = new SimpleDateFormat("yyyyMMdd");
		java.sql.Date payExptDate = null;
		try {
			Calendar c = Calendar.getInstance();
			System.out.println((String) param.get("checkOutDate"));
			Date date = format.parse((String) param.get("checkOutDate"));
			System.out.println(date);
			c.setTime(date);
			c.add(Calendar.DATE, 3); // 3일 추가하기
			date = c.getTime();
			long timeInMilliSeconds = date.getTime();
			payExptDate = new java.sql.Date(timeInMilliSeconds);
			System.out.println("parse: " + payExptDate);
		} catch (ParseException e) {
			e.printStackTrace();
			return "예약 승인 중 오류 발생!";
		}

		int res1 = hostMapper.bookConfirm(bookingId);
		int res2 = hostMapper.payExptDateConfirm(bookingId, payExptDate);
		System.out.print("결과: " + res1 + "그리고" + res2);
		if (res1 > 0 && res2 > 0)
			return "예약이 승인 되었습니다!";
		else
			return "예약 승인 중 오류 발생!";
	}

	@ResponseBody
	@RequestMapping(value = "host/bookReject", method = RequestMethod.POST)
	public String bookReject(@RequestParam("bookingId") Integer bookingId) {
		int res1 = hostMapper.bookReject(bookingId);
		int res2 = hostMapper.transactionRefund(bookingId);
		System.out.print("결과: " + res1 + "그리고" + res2);
		if (res1 > 0 && res2 > 0)
			return "예약이 반려 되었습니다!";
		else
			return "반려 처리 중 오류 발생!";
	}

	@Override
	@RequestMapping("host/host_properties_list")
	public ModelAndView host_properties_list(HttpSession session) {
		String hostId = (String) session.getAttribute("member_id");
		List<PropertyDTO> listProperty = hostMapper.getPropertyList(hostId);
		for (PropertyDTO dto : listProperty) {
			List<ImageDTO> listImage = hostMapper.getPropertyImage(dto.getId());
			List<AmenityTypeDTO> listAmenity = hostMapper.getAmenityList(dto.getId());
			dto.setImages(listImage);
			dto.setAmenityTypes(listAmenity);
		}

		ModelAndView mav = new ModelAndView("/host/host_mode/host_properties_list");
		mav.addObject("listProperty", listProperty);
		return mav;
	}

	@RequestMapping("host/host_properties_list_update")
	public ModelAndView host_properties_list_update(@RequestParam Map<String, Object> param) {
		PropertyDTO dtoPro = new PropertyDTO();
		dtoPro.setRoomTypeId((Integer) param.get("roomTypeId"));
		List<Integer> list = (List<Integer>) param.get("listAmenity");
		List<AmenityTypeDTO> listAmenity = hostMapper.getAmenityTypeList();
		listAmenity.removeIf(dto -> {
			boolean isRemove = true;
			for (int id : list) {
				if (dto.getId() == id) {
					isRemove = false;
					break;
				}
			}
			return isRemove;
		});
		dtoPro.setMaxGuest((Integer) param.get("maxGuest"));
		dtoPro.setBedCount((Integer) param.get("bedCount"));
		dtoPro.setPropertyDesc((String) param.get("description"));
		dtoPro.setPrice((Integer) param.get("price"));
		dtoPro.setAmenityTypes(listAmenity);
		// int propertyOk = hostMapper.insertProperty(dtoPro);
		// int amenityDelete = hostMapper.deleteAmenity();
		int propertyUpdate = hostMapper.updateProperty(dtoPro);
		// int amenityOk = hostMapper.insertListAmenity(listAmenity);
		ModelAndView mav = new ModelAndView("/host/host_mode/host_properties_list");
		return mav;
	}

	@Override
	@RequestMapping(value = "host/property_update", method = RequestMethod.GET)
	public ModelAndView host_getProperty(int propertyId) {
		PropertyDTO propertyDTO = hostMapper.getProperty(propertyId);
		List<ImageDTO> listImage = hostMapper.getPropertyImage(propertyId);
		List<AmenityTypeDTO> listAmenity = hostMapper.getAmenityList(propertyId);
		propertyDTO.setImages(listImage);
		propertyDTO.setAmenityTypes(listAmenity);
		List<Integer> listAmenityId = new ArrayList<>();
		for (AmenityTypeDTO dto : listAmenity) {
			listAmenityId.add(dto.getAmenityId());
		}

		List<RoomTypeDTO> listRoomType = hostMapper.getRoomType();
		List<AmenityTypeDTO> listAmenityType = hostMapper.getAmenityTypeList();

		ModelAndView mav = new ModelAndView("/host/host_mode/properties_update");
		mav.addObject("propertyDTO", propertyDTO);
		mav.addObject("listRoomType", listRoomType);
		mav.addObject("listAmenityType", listAmenityType);
		mav.addObject("listAmenityId", listAmenityId);
		return mav;
	}

	@RequestMapping("host/update_photos")
	public ModelAndView update_photos(@RequestParam("propertyId") Integer propertyId) {
		List<ImageDTO> listImage = hostMapper.getPropertyImage(propertyId);
		return new ModelAndView("/host/host_mode/update_photos", "listImage", listImage);
	}

	protected int imageDelete(Integer propertyId) {
		List<ImageDTO> listPath = hostMapper.getPropertyImage(propertyId);
		int count = 0;
		for (ImageDTO dto : listPath) {
			System.out.println("저장 된 사진 경로: " + dto.getPath());
			File file = new File(dto.getPath());

			if (file.exists()) {
				file.delete();
				count++;
			}
		}
		return count;
	}

	@ResponseBody
	@RequestMapping("host/property_delete")
	public String delete(@RequestParam("propertyId") Integer propertyId) {
		imageDelete(propertyId);
		int res = hostMapper.deleteProperty(propertyId);
		System.out.println("res: " + res);
		if (res > 0) {
			return "{ \"result\":\"OK\" }";
		}
		return "{ \"result\":\"FAIL\" }";
	}

	@Override
	@RequestMapping(value = "host/properties_update", method = RequestMethod.POST)
	public ModelAndView host_property_update(HttpSession session, @RequestParam Map<String, String> map,
			@RequestParam("files") List<MultipartFile> images) {
		// msg, url
		return new ModelAndView("/message");
	}

	@Override
	@RequestMapping("host/transaction_list")
	public ModelAndView transaction_list(HttpSession session) {
		String hostId = (String) session.getAttribute("member_id");
		List<TransactionDTO> listTransaction = hostMapper.getTransactionList(hostId);
		// 6월 29, 2021 10:31:02 오전
		ModelAndView mav = new ModelAndView("/host/host_mode/transaction_list");
		java.util.Date today = new Date();
		for (TransactionDTO dto : listTransaction) {
			if (dto.getConfirmDate() != null && dto.getPayExptDate() != null) {
				if (dto.getConfirmDate().before(today) && today.before(dto.getPayExptDate())) {
					mav.addObject("isReserv", 1);
					break;
				}
			}
		}
		mav.addObject("listTransaction", listTransaction);
		mav.addObject("today", today);
		return mav;
	}

	@Override
	@RequestMapping("host/host_review_list")
	public ModelAndView host_review_list(HttpSession session) {
		List<PropertyDTO> list = hostMapper.getPropertyList((String) session.getAttribute("member_id"));
		return new ModelAndView("/host/host_mode/host_review_list", "listProperty", list);
	}

	@PostMapping("review_html")
	public ModelAndView getReiview(HttpServletRequest req) {
		Integer propertyId = Integer.parseInt(req.getParameter("propertyId"));
		List<ReviewDTO> list = hostMapper.getReviewList(propertyId);
		List<Map<String, Integer>> listMap = hostMapper.getReviewWritingRate(propertyId);
		ModelAndView mav = new ModelAndView("/host/host_mode/review");
		double reviewCount = Double.parseDouble(String.valueOf(listMap.get(0).get("reviewCount")));// 무슨 에러 떠서 해결법 찾음
		double bookingCount = Double.parseDouble(String.valueOf(listMap.get(0).get("bookingCount")));
		double reviewRate = reviewCount / bookingCount * 100;
		mav.addObject("reviewRate", Math.round(reviewRate));
		mav.addObject("listReview", list);
		return mav;
	}

	@GetMapping("review_send")
	public ModelAndView review_html(@RequestParam String review) {
		System.out.println("review_html:" + review);
		return new ModelAndView("/host/host_mode/host_review_list", "review", review);
	}

	public java.util.Date addMonth(Date date, int months) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MONTH, months);
		return cal.getTime();
	}

	@Override
	@RequestMapping("host/total_earning")
	public ModelAndView total_earning(HttpSession session) {
		String hostId = (String) session.getAttribute("member_id");
		List<TransactionDTO> list = hostMapper.getTotalEarning(hostId);
		java.util.Date date = new Date();
		java.util.Date beM[] = new Date[13];
		ModelAndView mav = new ModelAndView("/host/host_mode/total_earning");
		List<Integer> listTotal = new ArrayList<>();
		int total[] = new int[12];
		for (int i = 0; i < 13; ++i) {
			beM[i] = addMonth(date, -i);
		}
		for (TransactionDTO dto : list) { // 6개월 전
			for (int i = 0; i < 12; ++i) {
				if (beM[i + 1].before(dto.getPayExptDate()) && dto.getPayExptDate().before(beM[i])) {
					if (Character.compare(dto.getIsRefund(), 'N') == 0) {
						total[i] += dto.getTotalPrice() - dto.getTotalPrice() * dto.getSiteFee();
					}
				}
			}
		} // total[0]: 가장 최근 달 >> total1
		for (int i = 11; i >= 0; --i) {
			listTotal.add(total[i]);
		}
		mav.addObject("listTotal", listTotal);
		return mav;
	}

	@RequestMapping("host/chat")
	public String chat() {
		return "/host/host_mode/ehco-ws";
	}

	@ResponseBody
	@RequestMapping("reviewAnswer")
	public String reviewAnswer(@RequestParam Map<String, String> param) {
		System.out.println("bookingId : " + param.get("bookingId"));
		System.out.println("answer : " + param.get("answer"));
		int res = hostMapper.reviewAnswer(param);
		System.out.println("res: " + res);
		if (res > 0) {
			return "{ \"result\":\"OK\" }";
		}
		return "{ \"result\":\"FAIL\" }";
	}

	@Override
	@RequestMapping("host/host_support")
	public ModelAndView host_support(HttpSession session) {
		// TODO Auto-generated method stub
		return new ModelAndView("/host/host_mode/host_support");
	}

}