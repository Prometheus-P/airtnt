package com.airtnt.airtnt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.airtnt.airtnt.model.AmenityTypeDTO;
import com.airtnt.airtnt.model.DashBoardDTO;
import com.airtnt.airtnt.model.FilterPropDTO;
import com.airtnt.airtnt.model.FilterSubPropDTO;
import com.airtnt.airtnt.model.PropertyTypeDTO;
import com.airtnt.airtnt.model.RoomTypeDTO;
import com.airtnt.airtnt.model.SubPropertyTypeDTO;
import com.airtnt.airtnt.service.AdminMapper;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Controller
@RequestMapping("admin")
public class AdminController {

	@Autowired
	AdminMapper adminMapper;

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
	
	@RequestMapping(value = "filter", method = RequestMethod.POST)
	@ResponseBody public List<SubPropertyTypeDTO> getSubProperty(
			HttpServletRequest req, @RequestParam String propertyTypeId) throws Exception {
		List<SubPropertyTypeDTO> selectedSubProperty = adminMapper.getSubPropertyType(propertyTypeId); 
		return selectedSubProperty; 
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
