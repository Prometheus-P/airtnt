package com.airtnt.airtnt.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.airtnt.airtnt.guest.LoginOKBean;
import com.airtnt.airtnt.model.AmenityTypeDTO;
import com.airtnt.airtnt.model.BookingDTO;
import com.airtnt.airtnt.model.DashBoardDTO;
import com.airtnt.airtnt.model.GuideContextDTO;
import com.airtnt.airtnt.model.GuideDTO;
import com.airtnt.airtnt.model.MemberDTO;
import com.airtnt.airtnt.model.PropertyTypeDTO;
import com.airtnt.airtnt.model.RoomTypeDTO;
import com.airtnt.airtnt.model.SubPropertyTypeDTO;
import com.airtnt.airtnt.model.TransactionDTO;
import com.airtnt.airtnt.service.AdminMapper;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Controller
@RequestMapping("admin")
public class AdminController extends UserController {

	@Autowired
	AdminMapper adminMapper;
	
	//reports 화면 내 초기 날짜 파라미터로 사용(오늘 날짜)
	Date dateToday = new Date(System.currentTimeMillis());
	SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
	String strToday = transFormat.format(dateToday);

	
	/*
	 * [main] : admin 계정 로그인 화면
	 */
	@RequestMapping(value = "", method = {RequestMethod.GET, RequestMethod.POST})
	public String goMainView() {
		return "admin/main";
	}
	
	/*
	 * [main] : login
	 */
	@RequestMapping(value = "loginCheck", method = RequestMethod.POST)
	public String loginCheck(HttpServletRequest req, @RequestParam Map<String, String> params, 
			HttpServletResponse resp, final HttpSession session) {
		MemberDTO dto = memberMapper.getMember(params.get("id"));
		
		if(dto == null) {
			req.setAttribute("msg", "아이디가 존재하지 않습니다");
			req.setAttribute("url", "../admin");
			return "message";
		}else if(!dto.getPasswd().equals(params.get("passwd"))) {
			req.setAttribute("msg", "비밀번호가 틀렸습니다");
			req.setAttribute("url", "../admin");
			return "message";
		}else if(dto.getMember_mode().equals("1") || dto.getMember_mode().equals("2")){
			req.setAttribute("msg", "관리자만 로그인 가능");
			req.setAttribute("url", "../admin");
			return "message";
		}else {
			//로그인 빈에 로그인한 멤버의 정보 담고 세션에 저장
			LoginOKBean login = LoginOKBean.getInstance();
			login.init_setting(dto);
			session.setAttribute("member_id", dto.getId());
			session.setAttribute("member_name", dto.getName());
			session.setAttribute("member_ip", req.getRemoteAddr());
			
			//아이디저장하기 버튼 클릭시 아이디 쿠키에 저장
			Cookie ck = new Cookie("saveId", dto.getId());
			if(params.get("saveId")==null){
				ck.setMaxAge(0);
			}else{
				ck.setMaxAge(24*60*60);
			}
			resp.addCookie(ck);
			return "redirect:dashboard"; //로그인 성공시 admin dashboard 페이지로 보낸다
		}
	}
	
	/*
	 * [공통] : logout
	 */
	//@RequestMapping("logout")
	//public String logout(HttpServletRequest req) {
	//	HttpSession session = req.getSession();
	//	session.invalidate();
	//	return "redirect:/admin";
	//}

