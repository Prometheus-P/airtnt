package com.airtnt.airtnt.service;

import java.util.List;
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
		int res = sqlSession.insert("writerReview",dto);
		return res;
	}

	public List<ReviewDTO> getReview(String member_id) {
		List<ReviewDTO> list = sqlSession.selectList("getReview",member_id);
		return list;
	}
	
	public List<ReviewDTO> getMoreReview(Map<String, String> params) {
		List<ReviewDTO> list = sqlSession.selectList("getMoreReview",params);
		return list;
	}

	public int deleteReview(String id) {
		int res = sqlSession.insert("deleteReview",id);
		return res;
	}

	public int updateReview(Map<String, String> params) {
		int res = sqlSession.insert("updateReview",params);
		return res;
	}

	
	
}
