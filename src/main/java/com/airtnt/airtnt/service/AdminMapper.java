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
	
	//[filter] : ��з� ����Ʈ
	public List<FilterPropDTO> listProperty(){
		List<FilterPropDTO> list = sqlSession.selectList("listProperty");
		return list;
	}
	
	//[filter] : �ߺз� ����Ʈ
	public List<FilterSubPropDTO> listSubProperty(){
		List<FilterSubPropDTO> list = sqlSession.selectList("listSubProperty");
		return list;
	}
	
	//[filter] : ��з� ���ý� ��з�id�� �ش��ϴ� �ߺз� ����Ʈ�� �����´�
	public List<FilterSubPropDTO> getSubProperty(String propertyTypeId){
		List<FilterSubPropDTO> list = sqlSession.selectList("getSubProperty", propertyTypeId);
		return list;
	}
	
	//[filter] : ��з� �߰�
	public int insertProperty(FilterPropDTO prop){
		int res = sqlSession.insert("insertProperty", prop);
		return res;
	}
	
	//[filter] : ��з� ����
	public int updateProperty(FilterPropDTO prop){
		int res = sqlSession.update("updateProperty", prop);
		return res;
	}
	
	//[filter] : �ߺз� �߰�
	public int insertSubProperty(FilterSubPropDTO subProp){
		int res = sqlSession.insert("insertSubProperty", subProp);
		return res;
	}
	
	//[filter] : �ߺз� ����
	public int updateSubProperty(FilterSubPropDTO subProp){
		int res = sqlSession.update("updateSubProperty", subProp);
		return res;
	}
	
	//[member] : ȸ�� ��ȸ
	public List<MemberDTO> selectMemberList(){
		List<MemberDTO> list = sqlSession.selectList("selectMemberList");
		return list;
	}
	
}
