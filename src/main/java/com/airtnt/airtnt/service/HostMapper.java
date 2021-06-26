package com.airtnt.airtnt.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.model.AmenityDTO;
import com.airtnt.airtnt.model.PropertyDTO;
import com.airtnt.airtnt.model.PropertyTypeDTO;
import com.airtnt.airtnt.model.RoomTypeDTO;
import com.airtnt.airtnt.model.SubPropertyTypeDTO;

@Service //
public class HostMapper {
	@Autowired
	private SqlSession sqlSession;

	public List<GuideDTO> getGuideList(){
		List<GuideDTO> guideList = sqlSession.selectList("guideList");
		return guideList;
	}
	public GuideDTO getGuide(int contentId) {
		GuideDTO guideDTO = sqlSession.selectOne("getGuide", contentId);
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