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
import com.airtnt.airtnt.model.BookingDTO;
import com.airtnt.airtnt.model.MemberDTO;
import com.airtnt.airtnt.model.PropertyDTO;
import com.airtnt.airtnt.model.WishListDTO;
import com.airtnt.airtnt.model.WishList_PropertyDTO;
import com.airtnt.airtnt.service.BookingMapper;
import com.airtnt.airtnt.service.MemberMapper;
import com.airtnt.airtnt.service.WishListMapper;

@Controller
public class UserController {
	
	@Autowired
	MemberMapper memberMapper;
	@Autowired
	WishListMapper wishListMapper;
	@Autowired
	BookingMapper bookingMapper;
	
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
	@RequestMapping("login")
	public String login(HttpServletRequest req, @RequestParam Map<String, String> params, 
			HttpServletResponse resp, final HttpSession session ) {
		
		MemberDTO dto = memberMapper.getMember(params.get("id"));
		
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
			LoginOKBean login = LoginOKBean.getInstance();
			login.login_setting(dto);
			session.setAttribute("member_id", dto.getId());
			session.setAttribute("member_name", dto.getName());
			session.setAttribute("member_mode", dto.getMember_mode());
			session.setAttribute("member_image", dto.getMember_image());
			//아이디저장하기 버튼 클릭시 아이디 쿠키에 저장
			Cookie ck = new Cookie("saveId", dto.getId());
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
	//마이페이지
	@RequestMapping("myPage")
	public String mypage(HttpServletRequest req) {
		LoginOKBean memberData = LoginOKBean.getInstance();
		System.out.println(memberData.getName());
		req.setAttribute("memberData", memberData);
		
		return "user/user/myPage";
	}
	
	// 위시리스트
	@RequestMapping("wishList")
	public String wishList(HttpServletRequest req) {
		String member_id=(String) req.getSession().getAttribute("member_id");
		List<WishList_PropertyDTO> list = wishListMapper.getWish(member_id);
		if(list==null||list.size()==0) {
			List<WishList_PropertyDTO> adminList = wishListMapper.getAdminWish();
			req.setAttribute("admin_wishList", adminList);
		}else {
			req.setAttribute("user_wishList", list);
		}
		
		return "user/wish/wishList";
	}
	
	@RequestMapping("makeWish")
	public String makeWish(HttpServletRequest req, @ModelAttribute WishListDTO dto) {
		dto.setMember_id((String) req.getSession().getAttribute("member_id"));
		int res = wishListMapper.makeWish(dto);
		
		
		return "redirect:/wishList";
	}
	
	@RequestMapping("inWishList")
	public String inWishList(HttpServletRequest req, @RequestParam Map<String, String> params) {
		List<WishList_PropertyDTO> list = wishListMapper.getWishRoom(params.get("wish_id"));
		req.setAttribute("wish_name", params.get("wish_name"));
		req.setAttribute("wish_id", params.get("wish_id"));
		
		req.setAttribute("properties", list);
		return "user/wish/inWishList";
	}
	
	@RequestMapping("updateWish")
	public String updateWish(HttpServletRequest req, @RequestParam Map<String, String> params) {
		int res = wishListMapper.updateWish(params);
		
		return "redirect:/wishList";
	}
	
	@RequestMapping("deleteWish")
	public String deleteWish(HttpServletRequest req, @RequestParam Map<String, String> params) {
		int res1 = wishListMapper.deleteWishRoom(params.get("wish_id"));
		int res2 = wishListMapper.deleteWish(params.get("wish_id"));
		
		return "redirect:/wishList";
	}
	
	//여행
	@RequestMapping("tour")
	public String tour(HttpServletRequest req) {
		String member_id=(String) req.getSession().getAttribute("member_id");
		List<BookingDTO> planed = bookingMapper.getPlanedBooking(member_id);
		List<BookingDTO> pre = bookingMapper.getPreBooking(member_id);
		
		req.setAttribute("planedBookinglist", planed);
		req.setAttribute("preBookinglist", pre);
		return "user/tour/tour";
	}
}
