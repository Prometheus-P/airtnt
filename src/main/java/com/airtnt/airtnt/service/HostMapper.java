package com.airtnt.airtnt.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.model.PropertyDTO;

@Service // 
public class HostMapper {
	@Autowired
	private SqlSession sqlSession;
	
	public int insertProperty(PropertyDTO dto) {
		int res = sqlSession.insert("insertProperty", dto);
		return res;
	}
	public int deleteProperty() {
		int res = sqlSession.delete("deleteProperty");
		return res;
	}
	/*
	 * public PropertyTypeDTO getPropertyType() {
	 * 
	 * }
	 */
}