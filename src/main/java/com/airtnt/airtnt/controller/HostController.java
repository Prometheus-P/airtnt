package com.airtnt.airtnt.controller;

import java.io.File;
import java.util.Hashtable;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping("host")
public class HostController {

	/*
	 * @Autowired private HostMapper hostMapper;
	 */
	Map<String, String> roomMap;

	// 1. 호스트 시작하기 >> property_type으로 이동
	// 나머지는 게시판
	@RequestMapping("/property_type")
	public String room_type_jsp() {
		return "host/become_a_host/room_type_group";
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

	// 2. property_type으로 이동해서 분류 시작
	// roomMap & amenitiesMap


	@RequestMapping("/sub_property_type")
	public String sub_property_type(HttpServletRequest req, @RequestParam String propertyType) {
		HttpSession session = req.getSession();
		roomMap = new Hashtable<>();
		roomMap.put("propertyType", propertyType);
		session.setAttribute("roomMap", roomMap);
		return "host/become_a_host/sub_property_type";
	}

	@RequestMapping("/room_type") // 개인실, 다인실, 전체
	public String room_type(HttpServletRequest req, @RequestParam String subPropertyType) {
		HttpSession session = req.getSession();
		roomMap = (Map<String, String>) session.getAttribute("roomMap");
		roomMap.put("subPropertyType" /* + roomId */, subPropertyType);
		session.setAttribute("roomMap", roomMap);
		return "host/become_a_host/room_type";
	}

	@RequestMapping("/location")
	public String location(HttpServletRequest req, @RequestParam String roomType) {
		HttpSession session = req.getSession();
		roomMap = (Map<String, String>) session.getAttribute("roomMap");
		roomMap.put("roomType", roomType);
		session.setAttribute("roomMap", roomMap);
		return "host/become_a_host/location";
	}

	@RequestMapping("/detail")
	public String detail(HttpServletRequest req, @RequestParam String address) {
		HttpSession session = req.getSession();
		roomMap = (Map<String, String>) session.getAttribute("roomMap");
		roomMap.put("address", address);
		session.setAttribute("roomMap", roomMap);
		return "host/become_a_host/detail";
	}

	@RequestMapping("/photos")
	public String photos(HttpServletRequest req, @RequestParam Map<String, String> map) {
		HttpSession session = req.getSession();
		roomMap = (Map<String, String>) session.getAttribute("roomMap");
		roomMap.put("maxGuest", map.get("maxGuest"));
		map.remove("maxGuest"); // 편의 시설들만 남기기
		session.setAttribute("amenitiesMap", map);
		session.setAttribute("roomMap", roomMap);
		return "host/become_a_host/photos";
	}

	@RequestMapping("/description")
	public String description(HttpServletRequest req) {
		HttpSession session = req.getSession();
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
		MultipartFile mf = mr.getFile("fileName");
		String fileName = mf.getOriginalFilename();
		String upPath = session.getServletContext().getRealPath("");
		File file = new File(upPath, fileName);
		roomMap = (Map<String, String>) session.getAttribute("roomMap");
		roomMap.put("fileName", fileName);
		roomMap.put("fileSize", Long.toString(file.length()));
		/*
		 * dto.setFilename(filename); dto.setFilesize((int) file.length());
		 * dto.setIp(req.getRemoteAddr());
		 */
		try {
			mf.transferTo(file);
		} catch (Exception e) {
			roomMap.put("alert", "사진 업로드 중 오류 발생!");
			e.printStackTrace();
		}
		session.setAttribute("roomMap", roomMap);
		return "host/become_a_host/description";
	}

	@RequestMapping("/price")
	public String price(HttpServletRequest req, @RequestParam Map<String, String> map) {
		HttpSession session = req.getSession();
		roomMap = (Map<String, String>) session.getAttribute("roomMap");
		roomMap.put("roomName", map.get("roomName"));
		roomMap.put("description", map.get("description"));
		session.setAttribute("roomMap", roomMap);
		return "host/become_a_host/price";
	}

	@RequestMapping("/preview")
	public String preview(HttpServletRequest req, @RequestParam String price) {
		HttpSession session = req.getSession();
		roomMap = (Map<String, String>) session.getAttribute("roomMap");
		roomMap.put("price", price);
		session.setAttribute("roomMap", roomMap);
		return "host/become_a_host/preview";
	}

	@RequestMapping("/publish_celebration")
	public String publish_celebration(HttpServletRequest req) {
		HttpSession session = req.getSession();
		roomMap = (Map<String, String>) session.getAttribute("roomMap");
		// Mapper 통해서 정보저장
		/*
		 * RoomPhotoDTO dto = new RoomPhotoDTO(); dto.setMemberId dtp.setPropertyId
		 * dto.setPhotoName dto.setPhtoSize
		 */
		session.removeAttribute("roomMap");
		session.removeAttribute("amenitiesMap");
		return "host/become_a_host/publish_celebration";
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