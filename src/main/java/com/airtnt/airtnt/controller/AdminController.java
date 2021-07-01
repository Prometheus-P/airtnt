package com.airtnt.airtnt.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.airtnt.airtnt.model.AmenityTypeDTO;
import com.airtnt.airtnt.model.DashBoardDTO;
import com.airtnt.airtnt.model.MemberDTO;
import com.airtnt.airtnt.model.PropertyTypeDTO;
import com.airtnt.airtnt.model.RoomTypeDTO;
import com.airtnt.airtnt.model.SubPropertyTypeDTO;
import com.airtnt.airtnt.model.GuideDTO;
import com.airtnt.airtnt.service.AdminMapper;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Controller
@RequestMapping("admin")
public class AdminController {

	@Autowired
	AdminMapper adminMapper;
	
	/*
	 * [main] : admin 계정 로그인 화면
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String goMainView() {
		return "admin/main";
	}
	
	/*
	 * [main] : login 체크  
	 */
	

	/*
	 * [dashboard] : 대시보드 필요 데이터 조회 및 넘긴다
	 */
	@RequestMapping(value = "dashboard", method = RequestMethod.GET)
	public String listDashboard(HttpServletRequest req) throws Exception {
		List<DashBoardDTO> list = adminMapper.listDashboard();
		ArrayList<String> key = new ArrayList<>();
		ArrayList<Integer> this_value = new ArrayList<>();
		ArrayList<Integer> last_value = new ArrayList<>();
		for (int i = 0; i < list.size(); i++) {
			key.add(list.get(i).getTransactionDate());
			this_value.add(list.get(i).getThisTotSiteFee());
			last_value.add(list.get(i).getLastTotSiteFee());
		}
		req.setAttribute("keylist", key); // 라벨날짜
		req.setAttribute("this_valuelist", this_value); // 올해
		req.setAttribute("last_valuelist", last_value); // 작년
		return "admin/dashboard";
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
	 * [member] : 회원정보 조회
	 * param : "mode" > 회원구분  ( default "all" 로 세팅 > 전체조회 )
	 * 
	 */
	@RequestMapping(value = "member", method = RequestMethod.GET)
	public String selectMemberList(HttpServletRequest req, @RequestParam(defaultValue="all") String member_mode) throws Exception {
		System.out.println("mode::" + member_mode);
		List<MemberDTO> list = adminMapper.selectMemberList(member_mode);
		req.setAttribute("memberList", list);
		return "admin/member";
	}
	
	/*
	 * [Guide]
	 */
	@RequestMapping(value = "guideWrite", method = RequestMethod.GET)
	public String goWriteForm(HttpServletRequest req) throws Exception {
		return "admin/guide_write";
	}
	
	@RequestMapping(value = "guideWrite", method = RequestMethod.POST)
	public String insertBoard(GuideDTO dto) throws Exception {
		int res = adminMapper.insertBoard(dto);
		return "redirect:guidelist";
	}
	
	@RequestMapping(value = "guidelist", method = RequestMethod.GET)
	public String selectBoardList(HttpServletRequest req) throws Exception {
		List<GuideDTO> list = adminMapper.selectBoardList();
		req.setAttribute("boardList", list);
		return "admin/guide_list";
	}
	
	@RequestMapping(value = "guideDelete", method = RequestMethod.GET)
	public String deleteBoardList(HttpServletRequest req, @RequestParam String contentId) throws Exception {
		int res = adminMapper.deleteBoard(contentId);
		return "redirect:guidelist";
	}
	
	@RequestMapping(value = "guideView", method = RequestMethod.GET)
	public String getSelectedBoard(HttpServletRequest req, @RequestParam String contentId) throws Exception {
		List<GuideDTO> list = adminMapper.getSelectedBoard(contentId);
		req.setAttribute("boardList", list);
		return "admin/guide_view";
	}
	
	@RequestMapping(value = "guideUpdate", method = RequestMethod.POST)
	public String updateSelectedBoard(GuideDTO dto) throws Exception {
		int res = adminMapper.updateSelectedBoard(dto);
		return "redirect:guidelist";
	}
	
	
	
	/*
	 * 
	 * /* [filter] : ȭ�� ���� ��ȸ�� ī�װ������� ��ȸ
	 * 
	 * @RequestMapping(value="filter2", method = RequestMethod.GET) public String
	 * listfilterMaster(HttpServletRequest req) throws Exception {
	 * List<FilterPropDTO> propertyList = adminMapper.listProperty();
	 * List<FilterSubPropDTO> subPropertyList = adminMapper.listSubProperty();
	 * req.setAttribute("propertyList", propertyList);
	 * req.setAttribute("subPropertyList", subPropertyList); return "admin/filter";
	 * }
	 * 
	 * 
	 * [filter] : ������ ��з��� �ߺз� ���̺� ����
	 * 
	 * @RequestMapping(value = "filter2", method = RequestMethod.POST)
	 * 
	 * @ResponseBody public List<FilterSubPropDTO> getSubProperty(HttpServletRequest
	 * req, @RequestParam String propertyTypeId) throws Exception {
	 * List<FilterSubPropDTO> selectedSubProperty =
	 * adminMapper.getSubProperty(propertyTypeId); return selectedSubProperty; }
	 * 
	 * 
	 * [filter] : ��з� �߰�/���� ��Ʈ�ѷ������� �Ѿ�� �����͸� String ������ �޾Ƽ�
	 * Object�� JSONArray ���·� ��ȯ�Ͽ� ó���մϴ�. �̶� ����� Json ���̺귯���� Gson
	 * ���̺귯���� �̿��� ����� ����ϸ� �˴ϴ�. Gson�� JSON������ ����ȭ�� �����͸� JAVA��
	 * ��ü�� ������ȭ, ����ȭ ���ִ� �ڹ� ���̺귯�� �Դϴ�. JSON Object -> Java Object �Ǵ�
	 * �� �ݴ��� ������ ���� ���̺귯�� �Դϴ�.
	 * 
	 * @RequestMapping(value="filter2/update/prop", method = RequestMethod.POST)
	 * 
	 * @ResponseBody public int updatePropertyList(HttpServletRequest
	 * req, @RequestParam String data) throws Exception { int res = 0; try {
	 * List<Map<String, String>> datalist = new
	 * Gson().fromJson(String.valueOf(data), new TypeToken<List<Map<String,
	 * String>>>(){}.getType());
	 * 
	 * System.out.println(data); //
	 * [{"id":"2","name":"CATE02","isUse":"Y"},{"id":"4","name":"tttttttt","isUse":
	 * "Y"}]
	 * 
	 * //json���� �޾ƿ� �����͵� �ű��߰� / ���� �ϳ��� ���� for (Map<String, String>
	 * prop : datalist) { if(prop.get("id").equals("") || prop.get("id") == null) {
	 * //�űԵ�ϰǰ� ������ ���� FilterPropDTO dto = new FilterPropDTO(prop.get("name"),
	 * prop.get("isUse")); res += adminMapper.insertProperty(dto); }else {
	 * FilterPropDTO dto = new FilterPropDTO(prop.get("id"), prop.get("name"),
	 * prop.get("isUse")); res += adminMapper.updateProperty(dto); } } } catch
	 * (Exception e) { e.printStackTrace(); } return res; }
	 * 
	 * 
	 * [filter] : �ߺз� �߰�/����
	 * 
	 * @RequestMapping(value="filter2/update/subprop", method = RequestMethod.POST)
	 * 
	 * @ResponseBody public int updateSubPropertyList(HttpServletRequest
	 * req, @RequestParam String data) throws Exception { int res = 0;
	 * FilterSubPropDTO dto; System.out.println(data); try { List<Map<String,
	 * String>> datalist = new Gson().fromJson(String.valueOf(data), new
	 * TypeToken<List<Map<String, String>>>(){}.getType());
	 * 
	 * for (Map<String, String> sub : datalist) { if(sub.get("id").equals("") ||
	 * sub.get("id") == null) { dto = new
	 * FilterSubPropDTO(sub.get("propertyTypeId"), sub.get("name"),
	 * sub.get("isUse")); res += adminMapper.insertSubProperty(dto); }else { dto =
	 * new FilterSubPropDTO(sub.get("id"), sub.get("name"), sub.get("isUse")); res
	 * += adminMapper.updateSubProperty(dto); } } } catch (Exception e) {
	 * e.printStackTrace(); } return res; }
	 */

}