	/*
	 * [dashboard] : 대시보드 필요 데이터 조회 및 넘긴다
	 */
	@RequestMapping(value = "dashboard", method = RequestMethod.GET)
	public String listDashboard(HttpServletRequest req) throws Exception {
		//월별 체크인 카운트
		List<DashBoardDTO> list = adminMapper.listCheckInDateCntGroupByMonth();
		ArrayList<String> key = new ArrayList<>();
		ArrayList<Integer> this_value = new ArrayList<>();
		ArrayList<Integer> last_value = new ArrayList<>();
		for (int i = 0; i < list.size(); i++) {
			key.add(list.get(i).getCheckInMonth());
			this_value.add(list.get(i).getThisYearCheckInMonthCnt());
			last_value.add(list.get(i).getLastYearCheckInMonthCnt());
		}
		req.setAttribute("keylist", key); // 라벨날짜
		req.setAttribute("this_valuelist", this_value); // 올해
		req.setAttribute("last_valuelist", last_value); // 작년
		return "admin/dashboard";
	}
	
	/*
	 * [member] : 회원정보 조회
	 * param : "mode" > 회원구분  ( default "all" 로 세팅 > 처음 전체조회시 )
	 */
	@RequestMapping(value = "member", method = RequestMethod.GET)
	public String selectMemberList(HttpServletRequest req, @RequestParam(defaultValue="0") String member_mode) throws Exception {
		//페이징 처리
		int pageSize = 5;
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum.trim().equals("")){
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage-1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		int rowCount = adminMapper.selectMemberCount(member_mode);
		int number = rowCount - startRow + 1;
		if (endRow > rowCount) endRow = rowCount;
		List<MemberDTO> list = adminMapper.selectMemberList(member_mode, startRow, endRow);
		
		int pageCount = rowCount / pageSize + (rowCount%pageSize == 0 ? 0 : 1);
		int pageBlock = 3;
		int startPage = ((currentPage-1)/pageBlock) * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) endPage = pageCount;
		
