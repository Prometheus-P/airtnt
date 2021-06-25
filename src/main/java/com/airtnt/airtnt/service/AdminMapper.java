package com.airtnt.airtnt.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.model.DashBoardDTO;
import com.airtnt.airtnt.model.FilterPropDTO;
import com.airtnt.airtnt.model.FilterSubPropDTO;
import com.airtnt.airtnt.model.MemberDTO;
import com.airtnt.airtnt.model.RoomTypeDTO;


@Service
public class AdminMapper {

	@Autowired
	private SqlSession sqlSession;
	
	public List<DashBoardDTO> listDashboard(){
		List<DashBoardDTO> list = sqlSession.selectList("listDashboard");
		return list;
	}
	
	//[filter] : roomTypeList 
	public List<RoomTypeDTO> selectRoomTypeList(){
		List<RoomTypeDTO> list = sqlSession.selectList("selectRoomTypeList");
		return list;
	}
	
	//[filter] : propertyTypeList
	public List selectPropertyTypeList(){
		List list = sqlSession.selectList("selectPropertyTypeList");
		return list;
	}
	
	//[filter] : subPropertyTypeList
	public List selectSubPropertyTypeList(){
		List list = sqlSession.selectList("selectSubPropertyTypeList");
		return list;
	}
	
	//[filter] : amenityTypeList
	public List selectAmenityTypeList(){
		List list = sqlSession.selectList("selectAmenityTypeList");
		return list;
	}
	
	//[member] : 멤버 전체 조회
	public List<MemberDTO> selectMemberList(){
		List<MemberDTO> list = sqlSession.selectList("selectMemberList");
		return list;
	}
	
}
