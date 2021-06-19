package com.airtnt.airtnt.controller;

import java.util.List;


import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.airtnt.airtnt.service.RoomMapper;


@Controller
@RequestMapping("/room")
public class RoomController {
	@Autowired
	private RoomMapper roomMapper;
	/*
	 * 1. 방 정보 입력(/host/become_a_host 에서 오는 정보로 방 생성) 
	 * 2. 방 정보 출력
	 * 
	 */
	
	
	@RequestMapping("/register")// 방 등록
	public String register(Map<String, String> map) {
		
		return "";
	}
}
