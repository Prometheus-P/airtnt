package com.airtnt.airtnt.controller;

import java.io.File;
import java.io.IOException;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

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
	public String signUp(HttpServletRequest req, @ModelAttribute MemberDTO dto,
			@RequestParam(value = "preURI", required = false) String preURI) {
		String nextURI = preURI;
		if (preURI == null || preURI.trim().equals("")) {
			nextURI = "index";
		}

		int res = memberMapper.inputMember(dto);
		if (res > 0) {
			req.setAttribute("msg", "회원가입성공 로그인을 해주세요");
			req.setAttribute("url", nextURI);
		} else {
			req.setAttribute("msg", "회원가입실패");
			req.setAttribute("url", nextURI);
		}
		return "message";
	}

	// 로그인
	@RequestMapping("login")
	public String login(HttpServletRequest req, @RequestParam Map<String, String> params,
			@RequestParam(value = "preURI", required = false) String preURI, HttpServletResponse resp,
			final HttpSession session) {
		String nextURI = preURI;
		if (preURI == null || preURI.trim().equals("")) {
			nextURI = "index";
		}

		MemberDTO dto = memberMapper.getMember(params.get("id"));

		if (dto == null) {
			req.setAttribute("msg", "아이디가 존재하지않습니다");
			req.setAttribute("url", nextURI);
			return "message";
		} else if (!dto.getPasswd().equals(params.get("passwd"))) {
			req.setAttribute("msg", "비밀번호가 틀렸습니다");
			req.setAttribute("url", nextURI);
			return "message";
		} else {
			// 로그인 빈에 로그인한 멤버의 정보 담고 세션에 저장
			LoginOKBean login = LoginOKBean.getInstance();
			login.init_setting(dto);
			session.setAttribute("member_id", dto.getId());
			session.setAttribute("member_name", dto.getName());
			session.setAttribute("member_mode", dto.getMember_mode());
			session.setAttribute("member_image", dto.getMember_image());
			// 아이디저장하기 버튼 클릭시 아이디 쿠키에 저장
			Cookie ck = new Cookie("saveId", dto.getId());
			if (params.get("saveId") == null) {
				ck.setMaxAge(0);
			} else {
				ck.setMaxAge(24 * 60 * 60);
			}
			resp.addCookie(ck);

			return "redirect:" + nextURI;
		}
	}

	@RequestMapping("logout")
	public String logout(HttpServletRequest req, @RequestParam(value = "preURI", required = false) String preURI) {
		String nextURI = preURI;
		if (preURI == null || preURI.trim().equals("")) {
			nextURI = "index";
		}

		HttpSession session = req.getSession();
		session.invalidate();

		return "redirect:" + nextURI;
	}

	// [마이페이지]
	@RequestMapping("myPage")
	public String mypage(HttpServletRequest req) {
		LoginOKBean memberData = LoginOKBean.getInstance();
		req.setAttribute("memberData", memberData);

		return "user/user/myPage";
	}

	@RequestMapping("myPage/profile")
	public String profile(HttpServletRequest req) {
		LoginOKBean memberData = LoginOKBean.getInstance();
		req.setAttribute("memberData", memberData);
		return "user/user/profile";
	}
	
	@RequestMapping("myPage/updateMember")
	public String updateMember(HttpServletRequest req, @ModelAttribute MemberDTO dto) {
		String member_id = (String) req.getSession().getAttribute("member_id");
		dto.setId(member_id);
		int res = memberMapper.updateMember(dto);

		MemberDTO getMember = memberMapper.getMember(member_id);
		LoginOKBean login = LoginOKBean.getInstance();
		login.init_setting(getMember);
		return "redirect:/myPage/profile";
	}

	@RequestMapping("myPage/editPhoto")
	public String editPhoto(HttpServletRequest req) {
		LoginOKBean memberData = LoginOKBean.getInstance();
		req.setAttribute("memberData", memberData);
		return "user/user/editPhoto";
	}
	
	//[마이페이지 - 멤버이미지 등록]
	@RequestMapping(value = ("myPage/updateMemberImage"), method = RequestMethod.POST)
	public String updateMemberImage(HttpServletRequest req, 
			@RequestParam("filename") MultipartFile mtf,
			@RequestParam("member_image") String member_image) throws Exception {

		// 파일 경로 설정
		String originalFile = mtf.getOriginalFilename();
		String originalFileExtension = originalFile.substring(originalFile.lastIndexOf("."));
		String storedFileName = UUID.randomUUID().toString().replaceAll("-", "") + originalFileExtension;
		String upPath = "D:\\Ezen Learning\\Bigdata Learning Spring\\airtnt\\src\\main\\webapp\\resources\\files\\member_image\\";

		// DB 넘길 데이터 설정
		Map<String, String> params = new Hashtable<>();
		String member_id = (String) req.getSession().getAttribute("member_id");
		String NewMember_image = "/resources/files/member_image/" + storedFileName;

		params.put("member_id", member_id);
		params.put("member_image", NewMember_image);


		// 기존 이미지파일이 있다면 서버 및 DB 삭제
		if(!member_image.isEmpty()) {
			String substring = "/resources/files/member_image/";
			File delfile = new File(upPath + member_image.substring(substring.length()));
			System.out.println(upPath + member_image.substring(substring.length()));
			if (delfile.exists()) {
				delfile.delete();
			}
			int res = memberMapper.deleteMemberImage(member_id);
		}
		
		// 파일 서버 저장 및 DB 저장
		File file = new File(upPath + storedFileName);
		mtf.transferTo(file);
		int res2 = memberMapper.updateMemberImage(params);
		
		//init 세팅
		MemberDTO getMember = memberMapper.getMember(member_id);
		LoginOKBean login = LoginOKBean.getInstance();
		login.init_setting(getMember);

		return "redirect:/myPage/editPhoto";
	}
	
	//[마이페이지 - 멤버이미지 삭제]
	@RequestMapping(value = ("myPage/updateMemberImage"), method = RequestMethod.GET)
	public String updateMemberImage(HttpServletRequest req, @RequestParam("del") String del,
			@RequestParam("member_image") String member_image) throws Exception {
		String member_id = (String) req.getSession().getAttribute("member_id");
		String upPath = "D:\\Ezen Learning\\Bigdata Learning Spring\\airtnt\\src\\main\\webapp\\resources\\files\\member_image\\";
		String substring = "/resources/files/member_image/";
		if (del.equals("del")) {
			File delfile = new File(upPath + member_image.substring(substring.length()));
			if (delfile.exists()) {
				delfile.delete();
			}
			int res = memberMapper.deleteMemberImage(member_id);
			MemberDTO getMember = memberMapper.getMember(member_id);
			LoginOKBean login = LoginOKBean.getInstance();
			login.init_setting(getMember);
		}
		return "redirect:/myPage/editPhoto";
	}

	@RequestMapping("myPage/review")
	public String review(HttpServletRequest req) {

		return "user/user/review";
	}

	@RequestMapping("myPage/payment")
	public String payment(HttpServletRequest req) {

		return "user/user/payment";
	}

	// 위시리스트
	@RequestMapping("wishList")
	public String wishList(HttpServletRequest req) {
		String member_id = (String) req.getSession().getAttribute("member_id");
		List<WishList_PropertyDTO> list = wishListMapper.getWish(member_id);
		if (list == null || list.size() == 0) {
			List<WishList_PropertyDTO> adminList = wishListMapper.getAdminWish();
			req.setAttribute("admin_wishList", adminList);
		} else {
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

	// 정석 작성
	@RequestMapping("wish/async")
	@ResponseBody
	public int wishPropertyAsync(HttpServletRequest req, @ModelAttribute WishList_PropertyDTO dto) {
		int result = wishListMapper.insertWishProperty(dto);
		return result;
	}

	@RequestMapping("unwish/async")
	@ResponseBody
	public int unwishPropertyAsync(HttpServletRequest req, @RequestParam Map<String, String> params) {
		int result = wishListMapper.deletePropertyAsync(params);
		return result;
	}

	// 여행
	@RequestMapping("tour")
	public String tour(HttpServletRequest req) {
		String member_id = (String) req.getSession().getAttribute("member_id");
		List<BookingDTO> planed = bookingMapper.getPlanedBooking(member_id);
		List<BookingDTO> pre = bookingMapper.getPreBooking(member_id);

		req.setAttribute("planedBookinglist", planed);
		req.setAttribute("preBookinglist", pre);
		return "user/tour/tour";
	}

}
