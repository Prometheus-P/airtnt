package com.airtnt.airtnt.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.airtnt.airtnt.guest.LoginOKBean;
import com.airtnt.airtnt.model.MemberDTO;
import com.airtnt.airtnt.model.WishListDTO;
import com.airtnt.airtnt.service.MemberMapper;
import com.airtnt.airtnt.service.WishListMapper;

@Controller
public class UserController {
	
	@Autowired
	MemberMapper memberMapper;
	@Autowired
	WishListMapper wishListMapper;
	
	// 회원가입
	@RequestMapping("signUp")
	public String signUp(HttpServletRequest req, @ModelAttribute MemberDTO dto) {
		int res = memberMapper.inputMember(dto);
		if(res>0) {
			req.setAttribute("msg", "회원가입성공 로그인을 해주세요");
			req.setAttribute("url", "index");
		}else {
			req.setAttribute("msg", "회원가입실패");
			req.setAttribute("url", "index");
		}
		return "message";
	}
	
	// 로그인
	@RequestMapping("/login")
	public String login(HttpServletRequest req, @RequestParam Map<String, String> params, 
			HttpServletResponse resp, final HttpSession session ) {
		
		MemberDTO dto = memberMapper.getMember(params.get("member_id"));
		
		if(dto == null) {
			req.setAttribute("msg", "아이디가 존재하지않습니다");
			req.setAttribute("url", "index");
			return "message";
		}else if(!dto.getPasswd().equals(params.get("passwd"))) {
			System.out.println(dto.getPasswd());
			req.setAttribute("msg", "비밀번호가 틀렸습니다");
			req.setAttribute("url", "index");
			return "message";
		}else {
			//로그인 빈에 로그인한 멤버의 정보 담고 세션에 저장
			//LoginOKBean loginOk = new LoginOKBean();
			//loginOk.login_setting(dto);
			session.setAttribute("member_id", dto.getMember_id());
			session.setAttribute("member_name", dto.getMember_name());
			session.setAttribute("member_mode", dto.getMember_mode());
			session.setAttribute("member_image", dto.getMember_image());
			
			//아이디저장하기 버튼 클릭시 아이디 쿠키에 저장
			Cookie ck = new Cookie("saveId", dto.getMember_id());
			if(params.get("saveId")==null){
				ck.setMaxAge(0);
			}else{
				ck.setMaxAge(24*60*60);
			}
			resp.addCookie(ck);
			
			return "redirect:/index";
		}
	}
	
	@RequestMapping("logout")
	public String logout(HttpServletRequest req) {
		HttpSession session = req.getSession();
		session.invalidate();
		
		return "redirect:/index";
	}
	
	// 위시리스트
	@RequestMapping("wishlist")
	public String wishlist(HttpServletRequest req) {
		String member_id=(String) req.getSession().getAttribute("member_id");
		List<WishListDTO> list = wishListMapper.getWish(member_id);
		if(list==null) {
			List<WishListDTO> adminList = wishListMapper.getAdminWish();
			req.setAttribute("admin_wishlist", adminList);
		}
		
		req.setAttribute("user_wishlist", list);
		return "user/wish/wishList";
	}
	
	@RequestMapping("makeWish")
	public String makeWish(HttpServletRequest req, @ModelAttribute WishListDTO dto) {
		int res = wishListMapper.makeWish(dto);
		
		return "redirect:/wishlist";
	}
}
