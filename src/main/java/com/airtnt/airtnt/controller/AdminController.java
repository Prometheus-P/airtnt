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
	 * dashboard : chart에 사용되는 일별 수수료 sum 데이터
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
		req.setAttribute("keylist", key);				//라벨
		req.setAttribute("this_valuelist", this_value);	//올해수수료SUM
		req.setAttribute("last_valuelist", last_value); //작년수수료SUM
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
	 * filter : 화면 최초 조회시 카테고리마스터 조회
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
	 * filter : 대분류 선택시 해당하는 중분류 데이터 view 로 가져감
	 */
	@RequestMapping(value = "filter", method = RequestMethod.POST)
	@ResponseBody
	public List<FilterSubPropDTO> getSubProperty(HttpServletRequest req, @RequestParam String propertyTypeId) 
			throws Exception {
		List<FilterSubPropDTO> selectedSubProperty = adminMapper.getSubProperty(propertyTypeId);
		return selectedSubProperty;  
	}
	
	/*
	 * 컨트롤러에서는 넘어온 데이터를 String 형으로 받아서 Object인 JSONArray 형태로 변환하여 처리합니다.
		이때 방법은 Json 라이브러리와 Gson 라이브러리를 이용한 방법을 사용하면 됩니다.
		Gson은 JSON구조의 직렬화된 데이터를 JAVA의 객체로 역질렬화, 직렬화 해주는 자바 라이브러리 입니다.
		JSON Object -> Java Object 또는 그 반대의 행위를 돕는 라이브러리 입니다.
	 */
	@RequestMapping(value="filter/update_prop", method = RequestMethod.POST)
	@ResponseBody
	public int updatePropertyList(HttpServletRequest req, @RequestParam String data) 
			throws Exception {
		Map<String, Object> result = new HashMap<>();
		int res = 0;
		try {
			List<Map<String, Object>> datalist = new Gson().fromJson(String.valueOf(data), new TypeToken<List<Map<String, Object>>>(){}.getType());
			//json으로 받아온 데이터들 신규추가 / 수정 하나씩 진행
			for (Map<String, Object> prop : datalist) {
				String key = (String) prop.get("id");
				if(key.contains("new")) {	//신규인지 아닌지 구분
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
