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

import com.airtnt.airtnt.guest.LoginOKBean;
import com.airtnt.airtnt.host.PropertyInformationBean;
import com.airtnt.airtnt.interceptor.LoginInterceptor;
import com.airtnt.airtnt.model.AmenityDTO;
import com.airtnt.airtnt.model.AmenityTypeDTO;
import com.airtnt.airtnt.model.BookingDTO;
import com.airtnt.airtnt.model.GuideContextDTO;
import com.airtnt.airtnt.model.GuideDTO;
import com.airtnt.airtnt.model.ImageDTO;
import com.airtnt.airtnt.model.PropertyDTO;
import com.airtnt.airtnt.model.PropertyInformationDTO;
import com.airtnt.airtnt.model.PropertyTypeDTO;
import com.airtnt.airtnt.model.ReviewDTO;
import com.airtnt.airtnt.model.RoomTypeDTO;
import com.airtnt.airtnt.model.SubPropertyTypeDTO;
import com.airtnt.airtnt.model.TransactionDTO;
import com.airtnt.airtnt.service.HostMapper;

@Controller
@SuppressWarnings("unchecked")
public class HostController {
	@Autowired
	private HostMapper hostMapper;

	// 1. 호스트 시작하기 >>으로 이동
	// 나머지는 게시판

	@RequestMapping("guide_home")
	public ModelAndView guide_home() {
		List<GuideDTO> listGuide = hostMapper.getGuideList();
		// System.out.print(guideList.get(0).getId());
		return new ModelAndView("host/guide/guide_home", "listGuide", listGuide);
	}

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
		session.removeAttribute("checkAddress");

