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

	//////////////////////////////////////////////////
	// 1. 숙소등록을 위한 가이드 모음
	//////////////////////////////////////////////////
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

	//////////////////////////////////////////////////
	// 2. 숙소 관리(등록, 삭제, 업데이트)
	//////////////////////////////////////////////////

	@Override
	public int insertProperty(PropertyDTO dto) {
		int res = sqlSession.insert("insertProperty", dto);
		return res;
	}

	// 성공해도 리턴값 -1 >> PL/SQL
	// 다시 1로 나오게 함
	@Override
	public int deleteProperty(Integer propertyId) {
		int res = sqlSession.delete("deleteProperty", propertyId);
		return res;
	}

	@Override
	public List<PropertyTypeDTO> getPropertyType() {
		List<PropertyTypeDTO> propertyType = sqlSession.selectList("propertyType");
		System.out.println("유형명: " + propertyType.get(0).getName());
		for (PropertyTypeDTO dto : propertyType) {
			System.out.println("유형명: " + dto.getName());
		}
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
	public List<AmenityTypeDTO> getAmenityTypeList() {
		List<AmenityTypeDTO> list = sqlSession.selectList("listAmenityType");
		return list;
	}

	@Override
	public int updateProperty(PropertyDTO dto) {
		int res = sqlSession.update("updateProperty", dto);
		return res;
	}

	public int updateMemberMode(String memberId) {
		int res = sqlSession.update("updateMemberMode", memberId);
		return res;
	}

	@Override
	public int getPropertyId(String hostId) {
		int propertyId = sqlSession.selectOne("getPropertyId", hostId);
		return propertyId;
	}

	public int imageInsert(List<ImageDTO> listImage) {
		for (int i = 0; i < listImage.size(); i++) {
			listImage.get(i).setId(sqlSession.selectOne("getImageSequence"));
		}
		int res = sqlSession.insert("imageInsert", listImage);
		return res;
	}

	public int insertListAmenity(List<AmenityTypeDTO> listAmenity) {
		for (int i = 0; i < listAmenity.size(); i++) {
			listAmenity.get(i).setAmenityId(sqlSession.selectOne("getAmenitySequence"));
		}
		int res = sqlSession.update("insertListAmenity", listAmenity);
		return res;
	}

	//////////////////////////////////////////////////
	// 3. 호스트 페이지에서 다양하게 보여주기(예약목록, 숙소목록, 리뷰목록, 대금 목록)
	// + 예약취소, 예약승인, 숙소 수정, 숙소 삭제, 리뷰 답변
	//////////////////////////////////////////////////

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
		return listTransaction;
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

	/*
	 * public int bookingConfirm(Map<String, Object> param) { int res =
	 * sqlSession.update("bookingConfirm", param); return res; }
	 */

	/* 예약거절 */

	public int bookReject(int bookingId) {
		int res = sqlSession.update("bookReject", bookingId);
		return res;
	}

	public int transactionRefund(int bookingId) {
		int res = sqlSession.update("transactionRefund", bookingId);
		return res;
	}

	/*
	 * public int bookingReject(int bookingId) { int res
	 * =sqlSession.update("bookingReject", bookingId); System.out.print("res: " +
	 * res); return res; }
	 */
	//

	public List<ImageDTO> getPropertyImage(int propertyId) {
		List<ImageDTO> list = sqlSession.selectList("getPropertyImage", propertyId);
		return list;
	}

	public List<AmenityTypeDTO> getAmenityList(int propertyId) {
		List<AmenityTypeDTO> list = sqlSession.selectList("getAmenityList", propertyId);
		return list;
	}

	public int deleteAmenity(int propertyId) {
		int res = sqlSession.delete("deleteAmenity", propertyId);
		return res;
	}

	public int reviewAnswer(Map<String, String> param) {
		int res = sqlSession.update("reviewAnswer", param);
		return res;
	}

	@Override
	public java.sql.Date getSysdate() {
		java.sql.Date date = sqlSession.selectOne("getSysdate");
		return date;
	}

}