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
	//개인정보 변경
	public int updateMember(MemberDTO dto) {
		int res = sqlSession.update("updateMember", dto);
		return res;
	}
	//비밀번호 변경
	public int updateMember(Map<String, String> params) {
		int res = sqlSession.update("updatePasswd", params);
		return res;
	}
	
	public int updateMemberImage(Map<String, String> params) {
		int res = sqlSession.update("updateMemberImage", params);
		return res;
	}

	public int deleteMemberImage(String member_id) {
		int res = sqlSession.update("deleteMemberImage", member_id);
		return res;
	}

	public int deleteMember(String member_id) {
		int res = sqlSession.update("deleteMember", member_id);
		return res;
	}

	public MemberDTO findId(Map<String, String> params) {
		MemberDTO dto = sqlSession.selectOne("findId", params);
		return dto;
	}
	
}
