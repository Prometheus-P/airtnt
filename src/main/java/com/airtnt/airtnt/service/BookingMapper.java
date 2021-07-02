package com.airtnt.airtnt.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.model.BookingDTO;


@Service
public class BookingMapper {
	@Autowired
	private SqlSession sqlSession;
	
	public List<BookingDTO> getPlanedBooking(String member_id) {
		List<BookingDTO> list = sqlSession.selectList("getPlanedBooking", member_id);
		
		return list;
	}
	public List<BookingDTO> getPreBooking(String member_id) {
		List<BookingDTO> list = sqlSession.selectList("getPreBooking", member_id);
		
		return list;
	}
}
