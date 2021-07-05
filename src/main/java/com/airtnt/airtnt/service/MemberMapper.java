package com.airtnt.airtnt.service;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.model.MemberDTO;

@Service
public class MemberMapper {
	@Autowired
	private SqlSession sqlSession;
	
	public int inputMember(MemberDTO dto) {
		int res = sqlSession.insert("inputMember", dto);
		return res;
	}

	public MemberDTO getMember(String member_id) {
		MemberDTO dto = sqlSession.selectOne("getMember", member_id);
		return dto;
	}

	public int updateMember(MemberDTO dto) {
		int res = sqlSession.update("updateMember", dto);
		return res;
	}

	public int updateMemberImage(Map<String, String> params) {
		int res = sqlSession.update("updateMemberImage", params);
		return res;
	}
}
