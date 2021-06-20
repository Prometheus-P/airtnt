package com.airtnt.airtnt.controller;

import java.util.List;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping("host")
public class HostController {
	/*@Autowired
	private HostMapper hostMapper;*/

	@RequestMapping("/room_type")
	public String room_type_jsp() {
		return "member/member_index";
	}
}