		req.setAttribute("memberList", list);
		req.setAttribute("member_mode", member_mode);
		req.setAttribute("number", number);
		req.setAttribute("rowCount", rowCount);
		req.setAttribute("pageBlock", pageBlock);
		req.setAttribute("startPage", startPage);
		req.setAttribute("endPage", endPage);
		req.setAttribute("pageCount", pageCount);
		return "admin/member";
	}
	
	/*
	 * [reports] : 최초 페이지 로딩시 오늘날짜로 세팅해서 리포트 데이터 조회해온다
	 */
	@RequestMapping(value="reports", method = RequestMethod.GET)
	public String selectReportsData(HttpServletRequest req) {
		String startDate = strToday;
		String endDate = strToday;
		List<BookingDTO> bookingList = adminMapper.selectBookingList(startDate, endDate);
		List<TransactionDTO> transactionList = adminMapper.selectTransactionList(startDate, endDate);
		req.setAttribute("bookingList", bookingList);
		req.setAttribute("transactionList", transactionList);
		req.setAttribute("today", strToday);
		return "admin/reports";
	}
	
	/*
	 * [reports] : 날짜 조회조건 변경해서 요청한 리포트 데이터만 조회해온다
	 */
	@RequestMapping(value = "reports/search", method = RequestMethod.POST)
	@ResponseBody
	public List<?> selectSelectedReportData(HttpServletRequest req, 
									@RequestParam String startDate, 
									@RequestParam String endDate,
									@RequestParam String mode
									)  throws Exception {
		if(mode.equals("booking")) {
			List<BookingDTO> list = adminMapper.selectBookingList(startDate, endDate);
			return list;
		}else {
			List<TransactionDTO> list = adminMapper.selectTransactionList(startDate, endDate);
			return list;
		}
	}
	
	/*
	 * [filter] : 필터 화면 첫 조회시 전체 데이터 불러온다
	
	 */
	@RequestMapping(value = "filter", method = RequestMethod.GET)
	public String selectFilterTables(HttpServletRequest req) throws Exception {
		List<RoomTypeDTO> roomTypeList = adminMapper.selectRoomTypeList();
		List<PropertyTypeDTO> propertyTypeList = adminMapper.selectPropertyTypeList();
		List<SubPropertyTypeDTO> subPropertyTypeList = adminMapper.selectSubPropertyTypeList();
		List<AmenityTypeDTO> amenityTypeList = adminMapper.selectAmenityTypeList();
		req.setAttribute("roomTypeList", roomTypeList);
		req.setAttribute("propertyTypeList", propertyTypeList);
		req.setAttribute("subPropertyTypeList", subPropertyTypeList);
		req.setAttribute("amenityTypeList", amenityTypeList);

		return "admin/filter";
	}
	
	/*
	 * [filter] : property type > 대분류 선택시 해당하는 sub 데이터 리스트 불러온다
	 */
	@RequestMapping(value = "filter", method = RequestMethod.POST)
	@ResponseBody
	public List<SubPropertyTypeDTO> getSubProperty(HttpServletRequest req, @RequestParam String propertyTypeId) throws Exception {
		List<SubPropertyTypeDTO> selectedSubProperty = adminMapper.getSubPropertyType(propertyTypeId); 
		return selectedSubProperty; 
	}
	
	/*
	 * [filter] : 공통 > 대분류 데이터 추가 및 변경
	 */
	@RequestMapping(value="filter/update/master", method = RequestMethod.POST)
	@ResponseBody
	public int updateFilterMasterList(HttpServletRequest req, @RequestParam String type, @RequestParam String data) {
		int res = 0;
		List<Map<String, String>> datalist 
			= new Gson().fromJson(String.valueOf(data), new TypeToken<List<Map<String, String>>>(){}.getType());
		System.out.println(data); 
		
		if(type.equals("ROOM")) {
			for (Map<String, String> obj : datalist) {
				if(obj.get("id").equals("") || obj.get("id") == null) { //신규건
					RoomTypeDTO dto = new RoomTypeDTO(obj.get("name"), obj.get("isUse"));
					res += adminMapper.updateRoomTypeDTO("I", dto); //insert
				}else {													 //변경건
					RoomTypeDTO dto = new RoomTypeDTO(obj.get("id"), obj.get("name"), obj.get("isUse"));
					res += adminMapper.updateRoomTypeDTO("U", dto); //update
				}
			}
		}else if(type.equals("AMENITY")) {
			for (Map<String, String> obj : datalist) {
				if(obj.get("id").equals("") || obj.get("id") == null) {
					AmenityTypeDTO dto = new AmenityTypeDTO(obj.get("name"), obj.get("isUse"));
					res += adminMapper.updateAmenityTypeDTO("I", dto);
				}else {
					AmenityTypeDTO dto = new AmenityTypeDTO(obj.get("id"), obj.get("name"), obj.get("isUse"));
					res += adminMapper.updateAmenityTypeDTO("U", dto);
				}
			}
		}else if(type.equals("PROPERTY")) {
			for (Map<String, String> obj : datalist) {
				if(obj.get("id").equals("") || obj.get("id") == null) {
					PropertyTypeDTO dto = new PropertyTypeDTO(obj.get("name"), obj.get("isUse"));
					res += adminMapper.updatePropertyTypeDTO("I", dto);
				}else {
					PropertyTypeDTO dto = new PropertyTypeDTO(obj.get("id"), obj.get("name"), obj.get("isUse"));
					res += adminMapper.updatePropertyTypeDTO("U", dto);
				}
			}
		}else {
			return 0;
		}
		return res;	
	}
	
	/*
	 * [filter] : sub 분류 데이터 추가 및 변경
	 */
	@RequestMapping(value="filter/update/sub", method = RequestMethod.POST)
	@ResponseBody
	public int updateFilterSubList(HttpServletRequest req, @RequestParam String type, @RequestParam String data) {
		int res = 0;
		List<Map<String, String>> datalist 
			= new Gson().fromJson(String.valueOf(data), new TypeToken<List<Map<String, String>>>(){}.getType());
		System.out.println(data); 
		
		for (Map<String, String> obj : datalist) {
			if(obj.get("id").equals("") || obj.get("id") == null) { //신규건
				SubPropertyTypeDTO dto = new SubPropertyTypeDTO(obj.get("name"), obj.get("isUse"), obj.get("propertyTypeId"));
				res += adminMapper.updateSubPropertyTypeDTO("I", dto); //insert
			}else {													 //변경건
				SubPropertyTypeDTO dto = new SubPropertyTypeDTO(obj.get("id"), obj.get("name"), obj.get("isUse"), obj.get("propertyTypeId"));
				res += adminMapper.updateSubPropertyTypeDTO("U", dto); //update
			}
		}
		return res;	
	}

	/*
	 * [Guide] : 글작성 페이지 이동
	 */
	@RequestMapping(value = "guideWrite", method = RequestMethod.GET)
	public String goWriteForm(HttpServletRequest req) throws Exception {
		return "admin/guide_write";
	}
	
	/*
	 * [Guide] : 글작성
	 */
	@RequestMapping(value = "guideWrite", method = RequestMethod.POST)
	public String insertBoard(GuideDTO guideDto,
							@RequestParam(value = "contextArr", required = false) String[] contextArr) throws Exception {
		
		//마스터 테이블 pk id 조회
		int id = adminMapper.selectIdSeq();
		
		//마스터 테이블 id 세팅
		guideDto.setId(id);
		System.out.println("DTO ID : " + guideDto.getId());
		int res1 = adminMapper.insertBoard(guideDto);
		
		//sub 테이블 세팅
		//ArrayList<GuideContextDTO> subArr = new ArrayList<>();
		
		if(res1 > 0) {
			for(int i=0; i<contextArr.length; i++) {
				GuideContextDTO context = new GuideContextDTO();
				context.setId(id);
				context.setContext(contextArr[i]);
				int res2 = adminMapper.insertBoardContext(context);
			}
		}
		return "redirect:guidelist";
	}
	
	@RequestMapping(value = "guidelist", method = RequestMethod.GET)
	public String selectBoardList(HttpServletRequest req) throws Exception {
		//페이징 처리
		int pageSize = 5;
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum.trim().equals("")){
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage-1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		int rowCount = adminMapper.selectBoardCount();
		int number = rowCount - startRow + 1;
		if (endRow > rowCount) endRow = rowCount;
		List<GuideDTO> list = adminMapper.selectBoardList(startRow, endRow);
		
		int pageCount = rowCount / pageSize + (rowCount%pageSize == 0 ? 0 : 1);
		int pageBlock = 3;
		int startPage = ((currentPage-1)/pageBlock) * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) endPage = pageCount;
		
		req.setAttribute("boardList", list);
		req.setAttribute("number", number);
		req.setAttribute("rowCount", rowCount);
		req.setAttribute("pageBlock", pageBlock);
		req.setAttribute("startPage", startPage);
		req.setAttribute("endPage", endPage);
		req.setAttribute("pageCount", pageCount);
		
		return "admin/guide_list";
	}
	
	@RequestMapping(value = "guideDelete", method = RequestMethod.GET)
	public String deleteBoardList(HttpServletRequest req, @RequestParam String id) throws Exception {
		int res = adminMapper.deleteBoard(id); //마스터랑 sub 모두 삭제
		return "redirect:guidelist";
	}
	
	@RequestMapping(value = "guideView", method = RequestMethod.GET)
	public String getSelectedBoard(HttpServletRequest req, @RequestParam String id) throws Exception {
		List<GuideDTO> list = adminMapper.getSelectedBoard(id);
		req.setAttribute("boardList", list);
		return "admin/guide_view";
	}
	
	@RequestMapping(value = "guideUpdate", method = RequestMethod.POST)
	public String updateSelectedBoard(GuideContextDTO dto) throws Exception {
		int res1 = adminMapper.updateSelectedBoard(dto); //master
		int res2 = adminMapper.updateSelectedContext(dto); //sub
		return "redirect:guidelist";
	}

}
