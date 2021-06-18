package com.airtnt.airtnt.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.airtnt.airtnt.service.RoomMapper;

@Controller
public class GuestController {

	
	 @Autowired
	 private RoomMapper roomMapper;
	 

	@RequestMapping("search_room")
	public String searchRoom() {

		return "guest/room/room_list";
	}

	@RequestMapping("room_detail")
	public String detail() {

		return "guest/room/room_detail";
	}

	@RequestMapping("booking")
	public String booking() {

		return "guest/room/reserve";
	}

	@RequestMapping("booking_confirm")
	public String confirm() {

		return "guest/room/confirm";
	}

}
