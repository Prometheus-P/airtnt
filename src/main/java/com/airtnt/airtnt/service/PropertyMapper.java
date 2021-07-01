package com.airtnt.airtnt.service;

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
		return sqlSession.selectList("searchProperties", searchKeyMap);
	}
	
	public PropertyDTO selectProperty(int propertyId) {
		return sqlSession.selectOne("selectProperty", propertyId);
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
	
	public int insertBooking(BookingDTO booking) {
		return sqlSession.insert("insertBooking", booking);
	}
	
	public BookingDTO selectSameBooking(BookingDTO booking) {
		return sqlSession.selectOne("selectSameBooking", booking);
	}
	
	public int insertTransaction(TransactionDTO transaction) {
		return sqlSession.insert("insertTransaction", transaction);
	}
	
	public TransactionDTO selectSameTransaction(TransactionDTO transaction) {
		return sqlSession.selectOne("selectSameTransaction", transaction);
	}
}
