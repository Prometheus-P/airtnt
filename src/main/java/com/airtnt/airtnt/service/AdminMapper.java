package com.airtnt.airtnt.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.model.DashBoardDTO;
import com.airtnt.airtnt.model.FilterPropDTO;
import com.airtnt.airtnt.model.FilterSubPropDTO;


@Service
public class AdminMapper {

	@Autowired
	private SqlSession sqlSession;
	
	public List<DashBoardDTO> listDashboard(){
		List<DashBoardDTO> list = sqlSession.selectList("listDashboard");
		return list;
	}
	
	//필터 대분류
	public List<FilterPropDTO> listProperty(){
		List<FilterPropDTO> list = sqlSession.selectList("listProperty");
		return list;
	}
	
	//필터 중분류
	public List<FilterSubPropDTO> listSubProperty(){
		List<FilterSubPropDTO> list = sqlSession.selectList("listSubProperty");
		return list;
	}
}
