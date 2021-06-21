package com.airtnt.airtnt.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.model.PropertyDTO;

@Service
public class PropertyMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<PropertyDTO> selectRooms(int id) {
		return sqlSession.selectList("selectRooms", id);
	}
}
