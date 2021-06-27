package com.airtnt.airtnt.service;

import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.airtnt.airtnt.model.GuideDTO;
import com.airtnt.airtnt.model.PropertyDTO;
import com.airtnt.airtnt.model.PropertyTypeDTO;
import com.airtnt.airtnt.model.RoomTypeDTO;
import com.airtnt.airtnt.model.SubPropertyTypeDTO;

@Service //
public class HostMapper {
	@Autowired
	private SqlSession sqlSession;

	public List<GuideDTO> getGuideList(){
		List<GuideDTO> listGuide = sqlSession.selectList("listGuide");
		if(listGuide==null) {
			System.out.print("ok");
		}
		return listGuide;
	}
	public GuideDTO getGuide(int id) {
		GuideDTO guideDTO = sqlSession.selectOne("getGuide", id);
		return guideDTO;
	}
	public int insertProperty(PropertyDTO dto) {
		int res = sqlSession.insert("insertProperty", dto);
		return res;
	}

	public int deleteProperty() {
		int res = sqlSession.delete("deleteProperty");
		return res;
	}

	/*
	 * public void saveImage(Map<String, Object> hmap) { int res =
	 * sqlSession.insert("saveImage", hmap); }
	 */
	public List<PropertyTypeDTO> getPropertyType() {
		List<PropertyTypeDTO> propertyType = sqlSession.selectList("propertyType");
		return propertyType;
	}
	public List<SubPropertyTypeDTO> getSubPropertyType(int propertyTypeId) {
		List<SubPropertyTypeDTO> subPropertyType = sqlSession.selectList("subPropertyType", propertyTypeId);
		return subPropertyType;
	}
	public List<RoomTypeDTO> getRoomType(){
		List<RoomTypeDTO> roomType = sqlSession.selectList("roomType");
		return roomType;
	}
}