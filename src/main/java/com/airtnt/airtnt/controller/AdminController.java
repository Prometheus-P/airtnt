package com.airtnt.airtnt.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.airtnt.airtnt.model.DashBoardDTO;
import com.airtnt.airtnt.model.FilterPropDTO;
import com.airtnt.airtnt.model.FilterSubPropDTO;
import com.airtnt.airtnt.service.AdminMapper;

@Controller
public class AdminController {
	
	@Autowired
	AdminMapper adminMapper;

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
	
	@RequestMapping(value="admin_nav", method=RequestMethod.GET)
	public String test(HttpServletRequest req) throws Exception {
		return "admin/admin_nav";
	}
	
	@RequestMapping(value="filter")
	//requestParam으로 대분류 ID(KEY) 사용
	public String listfilterMaster(HttpServletRequest req, @RequestParam String propertyTypeId) throws Exception {
		List<FilterPropDTO> propertyList = adminMapper.listProperty();
		List<FilterSubPropDTO> subPropertyList = adminMapper.listSubProperty();
		req.setAttribute("propertyList", propertyList);
		req.setAttribute("subPropertyList", subPropertyList);
		return "admin/filter";
	}

	
}
