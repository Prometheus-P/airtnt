package com.airtnt.airtnt.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.model.AmenityDTO;
import com.airtnt.airtnt.model.AmenityTypeDTO;
import com.airtnt.airtnt.model.BookingDTO;
import com.airtnt.airtnt.model.GuideDTO;
import com.airtnt.airtnt.model.MemberDTO;
import com.airtnt.airtnt.model.PropertyDTO;
import com.airtnt.airtnt.model.PropertyTypeDTO;
import com.airtnt.airtnt.model.RoomTypeDTO;
import com.airtnt.airtnt.model.SubPropertyTypeDTO;
import com.airtnt.airtnt.model.TransactionDTO;

@Service 
public class HostMapper implements HostMapperInterface {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<GuideDTO> getGuideList() {
		List<GuideDTO> listGuide = sqlSession.selectList("listGuide");
		if (listGuide == null) {
			System.out.print("ok");
		}
		return listGuide;
	}

	@Override
	public GuideDTO getGuide(int id) {
		GuideDTO guideDTO = sqlSession.selectOne("getGuide", id);
		return guideDTO;
	}

	@Override
	public int insertProperty(PropertyDTO dto) {
		int res = sqlSession.insert("insertProperty", dto);
		return res;
	}

	@Override
	public int deleteProperty() {
		int res = sqlSession.delete("deleteProperty");
		return res;
	}

	/*
	 * public void saveImage(Map<String, Object> hmap) { int res =
	 * sqlSession.insert("saveImage", hmap); }
	 */
	@Override
	public List<PropertyTypeDTO> getPropertyType() {
		List<PropertyTypeDTO> propertyType = sqlSession.selectList("propertyType");
		return propertyType;
	}

	@Override
	public List<SubPropertyTypeDTO> getSubPropertyType(int propertyTypeId) {
		List<SubPropertyTypeDTO> subPropertyType = sqlSession.selectList("subPropertyType", propertyTypeId);
		return subPropertyType;
	}

	@Override
	public List<RoomTypeDTO> getRoomType() {
		List<RoomTypeDTO> roomType = sqlSession.selectList("roomType");
		return roomType;
	}

	@Override
	public int updateProperty() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<PropertyDTO> getPropertyList(String hostId) {
		List<PropertyDTO> listProperty = sqlSession.selectList("listProperty", hostId);
		return listProperty;
	}

	@Override
	public PropertyDTO getProperty(int propertyId) {
		PropertyDTO dto = sqlSession.selectOne("getProperty", propertyId);
		return dto;
	}

	@Override
	public List<BookingDTO> getBookingList(String hostId) {
		List<BookingDTO> listBooking = sqlSession.selectList("listBooking", hostId);
		return listBooking;
	}

	@Override
	public List<TransactionDTO> getTransactionList(String hostId) {
		List<TransactionDTO> listTransaction = sqlSession.selectList("listTransaction", hostId);
		//6월 29, 2021 10:31:02 오전
		return listTransaction;
	}

	@Override
	public List<AmenityTypeDTO> getAmenityTypeList() {
		List<AmenityTypeDTO> list = sqlSession.selectList("listAmenityType");
		return list;
	}

	@Override
	public MemberDTO getMemberDTO(String memberId) {
		MemberDTO dto = sqlSession.selectOne("getMemberDTO", memberId);
		return dto;
	}

	@Override
	public List<TransactionDTO> getTotalEarning(String memberId) {
		List<TransactionDTO> list = sqlSession.selectList("totalEarningList", memberId);
		return list;
	}

	@Override
	public java.sql.Date getSysdate() {
		java.sql.Date date = sqlSession.selectOne("getSysdate");
		return date;
	}

	@Override
	public int getPropertyId(String hostId) {
		int propertyId = sqlSession.selectOne("getPropertyId", hostId);
		return propertyId;
	}

	@Override
	public int insertPropertyAmenity(AmenityDTO dto) {
		int res = sqlSession.insert("insertPropertyAmenity", dto);
		return res;
	}
	
	/*
	 * public PropertyTypeDTO getPropertyTypeName(int propertyTypeId) {
	 * PropertyTypeDTO dto = sqlSession.selectOne("getPropertyTypeName",
	 * propertyTypeId); return dto; }
	 * 
	 * public SubPropertyTypeDTO getSubPropertyTypeName(int subPropertyTypeId) {
	 * SubPropertyTypeDTO dto = sqlSession.selectOne("getSubPropertyTypeName",
	 * subPropertyTypeId); return dto; }
	 * 
	 * 
	 * public RoomTypeDTO getRoomTypeName(int roomTypeId) { RoomTypeDTO dto =
	 * sqlSession.selectOne("getRoomTypeName", roomTypeId); return dto; }
	 */

}