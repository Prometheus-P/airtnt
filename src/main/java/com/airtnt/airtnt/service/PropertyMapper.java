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
	
	public PropertyDTO selectPropertyById(int id) {
		return sqlSession.selectOne("selectPropertyById", id);
	}
	
	public List<PropertyDTO> searchPropertiesByAddress(String addressKey) {
		addressKey = "%" + addressKey + "%";
		List<PropertyDTO> properties = sqlSession.selectList("selectPropertiesByAddress", addressKey);
		for(PropertyDTO property : properties) {
			System.out.println(property);
		}
		return properties;
	}
}
