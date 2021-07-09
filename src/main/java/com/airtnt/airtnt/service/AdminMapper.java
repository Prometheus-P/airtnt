package com.airtnt.airtnt.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.model.AmenityTypeDTO;
import com.airtnt.airtnt.model.DashBoardDTO;
import com.airtnt.airtnt.model.GuideDTO;
import com.airtnt.airtnt.model.MemberDTO;
import com.airtnt.airtnt.model.PropertyTypeDTO;
import com.airtnt.airtnt.model.RoomTypeDTO;
import com.airtnt.airtnt.model.SubPropertyTypeDTO;


@Service
public class AdminMapper {

	@Autowired
	private SqlSession sqlSession;
	
	//[dashboard] :월별 체크인 카운트
	public List<DashBoardDTO> listCheckInDateCntGroupByMonth(){
		List<DashBoardDTO> list = sqlSession.selectList("listCheckInDateCntGroupByMonth");
		return list;
	}
	
	//[member] : 멤버 조회
	public List<MemberDTO> selectMemberList(String member_mode, int startRow, int endRow){
		Map<String, Object> selectKeyMap = new Hashtable<>();
		selectKeyMap.put("member_mode", member_mode);
		selectKeyMap.put("startRow", startRow);
		selectKeyMap.put("endRow", endRow);
		
		return sqlSession.selectList("selectMemberList", selectKeyMap);
	}
	
	//[member] : 멤버 데이터 전체 카운트
	public int selectMemberCount(String member_mode) {
		Map<String, String> selectKeyMap = new Hashtable<>();
		selectKeyMap.put("member_mode", member_mode);
		
		int cnt = sqlSession.selectOne("selectMemberCount", selectKeyMap);
		return cnt;
	}
	
	//[filter] : roomTypeList 
	public List<RoomTypeDTO> selectRoomTypeList(){
		List<RoomTypeDTO> list = sqlSession.selectList("selectRoomTypeList");
		return list;
	}
	
	//[filter] : propertyTypeList
	public List<PropertyTypeDTO> selectPropertyTypeList(){
		List<PropertyTypeDTO> list = sqlSession.selectList("selectPropertyTypeList");
		return list;
	}
	
	//[filter] : subPropertyTypeList 
	public List<SubPropertyTypeDTO> selectSubPropertyTypeList(){
		List<SubPropertyTypeDTO> list = sqlSession.selectList("selectSubPropertyTypeList");
		return list;
	}
	
	//[filter] : subPropertyTypeList 
	public List<SubPropertyTypeDTO> getSubPropertyType(String propertyTypeId){
		List<SubPropertyTypeDTO> list = sqlSession.selectList("getSubPropertyType", propertyTypeId);
		return list;
	}
	
	//[filter] : amenityTypeList
	public List<AmenityTypeDTO> selectAmenityTypeList(){
		List<AmenityTypeDTO> list = sqlSession.selectList("selectAmenityTypeList");
		return list;
	}
	
	//[filter] : roomTypeList > insert/update
	public int updateRoomTypeDTO(String mode, RoomTypeDTO dto){
		int res = 0;
		if(mode.equals("I")) res = sqlSession.insert("insertRoomTypeDTO", dto);
		else res = sqlSession.update("updateRoomTypeDTO", dto);
		return res;
	}
	
	//[filter] : amenityTypeList > insert/update
	public int updateAmenityTypeDTO(String mode, AmenityTypeDTO dto){
		int res = 0;
		if(mode.equals("I")) res = sqlSession.insert("insertAmenityTypeDTO", dto);
		else res = sqlSession.update("updateAmenityTypeDTO", dto);
		return res;
	}
	
	//[filter] : propertyTypeList > insert/update
		public int updatePropertyTypeDTO(String mode, PropertyTypeDTO dto){
			int res = 0;
			if(mode.equals("I")) res = sqlSession.insert("insertPropertyTypeDTO", dto);
			else res = sqlSession.update("updatePropertyTypeDTO", dto);
			return res;
		}
	
	//[guide] : 게시글 등록
	public int insertBoard(GuideDTO dto) {
		int res = sqlSession.update("insertBoard", dto);
		return res;
	}
	
	//[guide] : 게시글 목록 전체 조회
	public List<GuideDTO> selectBoardList(int startRow, int endRow){
		Map<String, Object> selectKeyMap = new Hashtable<>();
		selectKeyMap.put("startRow", startRow);
		selectKeyMap.put("endRow", endRow);
		return sqlSession.selectList("selectBoardList", selectKeyMap);
	}
	
	//[guide] : 게시글 삭제
	public int deleteBoard(String id) {
		int res = sqlSession.delete("deleteBoard", id);
		return res;
	}
	
	//[guide] : 게시글 상세내용보기
	public List<GuideDTO> getSelectedBoard(String id){
		List<GuideDTO> list = sqlSession.selectList("getSelectedBoard", id);
		return list;
	}
	
	//[guide] : 게시글 수정
	public int updateSelectedBoard(GuideDTO dto) {
		int res = sqlSession.update("updateSelectedBoard", dto);
		return res;
	}
	
	//[guide] : 멤버 전체 카운트
	public int selectBoardCount() {
		int cnt = sqlSession.selectOne("selectBoardCount");
		return cnt;
	}
	
}
