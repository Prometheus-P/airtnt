package com.airtnt.airtnt.service;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.model.MemberDTO;
import com.airtnt.airtnt.model.ReviewDTO;

@Service
public class ReviewMapper {
	@Autowired
	private SqlSession sqlSession;

	public int writeReview(ReviewDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}
	
}
