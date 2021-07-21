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
import org.springframework.web.bind.MissingServletRequestParameterException;
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
import com.airtnt.airtnt.service.PropertyMapper;

@Controller
@SuppressWarnings("unchecked")
public class HostController {
	@Autowired
	private HostMapper hostMapper;
	
	@Autowired
	private PropertyMapper propertyMapper;

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
	public ModelAndView property_insert(HttpSession session) {
		session.removeAttribute("checkAddress");
		setProperty(session); // 새롭게 생성해서 저장
		return new ModelAndView("host/property_insert/property_type_0", "listPropertyType",
				propertyBean().getListPropertyType());
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
		instance.setPropertyInformationDTO(property);
	}

	protected PropertyInformationDTO propertyBean() {
		PropertyInformationBean propertyInfo = PropertyInformationBean.getInstance();
		return propertyInfo.getPropertyInformationDTO();
	}

	protected void clearBean() {
		PropertyInformationBean instance = PropertyInformationBean.getInstance();
		instance.clear();
	}

	@RequestMapping("host/property_type_0")
	public ModelAndView property_type() {
		return new ModelAndView("host/property_insert/property_type_0", "listPropertyType",
				propertyBean().getListPropertyType());
	}

	@RequestMapping("host/sub_property_type_1")
	public ModelAndView sub_property_type(@RequestParam(value = "propertyTypeId") Integer propertyTypeId,
			@RequestParam(value = "propertyTypeName") String propertyTypeName) {
		propertyBean().setPropertyTypeId(propertyTypeId);
		propertyBean().setPropertyTypeName(propertyTypeName);
		List<SubPropertyTypeDTO> list = propertyBean().getListSubPropertyType();
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
	public ModelAndView room_type(@RequestParam(value = "subPropertyTypeId") Integer subPropertyTypeId,
			@RequestParam(value = "subPropertyTypeName") String subPropertyTypeName) {
		propertyBean().setSubPropertyTypeId(subPropertyTypeId);
		propertyBean().setSubPropertyTypeName(subPropertyTypeName);
		ModelAndView mav = new ModelAndView("host/property_insert/room_type_2");
		mav.addObject("listRoomType", propertyBean().getListRoomType());
		return mav;
	}

	@RequestMapping("host/address_3")
	public String address(@RequestParam(value = "roomTypeId") Integer roomTypeId,
			@RequestParam(value = "roomTypeName") String roomTypeName) {
		propertyBean().setRoomTypeId(roomTypeId);
		propertyBean().setRoomTypeName(roomTypeName);
		return "host/property_insert/address_3";
	}

	@RequestMapping("host/floor_plan_4")
	public String floor_plan(HttpSession session, @RequestParam Map<String, String> param) {
		session.setAttribute("checkAddress", param.get("address"));
		propertyBean().setAddress(param.get("address") + " " + param.get("addressDetail"));
		propertyBean().setLatitude(param.get("latitude"));
		propertyBean().setLongitude(param.get("longitude"));
		return "host/property_insert/floor_plan_4";
	}

	@RequestMapping("host/amenities_5")
	public ModelAndView amenities(@RequestParam(value = "maxGuest") Integer maxGuest,
			@RequestParam(value = "bedCount") Integer bedCount) {
		propertyBean().setMaxGuest(maxGuest);
		propertyBean().setBedCount(bedCount);
		return new ModelAndView("/host/property_insert/amenities_5", "listAmenityType",
				propertyBean().getListAmenityType());
	}

	@PostMapping("host/photos_6")
	public String photos(@RequestParam(value = "listAmenity") List<Integer> amenities) {
		List<AmenityTypeDTO> listAmenity = propertyBean().getListAmenityType();
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
		propertyBean().setListAmenityInsert(listAmenity);
		return "/host/property_insert/photos_6";
	}

	@ResponseBody // 사진 마무리 저장은 마지막에!
	@RequestMapping(value = "/host/file-upload", method = RequestMethod.POST)
	public String photos_upload(@RequestParam("article_file") List<MultipartFile> multipartFile) {
		String strResult = "{ \"result\":\"FAIL\" }";
		long sizeSum = 0;
		String memberId = propertyBean().getHostId();
		List<ImageDTO> listImgUrl = new ArrayList<>();
		List<InputStream> listInputStream = new ArrayList<>();
		List<File> listFile = new ArrayList<>();
		// 하성
		//String upPath = "C:\\Users\\Haseong\\git\\airtnt\\src\\main\\webapp\\resources\\files\\property\\";
		// 수연
		// String upPath =
		// "C:\\Users\\woosuki\\git\\airtnt\\src\\main\\webapp\\resources\\files\\property\\";
		// 학원
		 String upPath =
		 "D:\\study3(spring)\\airtnt\\src\\main\\webapp\\resources\\files\\property\\";
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
					if (sizeSum >= 20 * 1024 * 1024) { // 50MB
						return strResult = "{ \"result\":\"EXCEED_SIZE\" }";
					}
					// 1. upPath으로 저장과 삭제 : 지워짐. BUT LOAD를 해도 사진이 안보임.
					//"C:\\Users\\Haseong\\git\\airtnt\\src\\main\\webapp\\resources\\files\\property\\
					//2. 
					String nameForShow = "/resources/files/property/"	+ savedFileName;
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
				propertyBean().setListInputStream(listInputStream);
				propertyBean().setListFile(listFile);
				propertyBean().setListImage(listImgUrl); // 바로 img 태그의 src에 넣으면 됨
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
	public String name_description() {
		return "/host/property_insert/name_description_7";
	}

	@RequestMapping("host/price_8")
	public String price(@RequestParam(value = "name") String name,
			@RequestParam(value = "description") String description) {
		propertyBean().setName(name);
		propertyBean().setDescription(description);
		return "/host/property_insert/price_8";
	}

	@RequestMapping("host/preview_9")
	public ModelAndView preview(@RequestParam(value = "price") int price) {
		propertyBean().setPrice(price);
		ModelAndView mav = new ModelAndView("/host/property_insert/preview_9");
		mav.addObject("path", propertyBean().getListImage().get(0).getPath());
		mav.addObject("name", propertyBean().getName());
		mav.addObject("subPropertyTypeName", propertyBean().getSubPropertyTypeName());
		mav.addObject("maxGuest", propertyBean().getMaxGuest());
		mav.addObject("bedCount", propertyBean().getBedCount());
		mav.addObject("listAmenity", propertyBean().getListAmenityInsert());
		mav.addObject("address", propertyBean().getAddress());
		mav.addObject("description", propertyBean().getDescription());
		return mav;
	}

	@ResponseBody
	@RequestMapping("host/property_save")
	public String property_save(HttpSession session) {
		PropertyInformationDTO dtoPro = propertyBean();

		int propertyId = hostMapper.getPropertyId(); // 1. propertyId 가져오기
		dtoPro.setPropertyId(propertyId);
		int propertyOk = hostMapper.insertProperty(dtoPro); // 2. property입력
		for (AmenityTypeDTO dto : dtoPro.getListAmenityType()) {
			dto.setPropertyId(propertyId);
		}
		for (ImageDTO dto : dtoPro.getListImage()) {
			dto.setPropertyId(propertyId);
		}
		List<InputStream> listInputStream = dtoPro.getListInputStream();
		List<File> listFile = dtoPro.getListFile();
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

		dtoPro.getListImage().get(0).setIsMain('Y'); // 메인 사진 설정
		int amenityOk = hostMapper.insertListAmenity(dtoPro.getListAmenityInsert()); // 4. 편의시설 입력
		int imageOk = hostMapper.imageInsert(dtoPro.getListImage()); // 5. 숙소 사진 입력
		int memberChangeOk = hostMapper.updateMemberMode(dtoPro.getHostId()); // 6. 멤버모드 변경 1 -> 2

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
		clearBean(); // Bean 지우기
		return "{ \"result\":\"OK\" }";
	}

	//////////////////////////////////////////////////////////////////////////////////////
	// 3. host_mode 페이지
	//////////////////////////////////////////////////////////////////////////////////////

	@RequestMapping("host/host_mode")
	public ModelAndView host_mode(HttpSession session) {
		String hostId = (String) session.getAttribute("member_id");
		List<BookingDTO> listBooking = hostMapper.getBookingList(hostId);
		listBooking.removeIf(dto -> {
			boolean isRemove = false;
			char refund = Character.toUpperCase(dto.getIsRefund());
			if (dto.getBookingNumber().equals("-1") || Character.compare(refund, 'Y') == 0)
				isRemove = true;
			if(dto.getPropertyId() == null) 
				isRemove = true;
			return isRemove;
		});

		java.sql.Date today = hostMapper.getSysdate();
		ModelAndView mav = new ModelAndView("/host/host_mode/host_mode");
		mav.addObject("listBooking", listBooking);
		mav.addObject("today", today);
		clearBean();
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
		if (res1 > 0 && res2 > 0) {
			return "{ \"result\":\"OK\" }";
		}
		return "{ \"result\":\"FAIL\" }";
	}

	@RequestMapping("host/host_properties_list")
	public ModelAndView host_properties_list(HttpSession session) {
		String hostId = (String) session.getAttribute("member_id");
		//List<PropertyDTO> listProperty = hostMapper.getPropertyList(hostId);
		List<PropertyDTO> listProperty = propertyMapper.selectProperties(hostId);
		for(PropertyDTO property : listProperty) {
			for(AmenityTypeDTO amenityType : property.getAmenityTypes()) {
				System.out.println(amenityType.getName());
			}
			for(ImageDTO image : property.getImages()) {
				System.out.println(image.getPath());
			}
		}
		clearBean();
		return new ModelAndView("/host/host_mode/host_properties_list", "listProperty", listProperty);
	}

	@RequestMapping(value = "host/property_update", method = RequestMethod.POST)
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
		clearBean();
		ModelAndView mav = new ModelAndView("/host/host_mode/host_properties_list");
		return mav;
	}

	@RequestMapping(value = "host/property_update", method = RequestMethod.GET)
	public ModelAndView host_getProperty(HttpSession session, int propertyId) {
		PropertyDTO propertyDTO = hostMapper.getProperty(propertyId);
		setProperty(session);

		ModelAndView mav = new ModelAndView("/host/host_mode/properties_update");
		mav.addObject("propertyDTO", propertyDTO);
		mav.addObject("listRoomType", propertyBean().getListRoomType());
		mav.addObject("listAmenityType", propertyBean().getListAmenityType());
		return mav;
	}

	@RequestMapping("host/photos_upload")
	public String photos_upload() {
		if (propertyBean().getListInputStream() != null && propertyBean().getListFile() != null) {
			List<InputStream> listInputStream = propertyBean().getListInputStream();
			List<File> listFile = propertyBean().getListFile();
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
			int imageOk = hostMapper.imageInsert(propertyBean().getListImage());
		}

		clearBean();
		return "/host/host_mode/host_properties_list";
	}

	@RequestMapping("host/update_photos")
	public ModelAndView update_photos(@RequestParam("propertyId") Integer propertyId) {
		List<ImageDTO> listImage = hostMapper.getPropertyImage(propertyId);
		return new ModelAndView("/host/host_mode/update_photos", "listImage", listImage);
	}

	protected int imageDelete(HttpServletRequest req, Integer propertyId) {
		List<ImageDTO> listPath = hostMapper.getPropertyImage(propertyId);
		int count = 0;
		for (ImageDTO dto : listPath) {
			System.out.println("저장 된 사진 경로: " + dto.getPath());
			File file = new File(req.getServletContext().getRealPath("/")+dto.getPath());

			if (file.exists() == true) {
				file.delete();
				count++;
			}
		}
		return count;
	}

	@ResponseBody
	@RequestMapping("host/property_delete")
	public String delete(@RequestParam("propertyId") Integer propertyId, HttpServletRequest req) {
		int count = imageDelete(req, propertyId);
		System.out.println("지워진 사진 수: " + count);
		int res1 = hostMapper.deleteProperty(propertyId);
		int res2 = hostMapper.propertyBookingDelete(propertyId);
		System.out.println("" + res2);
		if (res1 > 0 && res2 >= 0) {
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
		for (TransactionDTO dto : listTransaction) {
			if (dto.getConfirmDate() != null && dto.getPayExptDate() != null && dto.getPropertyId() != null) { // 예약 확정이 정상적으로 이루어졌고
				if (dto.getConfirmDate().before(today) && today.before(dto.getPayExptDate())) {// 컨펌일 < 오늘 < 돈 받는 날
					mav.addObject("isReserv", 1);
					break;
				}
			}
			dto.setIsRefund(Character.toUpperCase(dto.getIsRefund()));
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
		Map<String, Object> listMap = hostMapper.getReviewWritingRate(propertyId);
		ModelAndView mav = new ModelAndView("/host/host_mode/review");
		double reviewCount = Double.parseDouble(String.valueOf(listMap.get("reviewCount")));// 무슨 에러 떠서 해결법 찾음
		double bookingCount = Double.parseDouble(String.valueOf(listMap.get("bookingCount")));
		double reviewRate = reviewCount / bookingCount * 100;
		double ratingAvg = Double.parseDouble(String.valueOf(listMap.get("ratingAvg")));
		mav.addObject("reviewRate", Math.round(reviewRate));
		mav.addObject("ratingAvg", Math.round(ratingAvg));
		mav.addObject("listReview", list);
		return mav;
	}

	@GetMapping("review_send")
	public ModelAndView review_html(@RequestParam String review) {
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
		for (TransactionDTO dto : list) { // 1년 전
			char refund = Character.toUpperCase(dto.getIsRefund());
			for (int i = 0; i < 12; ++i) {
				if (beM[i + 1].before(dto.getPayExptDate()) && dto.getPayExptDate().before(beM[i])) {
					if (Character.compare(refund, 'N') == 0) {
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
		int res = hostMapper.reviewAnswer(param);
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