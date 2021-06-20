package com.airtnt.airtnt.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.airtnt.airtnt.model.BookingDTO;


@Controller
@RequestMapping("host")
public class HostController {
	/*@Autowired
	private HostMapper hostMapper;*/

	//1. 호스트 시작하기 >> room_type_group으로 이동
	//나머지는 게시판
	@RequestMapping("/room_type")
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
	//2. room_type_group으로 이동해서 분류 시작
	
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
	 @RequestMapping("/hosting_listing")// 숙소 목록
	public ModelAndView hosting_listing() {
		List<String, BookingDTO> listBooking; 
		return new ModelAndView("host/host_mode/host_mode_main", "listBooking", listBooking);
	}
	
	
	*/
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}