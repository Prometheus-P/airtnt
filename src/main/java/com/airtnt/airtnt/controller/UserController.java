package com.airtnt.airtnt.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.airtnt.airtnt.model.MemberDTO;
import com.airtnt.airtnt.service.MemberMapper;

@Controller
public class UserController {
	
	@Autowired
	MemberMapper memberMapper;
	
	@RequestMapping("signUp")
	public String signUp(HttpServletRequest req, @ModelAttribute MemberDTO dto) {
		int res = memberMapper.inputMember(dto);
		if(res>0) {
			req.setAttribute("msg", "가입완료");
			req.setAttribute("url", "index");
		}else {
			req.setAttribute("msg", "사용중인 아이디입니다");
			req.setAttribute("url", "index");
		}
		return "message";
	}
	
	@RequestMapping("/login")
	public String list(HttpServletRequest req) {
		//List<StudentDTO> list = studentMapper.listStudent();
		//req.setAttribute("listStudent", list);
		return "student/list";
	}
}
