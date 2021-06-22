package com.airtnt.airtnt.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.airtnt.airtnt.model.BookingDTO;


@Controller
@RequestMapping("host")
public class HostController {
	
	/*@Autowired
	private HostMapper hostMapper;*/
	HttpSession session;
	
	public HostController(HttpServletRequest req) {
		session = req.getSession();
	}
	
	//1. 호스트 시작하기 >> property_type으로 이동
	//나머지는 게시판
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
	
	//2. property_type으로 이동해서 분류 시작
	// roomId를 미리 발급 해서 session에서 겹치지 않게 가능한가...?
	
	 @RequestMapping("/property_type")
	public String property_type() {
		return "host/become_a_host/property_type";
	}
	
	@RequestMapping("/sub_property_type")
	public String sub_property_type(@RequestParam String propertyType) {
		session.setAttribute("propertyType", propertyType);
		return "host/become_a_host/sub_property_type";
	}
	
	@RequestMapping("/room_type") // 개인실, 다인실, 전체
	public String room_type(@RequestParam String subPropertyType) {
		session.setAttribute("subPropertyType" /* + roomId */, subPropertyType);
		return "host/become_a_host/room_type";
	}
	@RequestMapping("/location")
	public String location(@RequestParam String roomType) {
		session.setAttribute("roomType", roomType);
		return "host/become_a_host/location";
	}
	@RequestMapping("/detail")
	public String detail(@RequestParam String address) {
		session.setAttribute("address", address);
		return "host/become_a_host/detail";
	}
	@RequestMapping("/photos")
	public String photos(@RequestParam Map<String, String> map) {
		session.setAttribute("maxGuest", map.get("maxGuest"));
		map.remove("maxGuest");//편의 시설들만 남기기
		session.setAttribute("amenitiesMap", map);
		return "host/become_a_host/photos";
	}
	@RequestMapping("/description")
	public String description(@RequestParam Map<String, String> map) {
		session.setAttribute("roomName", map.get("roomName"));
		return "host/become_a_host/description";
	}
	/*
	 * session.setAttribute("roomName", map.get("roomName"));
	 * session.setAttribute("description", map.get("description"));
	 */
	//3. host_mode_main >> 호스트 모드
	/*@RequestMapping("/host_mode_main")// 호스트 모드로 전환
	public ModelAndView host_mode_main() {
		List<String, BookingDTO> listBooking; // 예약 목록 전달
		return new ModelAndView("host/host_mode/host_mode_main", "listBooking", listBooking);
	}*/
	/*
	 @RequestMapping("/hosting_listing")// 숙소 목록
	public ModelAndView hosting_listing() {
		List<String, BookingDTO> listBooking; 
		return new ModelAndView("host/host_mode/host_mode_main", "listBooking", listBooking);
	}
	 @RequestMapping("/hosting_listing")// 
	public ModelAndView hosting_listing() {
		List<String, BookingDTO> listBooking; 
		return new ModelAndView("host/host_mode/host_mode_main", "listBooking", listBooking);
	}
	
	
	*/
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}