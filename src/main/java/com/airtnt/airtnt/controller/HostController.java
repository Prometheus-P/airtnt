package com.airtnt.airtnt.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.airtnt.airtnt.model.BookingDTO;
import com.airtnt.airtnt.model.GuideDTO;
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

	// 1. 호스트 시작하기 >>으로 이동
	// 나머지는 게시판
	@Override
	@RequestMapping("host/guide_home")
	public ModelAndView guide_home() {
		List<GuideDTO> listGuide = hostMapper.getGuideList();
		// System.out.print(guideList.get(0).getId());
		return new ModelAndView("host/guide/guide_home", "listGuide", listGuide);
	}

	@Override
	@RequestMapping("host/guide_context")
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

	// 2. property_type_0으로 이동해서 분류 시작
	@Override
	@RequestMapping("host/property_type_0")
	public ModelAndView property_type_0() {
		List<PropertyTypeDTO> propertyTypeList = hostMapper.getPropertyType();
		return new ModelAndView("host/become_a_host/property_type_0", "propertyTypeList", propertyTypeList);
	}

	@Override
	@RequestMapping("host/property_detail_1")
	public ModelAndView property_detail_1(HttpServletRequest req, @RequestParam int propertyTypeId) {
		HttpSession session = req.getSession();
		session.setAttribute("propertyTypeId", propertyTypeId);
		List<SubPropertyTypeDTO> subPropertyTypeList = hostMapper.getSubPropertyType(propertyTypeId);
		List<RoomTypeDTO> roomTypeList = hostMapper.getRoomType();
		ModelAndView mav = new ModelAndView("host/become_a_host/property_detail_1");
		mav.addObject("subPropertyTypeList", subPropertyTypeList);
		mav.addObject("roomTypeList", roomTypeList);
		return mav;
	}

	@Override
	@RequestMapping("host/property_address_2") // 개인실, 다인실, 전체
	// sub_property_type(int) &
	// room_type(int) & maxGuest(int)(proptertyDTO) &
	// bedCount(int)(proptertyDTO) >> (property_detail_1)
	public String property_address_2(HttpServletRequest req, @RequestParam Map<String, Integer> map1) {
		HttpSession session = req.getSession();
		session.setAttribute("map1", map1);
		return "host/become_a_host/property_address_2";
	}

	@Override
	@RequestMapping("host/property_detail_3")
	public String property_detail_3(HttpServletRequest req, @RequestParam String address) {
		HttpSession session = req.getSession();
		session.setAttribute("address", address);
		System.out.print(address);
		return "host/become_a_host/property_detail_3";
	}

	// amenities(int) & room_name(String) & description(String) & price(int)
	// (property_detail_3)
	@Override
	@RequestMapping("/host/property_image_4")
	public String property_image_4(HttpServletRequest req, @RequestParam Map<String, String> map2) {
		HttpSession session = req.getSession();
		session.setAttribute("map2", map2);
		return "host/become_a_host/property_image_4";
	}

	private static final int RESULT_EXCEED_SIZE = -2;
	private static final int RESULT_UNACCEPTED_EXTENSION = -1;
	private static final int RESULT_SUCCESS = 1;
	private static final long LIMIT_SIZE = 10 * 1024 * 1024;

	@Override
	@ResponseBody
	@RequestMapping(value = "/host/image_upload")
	public int image_upload(HttpServletRequest req, @RequestParam("files") List<MultipartFile> images) {
		long sizeSum = 0;
		for (MultipartFile image : images) {
			String originalName = image.getOriginalFilename();
			// 확장자 검사
			if (!isValidExtension(originalName)) {
				return RESULT_UNACCEPTED_EXTENSION;
			}

			// 용량 검사
			sizeSum += image.getSize();
			if (sizeSum >= LIMIT_SIZE) {
				return RESULT_EXCEED_SIZE;
			}
		}
		for (MultipartFile image : images) {
			String originalName = image.getOriginalFilename();
			if (originalName != null && !originalName.trim().equals("")) {
				originalName += "_" + System.currentTimeMillis();
			}
			try {
				image.transferTo(new File("/resources/property_img/" + originalName));
				System.out.print(originalName);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return RESULT_SUCCESS;
	}

	private boolean isValidExtension(String originalName) {
		String originalNameExtension = originalName.substring(originalName.lastIndexOf(".") + 1);
		switch (originalNameExtension) {
		case "jpg":
		case "png":
		case "gif":
			return true;
		}
		return false;
	}

	@Override
	@RequestMapping("/host/property_preview_5")
	public String property_preview_5(HttpServletRequest req) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@RequestMapping("/host/publish_celebration_6")
	public String publish_celebration_6(HttpServletRequest req) {
		HttpSession session = req.getSession();
		Map<String, Integer> map1 = (Map<String, Integer>) session.getAttribute("map1");

		/*
		 * property_type(int) & sub_property_type(int) & room_type(int) &
		 * maxGuest(int)(proptertyDTO) & bedCount(int)(proptertyDTO)
		 */
		String address = (String) session.getAttribute("address");
		Map<String, String> map2 = (Map<String, String>) session.getAttribute("map2");
		/*
		 * amenities(int) & room_name(String) & description(String) & price(int)
		 * (property_detail_3)
		 */
		session.getAttribute("map3");
		// 사진
		return "host/become_a_host/publish_celebration_6";
	}

	@Override
	@RequestMapping("host/host_mode")
	public ModelAndView host_mode(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String hostId = (String) session.getAttribute("member_id");
		List<BookingDTO> listBooking = hostMapper.getBookingList(hostId);
		return new ModelAndView("/host/host_mode/host_mode", "listBooking", listBooking);
	}

	@Override
	@RequestMapping("host/host_properties_list")
	public ModelAndView host_properties_list(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String hostId = (String) session.getAttribute("member_id");
		List<PropertyDTO> listProperty = hostMapper.getPropertyList(hostId);
		return new ModelAndView("/host/host_mode/host_properties_list", "listProperty", listProperty);
	}

	@Override
	@RequestMapping(value = "host/properties_update", method = RequestMethod.GET)
	public ModelAndView host_getProperty(HttpServletRequest req, int propertyId) {
		PropertyDTO dto = hostMapper.getProperty(propertyId);
		return new ModelAndView("/host/host_mode/properties_update", "propertyDTO", dto);
	}

	@Override
	@RequestMapping(value = "host/properties_update", method = RequestMethod.POST)
	public ModelAndView host_property_update(HttpServletRequest req, @RequestParam Map<String, String> map,
		@RequestParam("files") List<MultipartFile> images) {
		//msg, url
		return new ModelAndView("/message");
	}

	@Override
	@RequestMapping("/host/transaction_list")
	public ModelAndView transaction_list(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String hostId = (String) session.getAttribute("member_id");
		List<TransactionDTO> listTransaction = hostMapper.getTransactionList(hostId);
		// 6월 29, 2021 10:31:02 오전
		int count = 0;
		ModelAndView mav = new ModelAndView("/host/host_mode/transaction_list");
		for (TransactionDTO dto : listTransaction) { // 대금예정이 없습니다
			if (dto.getPayExptDate() == null) {
				count++;
			}
		}
		if (count == listTransaction.size()) {
			mav.addObject("isTran", true);
		}
		Date nowTime = new Date();
		mav.addObject("listTransaction", listTransaction);
		mav.addObject("today", nowTime);
		mav.addObject("isTran", false);
		return mav;
	}

	@Override
	@RequestMapping("/host/host_review_list")
	public ModelAndView host_review_list(HttpServletRequest req) {
		// TODO Auto-generated method stub
		return new ModelAndView("/host/host_mode/host_review_list");
	}

	public Date addMonth(Date date, int months) {
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
		Date date = new Date();
		Date beM[] = new Date[13];
		ModelAndView mav = new ModelAndView("/host/host_mode/total_earning");
		List<Integer> listTotal = new ArrayList<>();
		int total[] = new int[12];
		for (int i = 0; i < 13; ++i) {
			beM[i] = addMonth(date, -i);
		}
		for (TransactionDTO dto : list) { // 6개월 전
			for (int i = 0; i < 12; ++i) {
				if (beM[i + 1].before(dto.getPayExptDate()) && dto.getPayExptDate().before(beM[i])) {
					total[i] += dto.getTotalPrice();
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