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
	
	public List<PropertyDTO> searchProperties(Map<String, Object> searchKeyMap) {
		return sqlSession.selectList("selectProperty", searchKeyMap);
	}
	
	public PropertyDTO selectProperty(int propertyId) {
		Map<String, Integer> selectKeyMap = new Hashtable<>();
		selectKeyMap.put("propertyId", propertyId);
		return sqlSession.selectOne("selectProperty", selectKeyMap);
	}
	
	public List<ImageDTO> selectRoomImages(int propertyId){
		return sqlSession.selectList("selectRoomImages", propertyId);
	}
	
	public List<AmenityDTO> selectAmenities(int propertyId){
		return sqlSession.selectList("selectAmenities", propertyId);
	}
	
	public List<PropertyTypeDTO> selectPropertyTypes() {
		return sqlSession.selectList("selectPropertyTypes");
	}
	
	public List<RoomTypeDTO> selectRoomTypes(){
		return sqlSession.selectList("selectRoomTypes");
	}
	
	public List<AmenityTypeDTO> selectAmenityTypes(){
		return sqlSession.selectList("selectAmenityTypes");
	}
}
