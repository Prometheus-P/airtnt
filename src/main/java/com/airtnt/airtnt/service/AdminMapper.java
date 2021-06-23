package com.airtnt.airtnt.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.model.DashBoardDTO;
import com.airtnt.airtnt.model.FilterPropDTO;
import com.airtnt.airtnt.model.FilterSubPropDTO;


@Service
public class AdminMapper {

	@Autowired
	private SqlSession sqlSession;
	
	public List<DashBoardDTO> listDashboard(){
		List<DashBoardDTO> list = sqlSession.selectList("listDashboard");
		return list;
	}
	
	//���� ��з� ����Ʈ
	public List<FilterPropDTO> listProperty(){
		List<FilterPropDTO> list = sqlSession.selectList("listProperty");
		return list;
	}
	
	//���� �ߺз� ����Ʈ
	public List<FilterSubPropDTO> listSubProperty(){
		List<FilterSubPropDTO> list = sqlSession.selectList("listSubProperty");
		return list;
	}
	
	//��з� ���ý� ��з�id�� �ش��ϴ� �ߺз� ����Ʈ�� �����´�
	public List<FilterSubPropDTO> getSubProperty(String propertyTypeId){
		List<FilterSubPropDTO> list = sqlSession.selectList("getSubProperty", propertyTypeId);
		return list;
	}
	
	//��з� �߰�
	public int insertProperty(Object prop){
		int res = sqlSession.insert("insertProperty", prop);
		return res;
	}
	
	//��з� ����
	public int updateProperty(Object prop){
		int res = sqlSession.update("updateProperty", prop);
		return res;
	}
}
