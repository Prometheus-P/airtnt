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

import com.airtnt.airtnt.model.AmenityDTO;
import com.airtnt.airtnt.model.AmenityTypeDTO;
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
	public ModelAndView sub_property_type_1(HttpServletRequest req, @RequestParam int propertyTypeId) {
		HttpSession session = req.getSession();
		session.setAttribute("propertyTypeId", propertyTypeId);
		List<SubPropertyTypeDTO> listSubPropertyType = hostMapper.getSubPropertyType(propertyTypeId);
		ModelAndView mav = new ModelAndView("host/property_insert/sub_property_type_1");
		mav.addObject("listSubPropertyType", listSubPropertyType);
		return mav;
	}

	@Override
	@RequestMapping("/host/room_type_2")
	public ModelAndView room_type_2(HttpServletRequest req, @RequestParam int subPropertyType) {
		HttpSession session = req.getSession();
		session.setAttribute("subPropertyTypeId", subPropertyType);
		List<RoomTypeDTO> listRoomType = hostMapper.getRoomType();
		ModelAndView mav = new ModelAndView("host/property_insert/room_type_2");
		mav.addObject("listRoomType", listRoomType);
		return mav;
	}

	@Override
	@RequestMapping("/host/address_3")
	public String address_3(HttpServletRequest req, @RequestParam int roomTypeId) {
		HttpSession session = req.getSession();
		session.setAttribute("roomTypeId", roomTypeId);
		return "host/property_insert/address_3";
	}

	@Override
	@RequestMapping("/host/floor_plan_4")
	public String floor_plan_4(HttpServletRequest req, @RequestParam String address) {
		HttpSession session = req.getSession();
		session.setAttribute("address", address);
		return "host/property_insert/floor_plan_4";
	}

	@Override
	@RequestMapping("/host/amenities_5")
	public ModelAndView amenities_5(HttpServletRequest req, @RequestParam Map<String, Integer> floor) {
		HttpSession session = req.getSession();
		session.setAttribute("mapFloor", floor);
		List<AmenityTypeDTO> list = hostMapper.getAmenityTypeList();
		return new ModelAndView("/host/property_insert/amenities_5", "listAmenityType", list);
	}

	@Override
	@RequestMapping("/host/photos_6")//name = amenities로 페이지에서 보내야 함
	public String photos_6(HttpServletRequest req, 
			@RequestParam(value="amenities", required=true) List<Integer> amenities) {
		HttpSession session = req.getSession();
		session.setAttribute("listAmenities", amenities);
		return "/host/property_insert/photos_6";
	}

	@Override
	@ResponseBody
	@RequestMapping(value = "/host/photos_upload")
	public int photos_upload(HttpServletRequest req, List<MultipartFile> images) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	@RequestMapping("/host/name_description_7")
	public String title_description_7() {
		return "/host/become_a_host/name_description_7";
	}

	@Override
	@RequestMapping("/host/price_8")
	public String price_8(HttpServletRequest req, @RequestParam Map<String, String> nameDesc) {
		HttpSession session = req.getSession();
		session.setAttribute("mapNameDesc", nameDesc);
		return "/host/become_a_host/price_8";
	}

	@Override
	@RequestMapping("/host/preview_9")
	public String preview_9(HttpServletRequest req, @RequestParam int price) {
		HttpSession session = req.getSession();
		session.setAttribute("price", price);
		Map<String, String> nameDesc = (Map<String, String>)session.getAttribute("mapNameDesc");
		Map<String, Integer> floor = (Map<String, Integer>)session.getAttribute("mapFloor");
		List<Integer> amenities = (List<Integer>)session.getAttribute("listAmenities");
		
		session.getAttribute("사진도 받기");
		List<AmenityTypeDTO> listAmenityType = hostMapper.getAmenityTypeList();
		List<SubPropertyTypeDTO> listSubPropertyType = hostMapper.getSubPropertyType(session.getAttribute("propertyId"));
		List<RoomTypeDTO> listRoomType = hostMapper.getRoomType();
		int count=0;
		String amenityName[];
		for(int i : amenities) {
			for(AmenityTypeDTO dto : listAmenityType) {
				if(i == dto.getId()) {
					amenityName[count] = dto.getName();
					count++;
				}
			}
		}
		List<PropertyTypeDTO> listPropertyType = hostMapper.getPropertyType();
		session.setAttribute("bedCount", floor.get("bedCount"));
		session.setAttribute("maxGuest", floor.get("maxGuest"));
		session.setAttribute("name", nameDesc.get("name"));
		session.setAttribute("description", nameDesc.get("description"));
		session.setAttribute("listAmenityName", amenityName);
		
		session.removeAttribute("mapFloor");
		session.removeAttribute("mapNameDesc");
		return "/host/become_a_host/price_8";
	}

	@Override
	@RequestMapping("/host/publish_celebration_10")
	public String publish_celebration_10(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String hostId = (String)session.getAttribute("member_id");
		int propertyTypeId = (int)session.getAttribute("propertyTypeId");
		int subPropertyTypeId = (int)session.getAttribute("subPropertyTypeId");
		int roomTypeId = (int)session.getAttribute("roomTypeId");
		String address = (String)session.getAttribute("address");
		int bedCount = (int)session.getAttribute("bedCount");
		int maxGuest = (int)session.getAttribute("maxGuest");
		String name = (String)session.getAttribute("name");
		String description = (String)session.getAttribute("description");
		List<Integer> amenities = (List<Integer>)session.getAttribute("listAmenities");
		//여러가지 편의시설
		session.getAttribute("사진도 받기");
		int price = (int)session.getAttribute("price");
	
		PropertyDTO dtoPro = new PropertyDTO();
		dtoPro.setHostId(hostId);
		dtoPro.setAddress(address);
		dtoPro.setBedCount(bedCount);
		dtoPro.setMaxGuest(maxGuest);
		dtoPro.setName(name);
		dtoPro.setPropertyDesc(description);
		dtoPro.setPrice(price);
		dtoPro.setPropertyTypeId(propertyTypeId);
		dtoPro.setSubPropertyTypeId(subPropertyTypeId);
		dtoPro.setRoomTypeId(roomTypeId);
		int ok = hostMapper.insertProperty(dtoPro);
		
		int propertyId = hostMapper.getPropertyId(hostId);
		AmenityDTO dto[];
		int count=0;
		int result=0;
		for(int i : amenities) {
			 dto = new AmenityDTO[count];
			 dto[count].setAmenityTypeId(i);
			 dto[count].setPropertyId(propertyId);
			 result += hostMapper.insertPropertyAmenity(dto[count]);
			 count++;
		}
		session.removeAttribute("bedCount");
		session.removeAttribute("maxGuest");
		session.removeAttribute("description");
		session.removeAttribute("name");
		session.removeAttribute("propertyTypeId");
		session.removeAttribute("subPropertyTypeId");
		session.removeAttribute("roomTypeId");
		session.removeAttribute("address");
		session.removeAttribute("listAmenities");
		session.removeAttribute("price");
		return "/host/property_insert/publish_celebration_10";
	}
	
	//////////////////////////////////////////////////////////////////////////////////////
	//3. host_mode 페이지
	//////////////////////////////////////////////////////////////////////////////////////
	
	@Override
	@RequestMapping("host/host_mode")
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