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
	
	// 여기 주인 이름
	public List<BookingDTO> getPlanedBooking(String member_id) {
		List<BookingDTO> list = sqlSession.selectList("getPlanedBooking", member_id);
		
		return list;
	}
	public List<BookingDTO> getPreBooking(String member_id) {
		List<BookingDTO> list = sqlSession.selectList("getPreBooking", member_id);
		
		return list;
	}
	
	// 정석
	
	// 상세보기 페이지 달력 비활성화 목록
	public List<BookingDTO> selectFutureBookings(int propertyId){
		return sqlSession.selectList("selectFutureBookings", propertyId);
	}
	
	// 예약, 결제
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
