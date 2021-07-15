package com.airtnt.airtnt.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.model.*;

@Service
public class PropertyMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 주소로 검색
	public List<PropertyDTO> searchProperties(Map<String, Object> searchKeyMap) {
		return sqlSession.selectList("searchProperties", searchKeyMap);
	}
	
	// 최근 목록
	public List<PropertyDTO> selectProperties(List<Integer> propertyIdList) {
		Map<String, List<Integer>> selectKeyMap = new Hashtable<>();
		selectKeyMap.put("propertyIdList", propertyIdList);
		return sqlSession.selectList("selectProperty", selectKeyMap);
	}
	
	public List<PropertyDTO> selectProperties(Integer[] propertyIdArray) {
		Map<String, Integer[]> selectKeyMap = new Hashtable<>();
		selectKeyMap.put("propertyIdList", propertyIdArray);
		return sqlSession.selectList("selectProperty", selectKeyMap);
	}
	
	public List<PropertyDTO> selectProperties(int... propertyIdArray) {
		Map<String, int[]> selectKeyMap = new Hashtable<>();
		selectKeyMap.put("propertyIdList", propertyIdArray);
		return sqlSession.selectList("selectProperty", selectKeyMap);
	}
	
	// 상세보기
	public PropertyDTO selectProperty(int propertyId) {
		Map<String, Integer> selectKeyMap = new Hashtable<>();
		selectKeyMap.put("propertyId", propertyId);
		return sqlSession.selectOne("selectProperty", selectKeyMap);
	}
	
	public<T extends AbstractTypeDTO> List<T> selectTypes(Class<T> typeClass) {
		switch(typeClass.getSimpleName()) {
		case "PropertyTypeDTO":	return sqlSession.selectList("selectPropertyTypes");
		case "RoomTypeDTO":		return sqlSession.selectList("selectRoomTypes");
		case "AmenityTypeDTO":	return sqlSession.selectList("selectAmenityTypes");
		default :				return null;
		}
	}
}
