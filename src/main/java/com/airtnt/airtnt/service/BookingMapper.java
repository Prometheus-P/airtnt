package com.airtnt.airtnt.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.model.BookingDTO;
import com.airtnt.airtnt.model.TransactionDTO;


@Service
public class BookingMapper {
	@Autowired
	private SqlSession sqlSession;
	
	// 승훈
	public List<BookingDTO> getPlanedBooking(String member_id) {
		List<BookingDTO> list = sqlSession.selectList("getPlanedBooking", member_id);
		return list;
	}
	public List<BookingDTO> getPreBooking(String member_id) {
		List<BookingDTO> list = sqlSession.selectList("getPreBooking", member_id);
		return list;
	}
	public List<BookingDTO> getToWriteReview(String member_id) {
		List<BookingDTO> list = sqlSession.selectList("getToWriteReview", member_id);
		return list;
	}
	public List<BookingDTO> getMorePreBooking(Map<String, String> params) {
		List<BookingDTO> list = sqlSession.selectList("getMorePreBooking", params);
		return list;
	}
	
	// 정석
	
	// 상세보기 페이지 달력 비활성화 목록
	public List<BookingDTO> selectFutureBookings(int propertyId){
		return sqlSession.selectList("selectFutureBookings", propertyId);
	}
	
	// 동시요청시 겹치는 예약 확인
	public List<BookingDTO> selectOverlapBookings(BookingDTO booking){
		return sqlSession.selectList("selectOverlapBookings", booking);
	}
	
	// 예약
	public int selectBookingId() {
		return sqlSession.selectOne("selectBookingId");
	}
	
	public int insertBooking(BookingDTO booking) {
		return sqlSession.insert("insertBooking", booking);
	}
	
	public BookingDTO selectBooking(int bookingId) {
		return sqlSession.selectOne("selectBooking", bookingId);
	}
	
	public int deleteBooking(int bookingId) {
		return sqlSession.delete("deleteBooking", bookingId);
	}
	
	// 결제
	public int selectTransactionId() {
		return sqlSession.selectOne("selectTransactionId");
	}
	
	public int insertTransaction(TransactionDTO transaction) {
		return sqlSession.insert("insertTransaction", transaction);
	}
	
	public TransactionDTO selectTransaction(int transactionId) {
		return sqlSession.selectOne("selectTransaction", transactionId);
	}

	
}