		Enumeration<String> emu = session.getAttributeNames();
		System.out.println("====세션에 담긴 값====");
		while (emu.hasMoreElements()) {
			String name = emu.nextElement();
			Object attrValue = session.getAttribute(name);
			System.out.println(name + ": " + attrValue);
		}
		setProperty(session); // 새롭게 생성해서 저장
		return new ModelAndView("host/property_insert/property_type_0", "listPropertyType",
				propertyDTO().getListPropertyType());
	}

	protected void setProperty(HttpSession session) {
		PropertyInformationBean instance = PropertyInformationBean.getInstance();
		List<PropertyTypeDTO> listPropertyType = hostMapper.getListPropertyType();
		List<SubPropertyTypeDTO> listSubPropertyType = hostMapper.getListSubPropertyType();
		List<RoomTypeDTO> listRoomType = hostMapper.getListRoomType();
		List<AmenityTypeDTO> listAmenityType = hostMapper.getListAmenityType();
		String hostId = (String) session.getAttribute("member_id");
		PropertyInformationDTO property = new PropertyInformationDTO();
		property.setListPropertyType(listPropertyType);
		property.setListSubPropertyType(listSubPropertyType);
		property.setListRoomType(listRoomType);
		property.setListAmenityType(listAmenityType);
		property.setHostId(hostId);
		instance.setPropertyDTO(property);
	}

	protected PropertyInformationDTO propertyDTO() {
		PropertyInformationBean propertyInfo = PropertyInformationBean.getInstance();
		return propertyInfo.getPropertyDTO();
	}

	@RequestMapping("host/property_type_0")
	public ModelAndView property_type_0() {
		return new ModelAndView("host/property_insert/property_type_0", "listPropertyType",
				propertyDTO().getListPropertyType());
	}

	@RequestMapping("host/sub_property_type_1")
	public ModelAndView sub_property_type_1(HttpSession session,
			@RequestParam(value = "propertyTypeId") Integer propertyTypeId,
			@RequestParam(value = "propertyTypeName") String propertyTypeName) {
		propertyDTO().setPropertyTypeId(propertyTypeId);
		propertyDTO().setPropertyTypeName(propertyTypeName);
		List<SubPropertyTypeDTO> list = propertyDTO().getListSubPropertyType();
		list.removeIf(dto -> {
			boolean isRemove = false;
			if (dto.getPropertyTypeId() != propertyTypeId) {
				isRemove = true;
			}
			return isRemove;
		});
		return new ModelAndView("host/property_insert/sub_property_type_1", "listSubPropertyType", list);
	}

	@RequestMapping("host/room_type_2")
	public ModelAndView room_type_2(HttpSession session,
			@RequestParam(value = "subPropertyTypeId") Integer subPropertyTypeId,
			@RequestParam(value = "subPropertyTypeName") String subPropertyTypeName) {
		propertyDTO().setSubPropertyTypeId(subPropertyTypeId);
		propertyDTO().setSubPropertyTypeName(subPropertyTypeName);
		ModelAndView mav = new ModelAndView("host/property_insert/room_type_2");
		mav.addObject("listRoomType", propertyDTO().getListRoomType());
		return mav;
	}

	@RequestMapping("host/address_3")
	public String address_3(HttpSession session, @RequestParam(value = "roomTypeId") Integer roomTypeId,
			@RequestParam(value = "roomTypeName") String roomTypeName) {
		propertyDTO().setRoomTypeId(roomTypeId);
		propertyDTO().setRoomTypeName(roomTypeName);
		return "host/property_insert/address_3";
	}

	@RequestMapping("host/floor_plan_4")
	public String floor_plan_4(HttpSession session, @RequestParam Map<String, String> param) {
		session.setAttribute("checkAddress", param.get("address"));
		propertyDTO().setAddress(param.get("address") + " " + param.get("addressDetail"));
		propertyDTO().setLatitude(param.get("latitude"));
		propertyDTO().setLongitude(param.get("longitude"));

		System.out.println("위도: " + param.get("latitude"));
		System.out.println("경도: " + param.get("longitude"));
		System.out.println(param.get("address"));
		System.out.println("상세: " + param.get("addressDetail"));
		return "host/property_insert/floor_plan_4";
	}

	@RequestMapping("host/amenities_5")
	public ModelAndView amenities_5(HttpSession session, @RequestParam(value = "maxGuest") Integer maxGuest,
			@RequestParam(value = "bedCount") Integer bedCount) {
		propertyDTO().setMaxGuest(maxGuest);
		propertyDTO().setBedCount(bedCount);
		return new ModelAndView("/host/property_insert/amenities_5", "listAmenityType",
				propertyDTO().getListAmenityType());
	}

	@RequestMapping("host/photos_6")
	public String photos_6(HttpSession session,
			@RequestParam(value = "listAmenity", required = true) List<Integer> amenities) {
		List<AmenityTypeDTO> listAmenity = propertyDTO().getListAmenityType();
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
		propertyDTO().setListAmenityInsert(listAmenity);
		return "/host/property_insert/photos_6";
	}

	@ResponseBody // 사진 마무리 저장은 마지막에!
	@RequestMapping(value = "/host/file-upload", method = RequestMethod.POST)
	public String photos_upload(@RequestParam("article_file") List<MultipartFile> multipartFile, HttpServletRequest req) {
		String strResult = "{ \"result\":\"FAIL\" }";
		long sizeSum = 0;
		HttpSession session = req.getSession();
		String memberId = (String) session.getAttribute("member_id");
		List<ImageDTO> listImgUrl = new ArrayList<>();
		// Map<InputStream, File> imgMap = new Hashtable<>();
		List<InputStream> listInputStream = new ArrayList<>();
		List<File> listFile = new ArrayList<>();
		// 하성
		String upPath = "C:\\Users\\Haseong\\git\\airtnt\\src\\main\\webapp\\resources\\files\\property\\";
		// 수연
		// String upPath =
		// "C:\\Users\\woosuki\\git\\airtnt\\src\\main\\webapp\\resources\\files\\property\\";
		// 학원
		// String upPath =
		// "D:\\study3(spring)\\airtnt\\src\\main\\webapp\\resources\\files\\property\\";
		// 정석
		// String upPath =
		// "C:\\Spring\\EZEN\\workspace\\AirTnT\\src\\main\\webapp\\resources\\files\\property\\";
		try {
			// 파일이 있을때 탄다.
			if (multipartFile.size() > 0 && !multipartFile.get(0).getOriginalFilename().equals("")) {
				for (MultipartFile file : multipartFile) {
					String originalFileName = file.getOriginalFilename(); // 오리지날 파일명
					long time = System.currentTimeMillis();
					String savedFileName = time + "-" + memberId + "-" + originalFileName; // 저장될 파일 명

					if (!isValidExtension(originalFileName)) { // 확장자 검사
						return strResult = "{ \"result\":\"UNACCEPTED_EXTENSION\" }";
					}

					sizeSum += file.getSize(); // 사진의 총 사이즈 검사
					if (sizeSum >= 1 * 1024 * 1024) { // 100MB
						return strResult = "{ \"result\":\"EXCEED_SIZE\" }";
					}

					String nameForShow = "/resources/files/property/" + savedFileName;
					File targetFile = new File(upPath + savedFileName);
					InputStream fileStream = file.getInputStream();
					listInputStream.add(fileStream);
					listFile.add(targetFile);
					ImageDTO dto = new ImageDTO();
					dto.setFileSize(file.getSize());
					dto.setPath(nameForShow);
					listImgUrl.add(dto);
					System.out.println("사진 주소: " + nameForShow);
				}
				propertyDTO().setListInputStream(listInputStream);
				propertyDTO().setListFile(listFile);
				propertyDTO().setListImage(listImgUrl); // 바로 img 태그의 src에 넣으면 됨
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
		originalNameExtension = originalNameExtension.toLowerCase();
		switch (originalNameExtension) {
		case "jpg":
		case "png":
		case "gif":
		case "bmp":
			return true;
		}
		return false;
	}

	@RequestMapping("host/name_description_7")
	public String name_description_7() {
		return "/host/property_insert/name_description_7";
	}

	@RequestMapping("host/price_8")
	public String price_8(HttpSession session, @RequestParam(value = "name") String name,
			@RequestParam(value = "description") String description) {
		propertyDTO().setName(name);
		propertyDTO().setDescription(description);
		return "/host/property_insert/price_8";
	}

	@RequestMapping("host/preview_9")
	public ModelAndView preview_9(HttpSession session, @RequestParam(value = "price") int price) {
		propertyDTO().setPrice(price);
		ModelAndView mav = new ModelAndView("/host/property_insert/preview_9");
		mav.addObject("path", propertyDTO().getListImage().get(0).getPath());
		mav.addObject("name", propertyDTO().getName());
		mav.addObject("subPropertyTypeName", propertyDTO().getSubPropertyTypeName());
		mav.addObject("maxGuest", propertyDTO().getMaxGuest());
		mav.addObject("bedCount", propertyDTO().getBedCount());
		mav.addObject("listAmenity", propertyDTO().getListAmenityInsert());
		mav.addObject("address", propertyDTO().getAddress());
		mav.addObject("description", propertyDTO().getDescription());
		return mav;
	}

	@ResponseBody
	@RequestMapping("host/property_save")
	public String property_save(HttpSession session) {

		PropertyInformationDTO dtoPro = propertyDTO();

		int propertyOk = hostMapper.insertProperty(dtoPro); // 1. property입력

		int propertyId = hostMapper.getPropertyId(propertyDTO().getHostId()); // 2. propertyId 가져오기
		for (AmenityTypeDTO dto : dtoPro.getListAmenityType()) {
			dto.setPropertyId(propertyId);
		}
		for (ImageDTO dto : propertyDTO().getListImage()) {
			dto.setPropertyId(propertyId);
		}
		List<InputStream> listInputStream = propertyDTO().getListInputStream();
		List<File> listFile = propertyDTO().getListFile();
		for (int i = 0; i < listInputStream.size(); i++) { // 3. 사진 저장
			try {
				FileUtils.copyInputStreamToFile(listInputStream.get(i), listFile.get(i)); // 파일 저장
				System.out.println("파일");
			} catch (Exception e) {
				// 파일삭제
				FileUtils.deleteQuietly(listFile.get(i)); // 저장된 현재 파일 삭제
				e.printStackTrace();
			}
		}

		propertyDTO().getListImage().get(0).setIsMain('Y'); // 메인 사진 설정
		int amenityOk = hostMapper.insertListAmenity(propertyDTO().getListAmenityInsert()); // 4. 편의시설 입력
		int imageOk = hostMapper.imageInsert(propertyDTO().getListImage()); // 5. 숙소 사진 입력
		int memberChangeOk = hostMapper.updateMemberMode(propertyDTO().getHostId()); // 6. 멤버모드 변경 1 -> 2

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
		session.setAttribute("isMemberMode", true);
		session.setAttribute("member_mode", "2");
		session.removeAttribute("checkAddress");
		PropertyInformationBean bean = PropertyInformationBean.getInstance();
		bean.clear(); // Bean 지우기
		return "{ \"result\":\"OK\" }";
	}

	//////////////////////////////////////////////////////////////////////////////////////
	// 3. host_mode 페이지
	//////////////////////////////////////////////////////////////////////////////////////

	
	@RequestMapping("host/host_mode")
	public ModelAndView host_mode(HttpSession session) {
		//PropertyInformationBean bean = PropertyInformationBean.getInstance();
		//bean.clear();
		String hostId = (String) session.getAttribute("member_id");
		List<BookingDTO> listBooking = hostMapper.getBookingList(hostId);
		// System.out.println("isRefund: " + listBooking.get(0).getIsRefund());
		listBooking.removeIf(dto -> {
			boolean isRemove = false;
			if (dto.getBookingNumber().equals("-1"))
				isRemove = true;
			return isRemove;
		});
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
		java.text.DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		java.sql.Date payExptDate = null;
		try {
			Calendar c = Calendar.getInstance();
			Date date = format.parse((String) param.get("checkOutDate"));
			c.setTime(date);
			c.add(Calendar.DATE, 3); // 3일 추가하기
			date = c.getTime();
			long timeInMilliSeconds = date.getTime();
			payExptDate = new java.sql.Date(timeInMilliSeconds);
			param.put("payExptDate", payExptDate);
		} catch (ParseException e) {
			e.printStackTrace();
			return "{ \"result\":\"FAIL\" }";
		}

		int res1 = hostMapper.bookConfirm(bookingId);
		int res2 = hostMapper.payExptDateConfirm(param);
		// int res = hostMapper.bookingConfirm(param);
		if (res1 > 0 && res2 > 0)
			return "{ \"result\":\"OK\" }";
		else
			return "{ \"result\":\"FAIL\" }";
	}

	@ResponseBody
	@RequestMapping(value = "host/bookReject", method = RequestMethod.POST)
	public String bookReject(@RequestParam("bookingId") Integer bookingId) {
		int res1 = hostMapper.bookReject(bookingId);
		int res2 = hostMapper.transactionRefund(bookingId);
		// int res = hostMapper.bookingReject(bookingId);
		if (res1 > 0 && res2 > 0) {
			return "{ \"result\":\"OK\" }";
		}
		return "{ \"result\":\"FAIL\" }";
		/*
		 * System.out.print("결과: " + res1 + "그리고" + res2); if (res1 > 0 && res2 > 0)
		 * return "예약이 반려 되었습니다!"; else return "반려 처리 중 오류 발생!";
		 */
	}

	@RequestMapping("host/host_properties_list")
	public ModelAndView host_properties_list(HttpSession session) {
		String hostId = (String) session.getAttribute("member_id");
		List<PropertyDTO> listProperty = hostMapper.getPropertyList(hostId);
		for (PropertyDTO dto : listProperty) {
			List<ImageDTO> listImage = hostMapper.getPropertyImage(dto.getId());
			List<AmenityTypeDTO> listAmenity = hostMapper.getAmenityList(dto.getId());
			dto.setImages(listImage);
			dto.setAmenityTypes(listAmenity);
			System.out.println("");
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
		List<AmenityTypeDTO> listAmenity = hostMapper.getListAmenityType();
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

		List<RoomTypeDTO> listRoomType = hostMapper.getListRoomType();
		List<AmenityTypeDTO> listAmenityType = hostMapper.getListAmenityType();

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
		int count = imageDelete(propertyId);
		System.out.println("지워진 사진 수: " + count);
		int res = hostMapper.deleteProperty(propertyId);
		System.out.println("res: " + res);
		if (res > 0) {
			return "{ \"result\":\"OK\" }";
		}
		return "{ \"result\":\"FAIL\" }";
	}

	@RequestMapping(value = "host/properties_update", method = RequestMethod.POST)
	public ModelAndView host_property_update(HttpSession session, @RequestParam Map<String, String> map,
			@RequestParam("files") List<MultipartFile> images) {
		// msg, url
		return new ModelAndView("/message");
	}

	@RequestMapping("host/transaction_list")
	public ModelAndView transaction_list(HttpSession session) {
		String hostId = (String) session.getAttribute("member_id");
		List<TransactionDTO> listTransaction = hostMapper.getTransactionList(hostId);
		// 6월 29, 2021 10:31:02 오전
		ModelAndView mav = new ModelAndView("/host/host_mode/transaction_list");
		Date today = hostMapper.getSysdate();
		System.out.println("오늘:"+today);
		for (TransactionDTO dto : listTransaction) {
			System.out.println("날짜 : " + dto.getPayExptDate());
			if (dto.getConfirmDate() != null && dto.getPayExptDate() != null) { //예약 확정이 정상적으로 이루어졌고
				if (dto.getConfirmDate().before(today) && today.before(dto.getPayExptDate())) {//컨펌일 < 오늘 < 돈 받는 날
					mav.addObject("isReserv", 1);
					break;
				}
			}
		}
		mav.addObject("listTransaction", listTransaction);
		mav.addObject("today", today);
		return mav;
	}

	@RequestMapping("host/host_review_list")
	public ModelAndView host_review_list(HttpSession session) {
		String memberId = (String) session.getAttribute("member_id");
		List<PropertyDTO> list = hostMapper.getPropertyList(memberId);
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
		System.out.println("reviewId : " + param.get("reviewId"));
		System.out.println("answer : " + param.get("answer"));
		int res = hostMapper.reviewAnswer(param);
		System.out.println("res: " + res);
		if (res > 0) {
			return "{ \"result\":\"OK\" }";
		}
		return "{ \"result\":\"FAIL\" }";
	}

	@RequestMapping("host/host_support")
	public ModelAndView host_support(HttpSession session) {
		// TODO Auto-generated method stub
		return new ModelAndView("/host/host_mode/host_support");
	}

}