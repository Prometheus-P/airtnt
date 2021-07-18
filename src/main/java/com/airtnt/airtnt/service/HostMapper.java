package com.airtnt.airtnt.service;

import java.sql.Date;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.host.PropertyInformationBean;
import com.airtnt.airtnt.model.AmenityDTO;
import com.airtnt.airtnt.model.AmenityTypeDTO;
import com.airtnt.airtnt.model.BookingDTO;
import com.airtnt.airtnt.model.GuideContextDTO;
import com.airtnt.airtnt.model.GuideDTO;
import com.airtnt.airtnt.model.ImageDTO;
import com.airtnt.airtnt.model.MemberDTO;
import com.airtnt.airtnt.model.PropertyDTO;
import com.airtnt.airtnt.model.PropertyInformationDTO;
import com.airtnt.airtnt.model.PropertyTypeDTO;
import com.airtnt.airtnt.model.ReviewDTO;
import com.airtnt.airtnt.model.RoomTypeDTO;
import com.airtnt.airtnt.model.SubPropertyTypeDTO;
import com.airtnt.airtnt.model.TransactionDTO;

@Service
public class HostMapper {
	@Autowired
	private SqlSession sqlSession;

	//////////////////////////////////////////////////
	// 1. 숙소등록을 위한 가이드 모음
	//////////////////////////////////////////////////

	public List<GuideDTO> getGuideList() {
		List<GuideDTO> listGuide = sqlSession.selectList("listGuide");
		if (listGuide == null) {
			System.out.print("ok");
		}
		return listGuide;
	}

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

	public int insertProperty(PropertyDTO dto) {
		// int res = sqlSession.insert("insertProperty", dto);
		return 0;
	}

	// 성공해도 리턴값 -1 >> PL/SQL
	// 다시 1로 나오게 함

	public int deleteProperty(Integer propertyId) {
		int res = sqlSession.delete("deleteProperty", propertyId);
		return res;
	}

	public int updateProperty(PropertyDTO dto) {
		int res = sqlSession.update("updateProperty", dto);
		return res;
	}

	public int updateMemberMode(String memberId) {
		int res = sqlSession.update("updateMemberMode", memberId);
		return res;
	}

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

	public List<PropertyDTO> getPropertyList(String hostId) {
		List<PropertyDTO> listProperty = sqlSession.selectList("listProperty", hostId);
		return listProperty;
	}

	public PropertyDTO getProperty(int propertyId) {
		PropertyDTO dto = sqlSession.selectOne("getProperty", propertyId);
		return dto;
	}

	public List<BookingDTO> getBookingList(String hostId) {
		List<BookingDTO> listBooking = sqlSession.selectList("listBooking", hostId);
		return listBooking;
	}

	public List<TransactionDTO> getTransactionList(String hostId) {
		List<TransactionDTO> listTransaction = sqlSession.selectList("listTransaction", hostId);
		return listTransaction;
	}

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

	public int bookReject(int bookingId) {
		int res = sqlSession.update("bookReject", bookingId);
		return res;
	}

	public int transactionRefund(int bookingId) {
		int res = sqlSession.update("transactionRefund", bookingId);
		return res;
	}

	public List<ImageDTO> getPropertyImage(int propertyId) {
		List<ImageDTO> list = sqlSession.selectList("getPropertyImage", propertyId);
		return list;
	}

	public List<AmenityTypeDTO> getAmenityList(int propertyId) {
		List<AmenityTypeDTO> list = sqlSession.selectList("getAmenityList", propertyId);
		return list;
	}

	public int reviewAnswer(Map<String, String> param) {
		int res = sqlSession.update("reviewAnswer", param);
		return res;
	}

	// 화이팅!!!!
	public List<PropertyTypeDTO> getListPropertyType() {
		List<PropertyTypeDTO> listPropertyType = sqlSession.selectList("getListPropertyType");
		return listPropertyType;
	}

	public List<SubPropertyTypeDTO> getListSubPropertyType() {
		List<SubPropertyTypeDTO> listSubPropertyType = sqlSession.selectList("getListSubPropertyType");
		return listSubPropertyType;
	}

	public List<RoomTypeDTO> getListRoomType() {
		List<RoomTypeDTO> listRoomType = sqlSession.selectList("getListRoomType");
		return listRoomType;
	}

	public List<AmenityTypeDTO> getListAmenityType() {
		List<AmenityTypeDTO> listAmenityType = sqlSession.selectList("getListAmenityType");
		return listAmenityType;
	}

	public int insertProperty(PropertyInformationDTO dto) {
		int res = sqlSession.update("insertProperty", dto);
		return res;
	}

	public java.sql.Date getSysdate() {
		java.sql.Date date = sqlSession.selectOne("getSysdate");
		return date;
	}

}