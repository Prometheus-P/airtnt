package com.airtnt.airtnt.service;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.model.AmenityDTO;
import com.airtnt.airtnt.model.AmenityTypeDTO;
import com.airtnt.airtnt.model.BookingDTO;
import com.airtnt.airtnt.model.GuideContextDTO;
import com.airtnt.airtnt.model.GuideDTO;
import com.airtnt.airtnt.model.ImageDTO;
import com.airtnt.airtnt.model.MemberDTO;
import com.airtnt.airtnt.model.PropertyDTO;
import com.airtnt.airtnt.model.PropertyTypeDTO;
import com.airtnt.airtnt.model.ReviewDTO;
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

	public List<GuideContextDTO> getGuideContext(int guideId) {
		List<GuideContextDTO> list = sqlSession.selectList("getGuideContext", guideId);
		return list;
	}

	@Override
	public int insertProperty(PropertyDTO dto) {
		int res = sqlSession.insert("insertProperty", dto);
		return res;
	}
	
	//성공해도 리턴값 -1
	@Override
	public int deleteProperty(Integer propertyId) {
		int res = sqlSession.delete("deleteProperty",propertyId);
		return res+2;
	}

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
	public int updateProperty(PropertyDTO dto) {
		int res = sqlSession.update("updateProperty", dto);
		return res;
	}

	@Override
	public List<PropertyDTO> getPropertyList(String hostId) {
		List<PropertyDTO> listProperty = sqlSession.selectList("listProperty", hostId);
		for(PropertyDTO dto : listProperty) {
			System.out.println("숙소 ID: " + dto.getId());
		}
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
		// 6월 29, 2021 10:31:02 오전
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
		return 0;
	}

	public int updateMemberMode(String memberId) {
		int res = sqlSession.update("updateMemberMode", memberId);
		return res;
	}

	public List<ReviewDTO> getReviewList(int propertyId) {
		List<ReviewDTO> list = sqlSession.selectList("getReviewList", propertyId);
		return list;
	}

	public List<Map<String, Integer>> getReviewWritingRate(Integer propertyId) {
		List<Map<String, Integer>> listMap = sqlSession.selectList("getReviewWritingRate", propertyId);
		return listMap;
	}

	public int bookConfirm(int bookingId) {
		int res = sqlSession.update("bookConfirm", bookingId);
		return res;
	}
	
	public int payExptDateConfirm(Map<String, Object> payExptDateConfirm) {
		int res = sqlSession.update("payExptDateConfirm", payExptDateConfirm);
		return res;
	}

	public int bookReject(int bookingId) {
		int res = sqlSession.update("bookReject", bookingId);
		return res;
	}

	public int transactionRefund(int bookingId) {
		int res = sqlSession.update("transactionRefund", bookingId);
		return res;
	}
	
	public int imageInsert(List<ImageDTO> listImage) {
		for(int i=0; i<listImage.size(); i++) {
			listImage.get(i).setId(sqlSession.selectOne("getImageSequence"));
		}
		int res = sqlSession.insert("imageInsert", listImage);
		return res;
	}

	public int insertListAmenity(List<AmenityTypeDTO> listAmenity) {
		for(int i=0; i<listAmenity.size(); i++) {
			listAmenity.get(i).setAmenityId(sqlSession.selectOne("getAmenitySequence"));
		}
		int res = sqlSession.update("insertListAmenity", listAmenity);
		return res;
	}
	
	public List<ImageDTO> getPropertyImage(int propertyId){
		List<ImageDTO> list = sqlSession.selectList("getPropertyImage", propertyId);
		return list;
	}
	
	public List<AmenityTypeDTO> getAmenityList(int propertyId){
		List<AmenityTypeDTO> list = sqlSession.selectList("getAmenityList", propertyId);
		return list;
	}
	
	public int deleteAmenity(int propertyId) {
		int res = sqlSession.delete("deleteAmenity",propertyId);
		return res;
	}
	
}