package com.airtnt.airtnt.controller;

import java.io.File;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
import com.airtnt.airtnt.model.GuideDTO;
import com.airtnt.airtnt.model.ImageDTO;
import com.airtnt.airtnt.model.PropertyDTO;
import com.airtnt.airtnt.model.PropertyTypeDTO;
import com.airtnt.airtnt.model.RoomTypeDTO;
import com.airtnt.airtnt.model.SubPropertyTypeDTO;
import com.airtnt.airtnt.model.TransactionDTO;
import com.airtnt.airtnt.service.HostMapper;

@Controller
@SuppressWarnings("unchecked")
public class HostController implements HostControllerInterface {
	@Autowired
	private HostMapper hostMapper;
	
	@RequestMapping("message")
	public String message() {
		return "message";
	}

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
		guideList.removeIf(GuideDTO -> {
			boolean isRemove = false;
			GuideDTO dto = new GuideDTO();
			if (dto.getId() == id)
				isRemove = true;
			return isRemove;
		});
		ModelAndView mav = new ModelAndView("host/guide/guide_context");
		mav.addObject("guideDTO", guideDTO);
		mav.addObject("guideList", guideList);
		return mav;
	}

	//////////////////////////////////////////////////////////////////////////////////////
	// 2. property_type_0으로 이동해서 분류 시작
	//////////////////////////////////////////////////////////////////////////////////////

	@Override
	@RequestMapping("/host/property_type_0")
	public ModelAndView property_type_0(HttpServletRequest req) {
		List<PropertyTypeDTO> listPropertyType = hostMapper.getPropertyType();
		return new ModelAndView("host/property_insert/property_type_0", "listPropertyType", listPropertyType);
	}

	@Override
	@RequestMapping("/host/sub_property_type_1")
	public ModelAndView sub_property_type_1(HttpServletRequest req, Integer propertyTypeId, String propertyTypeName) {
		HttpSession session = req.getSession();
		session.setAttribute("propertyTypeId", propertyTypeId);
		session.setAttribute("propertyTypeName", propertyTypeName);
		List<SubPropertyTypeDTO> listSubPropertyType = hostMapper.getSubPropertyType(propertyTypeId);
		ModelAndView mav = new ModelAndView("host/property_insert/sub_property_type_1");
		mav.addObject("listSubPropertyType", listSubPropertyType);

		System.out.println(propertyTypeId);
		System.out.println(propertyTypeName);
		return mav;
	}

	@Override
	@RequestMapping("/host/room_type_2")
	public ModelAndView room_type_2(HttpServletRequest req, Integer subPropertyTypeId, String subPropertyTypeName) {
		HttpSession session = req.getSession();
		session.setAttribute("subPropertyTypeId", subPropertyTypeId);
		session.setAttribute("subPropertyTypeName", subPropertyTypeName);
		List<RoomTypeDTO> listRoomType = hostMapper.getRoomType();
		ModelAndView mav = new ModelAndView("host/property_insert/room_type_2");
		mav.addObject("listRoomType", listRoomType);

		System.out.println(subPropertyTypeId);
		System.out.println(subPropertyTypeName);
		return mav;
	}

	@Override
	@RequestMapping("/host/address_3")
	public String address_3(HttpServletRequest req, Integer roomTypeId, String roomTypeName) {
		HttpSession session = req.getSession();
		session.removeAttribute("roomTypeId");
		session.removeAttribute("roomTypeName");
		session.setAttribute("roomTypeId", roomTypeId);
		session.setAttribute("roomTypeName", roomTypeName);

		System.out.println(roomTypeId);
		System.out.println(roomTypeName);
		return "host/property_insert/address_3";
	}

	@Override
	@RequestMapping("/host/floor_plan_4")
	public String floor_plan_4(HttpServletRequest req, String address, String addressDetail) {
		HttpSession session = req.getSession();
		session.setAttribute("address", address + " " + addressDetail);

		System.out.println(address);
		System.out.println("상세: " + addressDetail);
		return "host/property_insert/floor_plan_4";
	}

	@Override
	@RequestMapping("/host/amenities_5")
	public ModelAndView amenities_5(HttpServletRequest req, Integer maxGuest, Integer bedCount) {
		HttpSession session = req.getSession();
		if (maxGuest == null) {
			maxGuest = 1;
		}
		if (bedCount == null) {
			bedCount = 1;
		}
		session.setAttribute("maxGuest", maxGuest);
		session.setAttribute("bedCount", bedCount);
		List<AmenityTypeDTO> list = hostMapper.getAmenityTypeList();

		System.out.println(maxGuest);
		System.out.println(bedCount);
		return new ModelAndView("/host/property_insert/amenities_5", "listAmenityType", list);
	}

	@Override
	@RequestMapping("/host/photos_6") // name = amenities로 페이지에서 보내야 함
	public String photos_6(HttpServletRequest req,
			@RequestParam(value = "amenities", required = true) List<Integer> amenities) {
		HttpSession session = req.getSession();
		session.setAttribute("listAmenities", amenities);
		System.out.println("편의시설 ID: ");
		for (int i : amenities) {
			System.out.println(i);
		}
		return "/host/property_insert/photos_6";
	}

	@ResponseBody
	@RequestMapping(value = "/host/file-upload", method = RequestMethod.POST)
	public String fileUpload(@RequestParam("article_file") List<MultipartFile> multipartFile,
			HttpServletRequest request) {

		String strResult = "{ \"result\":\"FAIL\" }";
		@SuppressWarnings("deprecation")
		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
		String fileRoot;
		try {
			// 파일이 있을때 탄다.
			if (multipartFile.size() > 0 && !multipartFile.get(0).getOriginalFilename().equals("")) {

				for (MultipartFile file : multipartFile) {
					fileRoot = contextRoot + "resources/property_img/";
					System.out.println(fileRoot);

					String originalFileName = file.getOriginalFilename(); // 오리지날 파일명
					String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자
					String savedFileName = UUID.randomUUID() + extension; // 저장될 파일 명

					File targetFile = new File(fileRoot + savedFileName);
					try {
						InputStream fileStream = file.getInputStream();
						FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장

					} catch (Exception e) {
						// 파일삭제
						FileUtils.deleteQuietly(targetFile); // 저장된 현재 파일 삭제
						e.printStackTrace();
						break;
					}
				}
				strResult = "{ \"result\":\"OK\" }";
			}
			// 파일 아무것도 첨부 안했을때 탄다.(게시판일때, 업로드 없이 글을 등록하는경우)
			else
				strResult = "{ \"result\":\"OK\" }";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return strResult;
	}

	@Override
	@ResponseBody
	/* @RequestMapping(value = "/host/file-upload", method = RequestMethod.POST) */
	public String photos_upload(@RequestParam("article_files") List<MultipartFile> multipartFile,
			HttpServletRequest req) {
		HttpSession session = req.getSession();
		System.out.println("여기까지");
		String strResult = "{ \"result\":\"FAIL\" }";
		@SuppressWarnings("deprecation")
		String contextRoot = new HttpServletRequestWrapper(req).getRealPath("/");
		String fileRoot;
		long sizeSum = 0;
		List<String> listImgUrl = new ArrayList<>();
		try {
			// 파일이 있을때 탄다.
			if (multipartFile.size() > 0 && !multipartFile.get(0).getOriginalFilename().equals("")) {

				for (MultipartFile file : multipartFile) {
					fileRoot = contextRoot + "resources/property_img/";
					System.out.println(fileRoot);

					String originalFileName = file.getOriginalFilename(); // 오리지날 파일명
					String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자
					long time = System.currentTimeMillis();
					String savedFileName = time + extension; // 저장될 파일 명

					if (!isValidExtension(originalFileName)) { // 확장자 검사
						return strResult = "{ \"result\":\"UNACCEPTED_EXTENSION\" }";
					}

					sizeSum += file.getSize(); // 사진의 총 사이즈 검사
					if (sizeSum >= 5 * 1024 * 1024) { // 500MB
						return strResult = "{ \"result\":\"EXCEED_SIZE\" }";
					}

					File targetFile = new File(fileRoot + savedFileName);
					try {
						InputStream fileStream = file.getInputStream();
						FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
						listImgUrl.add(fileRoot + time + originalFileName);
						System.out.println("사진 주소: " + fileRoot + time + originalFileName);
						session.setAttribute("listImgUrl", listImgUrl);
						/* <img src="<spring:url value='/resources/img/testimg.png'/>"> */
					} catch (Exception e) {
						// 파일삭제
						FileUtils.deleteQuietly(targetFile); // 저장된 현재 파일 삭제
						e.printStackTrace();
						break;
					}
				}
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
	@RequestMapping("/host/name_description_7")
	public String name_description_7() {
		return "/host/property_insert/name_description_7";
	}

	@Override
	@RequestMapping("/host/price_8")
	public String price_8(HttpServletRequest req, String name, String description) {
		HttpSession session = req.getSession();
		session.setAttribute("name", name);
		session.setAttribute("description", description);

		System.out.println(name);
		System.out.println(description);
		return "/host/property_insert/price_8";
	}

	@Override
	@RequestMapping("/host/preview_9")
	public String preview_9(HttpServletRequest req, @RequestParam int price) {
		HttpSession session = req.getSession();
		session.setAttribute("price", price);
//		session.getAttribute("propertyTypeId");
//		session.getAttribute("propertyTypeName");
//		session.getAttribute("subPropertyTypeId");
//		session.getAttribute("subPropertyTypeName");
//		session.getAttribute("roomTypeId");
//		session.getAttribute("roomTypeName");
//		session.getAttribute("address");
//		session.getAttribute("maxGuest");
//		session.getAttribute("bedCount");
//		session.getAttribute("listAmenities");
//		session.getAttribute("name");
//		session.getAttribute("description");
		session.getAttribute("사진도 받기");

		List<String> listAmenityName = new ArrayList<>();
		List<AmenityTypeDTO> listAmenityType = hostMapper.getAmenityTypeList();
		List<Integer> amenities = (List<Integer>) session.getAttribute("listAmenities");
		for (int i : amenities) {
			for (AmenityTypeDTO dto : listAmenityType) {
				if (i == dto.getId()) {
					listAmenityName.add(dto.getName());
				}
			}
		}

		session.setAttribute("listAmenityName", listAmenityName);
		return "/host/property_insert/price_8";
	}

	@Override
	@RequestMapping("/host/publish_celebration_10")
	public String publish_celebration_10(HttpServletRequest req) {
		HttpSession session = req.getSession();
		List<Integer> amenities = (List<Integer>) session.getAttribute("listAmenities");
		// 여러가지 편의시설
		session.getAttribute("사진도 받기");

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
		int ok = hostMapper.insertProperty(dtoPro);

		int propertyId = hostMapper.getPropertyId(hostId);
		for (int i : amenities) {
			AmenityDTO dto = new AmenityDTO();
			dto.setAmenityTypeId(i);
			dto.setPropertyId(propertyId);
			hostMapper.insertPropertyAmenity(dto);
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

		// 사진도 지우기
		return "/host/property_insert/publish_celebration_10";
	}

	//////////////////////////////////////////////////////////////////////////////////////
	// 3. host_mode 페이지
	//////////////////////////////////////////////////////////////////////////////////////

	

	/*
	 * session.setAttribute("member_id", dto.getId());
	 * session.setAttribute("member_name", dto.getName());
	 */
	@Override
	@RequestMapping("/host/host_mode")
	public ModelAndView host_mode(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String hostId = (String) session.getAttribute("member_id");
		List<BookingDTO> listBooking = hostMapper.getBookingList(hostId);
		java.sql.Date today = hostMapper.getSysdate();
		ModelAndView mav = new ModelAndView("/host/host_mode/host_mode");
		mav.addObject("listBooking", listBooking);
		mav.addObject("today", today);
		return mav;
	}

	@Override
	@RequestMapping("host/host_properties_list")
	public ModelAndView host_properties_list(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String hostId = (String) session.getAttribute("member_id");
		List<PropertyDTO> listProperty = hostMapper.getPropertyList(hostId);
		ModelAndView mav = new ModelAndView("/host/host_mode/host_properties_list", "listProperty", listProperty);
		return mav;
	}

	@Override
	@RequestMapping(value = "host/properties_update", method = RequestMethod.GET)
	public ModelAndView host_getProperty(HttpServletRequest req, int propertyId) {
		HttpSession session = req.getSession();
		PropertyDTO dto = hostMapper.getProperty(propertyId);
		ModelAndView mav = new ModelAndView("/host/host_mode/properties_update", "propertyDTO", dto);
		return mav;
	}

	@Override
	@RequestMapping(value = "host/properties_update", method = RequestMethod.POST)
	public ModelAndView host_property_update(HttpServletRequest req, @RequestParam Map<String, String> map,
			@RequestParam("files") List<MultipartFile> images) {
		// msg, url
		return new ModelAndView("/message");
	}

	@Override
	@RequestMapping("/host/transaction_list")
	public ModelAndView transaction_list(HttpServletRequest req) {
		HttpSession session = req.getSession();
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
	@RequestMapping("/host/host_review_list")
	public ModelAndView host_review_list(HttpServletRequest req) {
		// TODO Auto-generated method stub
		return new ModelAndView("/host/host_mode/host_review_list");
	}

	public java.util.Date addMonth(Date date, int months) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MONTH, months);
		return cal.getTime();
	}

	@Override
	@RequestMapping("/host/total_earning")
	public ModelAndView total_earning(HttpServletRequest req) {
		HttpSession session = req.getSession();
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

	@Override
	@RequestMapping("/host/host_support")
	public ModelAndView host_support(HttpServletRequest req) {
		// TODO Auto-generated method stub
		return new ModelAndView("/host/host_mode/host_support");
	}

}