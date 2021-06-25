package com.airtnt.airtnt.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.model.DashBoardDTO;
import com.airtnt.airtnt.model.FilterPropDTO;
import com.airtnt.airtnt.model.FilterSubPropDTO;
import com.airtnt.airtnt.model.MemberDTO;


@Service
public class AdminMapper {

	@Autowired
	private SqlSession sqlSession;
	
	public List<DashBoardDTO> listDashboard(){
		List<DashBoardDTO> list = sqlSession.selectList("listDashboard");
		return list;
	}
	
	//[filter] : 대분류 리스트
	public List<FilterPropDTO> listProperty(){
		List<FilterPropDTO> list = sqlSession.selectList("listProperty");
		return list;
	}
	
	//[filter] : 중분류 리스트
	public List<FilterSubPropDTO> listSubProperty(){
		List<FilterSubPropDTO> list = sqlSession.selectList("listSubProperty");
		return list;
	}
	
	//[filter] : 대분류 선택시 대분류id에 해당하는 중분류 리스트를 꺼내온다
	public List<FilterSubPropDTO> getSubProperty(String propertyTypeId){
		List<FilterSubPropDTO> list = sqlSession.selectList("getSubProperty", propertyTypeId);
		return list;
	}
	
	//[filter] : 대분류 추가
	public int insertProperty(FilterPropDTO prop){
		int res = sqlSession.insert("insertProperty", prop);
		return res;
	}
	
	//[filter] : 대분류 수정
	public int updateProperty(FilterPropDTO prop){
		int res = sqlSession.update("updateProperty", prop);
		return res;
	}
	
	//[filter] : 중분류 추가
	public int insertSubProperty(FilterSubPropDTO subProp){
		int res = sqlSession.insert("insertSubProperty", subProp);
		return res;
	}
	
	//[filter] : 중분류 수정
	public int updateSubProperty(FilterSubPropDTO subProp){
		int res = sqlSession.update("updateSubProperty", subProp);
		return res;
	}
	
	//[member] : 회원 조회
	public List<MemberDTO> selectMemberList(){
		List<MemberDTO> list = sqlSession.selectList("selectMemberList");
		return list;
	}
	
}
