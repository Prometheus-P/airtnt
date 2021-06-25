package com.airtnt.airtnt.controller;

import java.io.File;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Enumeration;
import java.util.Formatter;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.airtnt.airtnt.host.Vo;
import com.airtnt.airtnt.model.PropertyTypeDTO;
import com.airtnt.airtnt.model.RoomTypeDTO;
import com.airtnt.airtnt.model.SubPropertyTypeDTO;
import com.airtnt.airtnt.service.HostMapper;


@Controller
@RequestMapping("host")
@SuppressWarnings("unchecked")
public class HostController {

	@Autowired private HostMapper hostMapper;
	 

	// 1. 호스트 시작하기 >> property_type으로 이동
	// 나머지는 게시판
	@RequestMapping("/before_host")
	public String before_host_jsp() {
		return "host/before_host/before";
	}

	@RequestMapping("/hosting_context_get_started")
	public String context_get_started_jsp() {
		return "host/before_host/hosting_context_get_started";
	}

	@RequestMapping("/hosting_context_basic")
	public String context_basic_jsp() {
		return "host/before_host/hosting_context_basic";
	}

	@RequestMapping("/hosting_context_confidence")
	public String context_confidence_jsp() {
		return "host/before_host/hosting_context_confidence";
	}

	// 2. property_detail으로 이동해서 분류 시작
	// roomMap & amenitiesMap
	@RequestMapping("/property_type_0")
	public ModelAndView property_type_0(HttpServletRequest req) {
		HttpSession session = req.getSession();
		List<PropertyTypeDTO> propertyTypeList = hostMapper.getPropertyType();
		return new ModelAndView("host/become_a_host/property_type_0","propertyTypeList", propertyTypeList);
	}
	//property_type(int)
	@RequestMapping("/property_detail_1")
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

	@RequestMapping("/property_address_2") // 개인실, 다인실, 전체
	// sub_property_type(int) & 
	//room_type(int) & maxGuest(int)(proptertyDTO) &
	//bedCount(int)(proptertyDTO) >> (property_detail_1)
	public String property_address_2(HttpServletRequest req, @RequestParam Map<String, Integer> map1) {
		HttpSession session = req.getSession();
		session.setAttribute("map1", map1);
		return "host/become_a_host/property_address_2";
	}

	@RequestMapping("/property_detail_3")
	public String property_detail_3(HttpServletRequest req, @RequestParam String address) {
		HttpSession session = req.getSession();
		session.setAttribute("address", address);
		return "host/become_a_host/property_detail_3";
	}
	//amenities(int) & room_name(String) & description(String) & price(int)
	//(property_detail_3)
	@RequestMapping("/property_image_4")
	public String property_image_4(HttpServletRequest req, @RequestParam Map<String, String> map2) {
		HttpSession session = req.getSession();
		session.setAttribute("map2", map2);
		return "host/become_a_host/property_image_4";
	}

	/*
	 * @RequestMapping("/save_image") public String save_image(Vo vo) { try {
	 * Map<String, Object> hmap = new HashMap<String, Object>(); hmap.put("img",
	 * vo.getImgFile().getBytes()); hostMapper.saveImage(hmap); }catch(Exception e)
	 * { e.printStackTrace(); } return "redirect:host/property_image_4"; }
	 */
	/*
	@RequestMapping(value="/save_image", method = RequestMethod.POST, produces="text/plain;Charset=UTF-8")
	@ResponseBody
	public void uploadContent(MultipartHttpServletRequest req) throws Exception{
		Gson gson = new Gson();
		FolderSet set = new FolderSet();
		 List<MultipartFile> mf = req.getFiles("files[]");
	}
	*/
	/*
	 * @RequestMapping(value="/save_image", method = RequestMethod.POST,
	 * produces="text/plain; Charset=UTF-8")
	 * 
	 * @ResponseBody public void uploadContent(MultipartHttpServletRequest req) {
	 * Gson gson = new Gson(); FolderSet set = new FolderSet();
	 * List<MultipartFile> mf = req.getFiles("files[]"); }
	 */
	
	
	@RequestMapping("/property_preview_5")
	public String property_preview_5(HttpServletRequest req) {
		HttpSession session = req.getSession();
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
		Map<String, String> map3= new Hashtable<>();
		MultipartFile mf = mr.getFile("filename");
		Hashtable<String, MultipartFile> map = (Hashtable<String, MultipartFile>) mr.getFileMap();
		Enumeration<String> en = map.keys();
		int i = 0;
		while (en.hasMoreElements()) {
			String key = en.nextElement();
			MultipartFile image = map.get(key);
			String fileName = image.getOriginalFilename();
			String upPath = session.getServletContext().getRealPath("");
			String now = new java.text.SimpleDateFormat("yyyyMMddHmsS").format(new java.util.Date());
			String fullFileName = "/image/" + fileName + ".jpeg";//절대 경로와 파일명
			File file = new File(upPath, fileName);
			map3.put("fileName", fileName);
			//    image/property/property_id-시간-for문 숫자
			//
			String fileSizeStr = String.format("%.1f", file.length() / 1024.0);
			// ex) 214.2 메가바이트 이렇게 표시 가능

			map3.put("fileSize", fileSizeStr/* Long.toString(file.length()) */);
			try {
				mf.transferTo(file);
			} catch (Exception e) {
				map3.put("alert", "사진 업로드 중 오류 발생!");
				e.printStackTrace();
			}
			i++;
		}
		session.setAttribute("map3", map3);
		/*
		 * dto.setFilename(filename); dto.setFilesize((int) file.length());
		 * dto.setIp(req.getRemoteAddr());
		 */
		return "host/become_a_host/property_preview_5";
	}

	@RequestMapping("/publish_celebration_6")
	public String publish_celebration_6(HttpServletRequest req) {
		HttpSession session = req.getSession();
		Map<String, Integer> map1 = (Map<String, Integer>) session.getAttribute("map1");
		
		/*property_type(int) & sub_property_type(int) & 
		room_type(int) & maxGuest(int)(proptertyDTO) &
		bedCount(int)(proptertyDTO)*/
		String address = (String)session.getAttribute("address");
		Map<String, String> map2 = (Map<String, String>)session.getAttribute("map2");
		/*
		amenities(int) & room_name(String) & description(String) & price(int)
		(property_detail_3)*/
		session.getAttribute("map3");
		//사진
		return "host/become_a_host/publish_celebration_6";
	}

	// 3. host_mode_main >> 호스트 모드
	/*
	 * @RequestMapping("/host_mode_main")// 호스트 모드로 전환 public ModelAndView
	 * host_mode_main() { List<String, BookingDTO> listBooking; // 예약 목록 전달 return
	 * new ModelAndView("host/host_mode/host_mode_main", "listBooking",
	 * listBooking); }
	 */
	/*
	 * @RequestMapping("/hosting_listing")// 숙소 목록 public ModelAndView
	 * hosting_listing() { List<String, BookingDTO> listBooking; return new
	 * ModelAndView("host/host_mode/host_mode_main", "listBooking", listBooking); }
	 * 
	 * @RequestMapping("/hosting_listing")// public ModelAndView hosting_listing() {
	 * List<String, BookingDTO> listBooking; return new
	 * ModelAndView("host/host_mode/host_mode_main", "listBooking", listBooking); }
	 * 
	 * 
	 */

}