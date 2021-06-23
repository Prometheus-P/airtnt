package com.airtnt.airtnt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.airtnt.airtnt.model.DashBoardDTO;
import com.airtnt.airtnt.model.FilterPropDTO;
import com.airtnt.airtnt.model.FilterSubPropDTO;
import com.airtnt.airtnt.service.AdminMapper;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Controller
public class AdminController {
	
	@Autowired
	AdminMapper adminMapper;

	/*
	 * dashboard : chart�� ���Ǵ� �Ϻ� ������ sum ������
	 */
	@RequestMapping(value="admin", method=RequestMethod.GET)
	public String listDashboard(HttpServletRequest req) throws Exception {
		List<DashBoardDTO> list = adminMapper.listDashboard();
		ArrayList<String> key = new ArrayList<>();
		ArrayList<Integer> this_value = new ArrayList<>();
		ArrayList<Integer> last_value = new ArrayList<>();
		for(int i=0; i<list.size(); i++) {
			key.add(list.get(i).getTransactionDate());
			this_value.add(list.get(i).getThisTotSiteFee());
			last_value.add(list.get(i).getLastTotSiteFee());
		}
		req.setAttribute("keylist", key);				//��
		req.setAttribute("this_valuelist", this_value);	//���ؼ�����SUM
		req.setAttribute("last_valuelist", last_value); //�۳������SUM
		return "admin/dashboard";
	}
	
	/*
	 * admin nav
	 */
	@RequestMapping(value="admin_nav", method=RequestMethod.GET)
	public String test(HttpServletRequest req) throws Exception {
		return "admin/admin_nav";
	}
	
	/*
	 * filter : ȭ�� ���� ��ȸ�� ī�װ������� ��ȸ
	 */
	@RequestMapping(value="filter", method = RequestMethod.GET)
	public String listfilterMaster(HttpServletRequest req) throws Exception {
		List<FilterPropDTO> propertyList = adminMapper.listProperty();
		List<FilterSubPropDTO> subPropertyList = adminMapper.listSubProperty();
		req.setAttribute("propertyList", propertyList);
		req.setAttribute("subPropertyList", subPropertyList);
		return "admin/filter";
	}
	
	/*
	 * filter : ��з� ���ý� �ش��ϴ� �ߺз� ������ view �� ������
	 */
	@RequestMapping(value = "filter", method = RequestMethod.POST)
	@ResponseBody
	public List<FilterSubPropDTO> getSubProperty(HttpServletRequest req, @RequestParam String propertyTypeId) 
			throws Exception {
		List<FilterSubPropDTO> selectedSubProperty = adminMapper.getSubProperty(propertyTypeId);
		return selectedSubProperty;  
	}
	
	/*
	 * ��Ʈ�ѷ������� �Ѿ�� �����͸� String ������ �޾Ƽ� Object�� JSONArray ���·� ��ȯ�Ͽ� ó���մϴ�.
		�̶� ����� Json ���̺귯���� Gson ���̺귯���� �̿��� ����� ����ϸ� �˴ϴ�.
		Gson�� JSON������ ����ȭ�� �����͸� JAVA�� ��ü�� ������ȭ, ����ȭ ���ִ� �ڹ� ���̺귯�� �Դϴ�.
		JSON Object -> Java Object �Ǵ� �� �ݴ��� ������ ���� ���̺귯�� �Դϴ�.
	 */
	@RequestMapping(value="filter/update_prop", method = RequestMethod.POST)
	@ResponseBody
	public int updatePropertyList(HttpServletRequest req, @RequestParam String data) 
			throws Exception {
		Map<String, Object> result = new HashMap<>();
		int res = 0;
		try {
			List<Map<String, Object>> datalist = new Gson().fromJson(String.valueOf(data), new TypeToken<List<Map<String, Object>>>(){}.getType());
			//json���� �޾ƿ� �����͵� �ű��߰� / ���� �ϳ��� ����
			for (Map<String, Object> prop : datalist) {
				String key = (String) prop.get("id");
				if(key.contains("new")) {	//�ű����� �ƴ��� ����
					res += adminMapper.insertProperty(prop);
				}else {
					res += adminMapper.updateProperty(prop);
				}
			}  
		} catch (Exception e) {
		  e.printStackTrace();
		}
	return res;
	
}
	
	
	
	
	
}
