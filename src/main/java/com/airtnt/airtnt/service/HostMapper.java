package com.airtnt.airtnt.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.model.AmenityDTO;
import com.airtnt.airtnt.model.BookingDTO;
import com.airtnt.airtnt.model.GuideDTO;
import com.airtnt.airtnt.model.MemberDTO;
import com.airtnt.airtnt.model.PropertyDTO;
import com.airtnt.airtnt.model.PropertyTypeDTO;
import com.airtnt.airtnt.model.RoomTypeDTO;
import com.airtnt.airtnt.model.SubPropertyTypeDTO;
import com.airtnt.airtnt.model.TransactionDTO;

@Service //
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
	public PropertyDTO getPropertyDetail(int propertyId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BookingDTO> getBookingList(String hostId) {
		List<BookingDTO> listBooking = sqlSession.selectList("listBooking", hostId);
		return listBooking;
	}

	@Override
	public List<TransactionDTO> getTransactionList(String hostId) {
		List<TransactionDTO> listTransaction = sqlSession.selectList("listTransaction", hostId);
		return listTransaction;
	}

	@Override
	public List<AmenityDTO> getAmenityTypeList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MemberDTO getMemberDTO(String memberId) {
		MemberDTO dto = sqlSession.selectOne("getMemberDTO", memberId);
		return dto;
	}
}