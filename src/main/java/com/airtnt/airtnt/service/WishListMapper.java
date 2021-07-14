package com.airtnt.airtnt.service;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.model.AmenityDTO;
import com.airtnt.airtnt.model.PropertyDTO;
import com.airtnt.airtnt.model.WishListDTO;
import com.airtnt.airtnt.model.WishList_PropertyDTO;

@Service
public class WishListMapper {
	@Autowired
	private SqlSession sqlSession;
	
	public int makeWish(WishListDTO dto) {
		if(dto.getIs_admin()==null)
			dto.setIs_admin("N");
		int res = sqlSession.insert("makeWish", dto);	
		return res;
	}

	public List<WishList_PropertyDTO> getWish(String member_id) {
		List<WishList_PropertyDTO> list = sqlSession.selectList("getWish", member_id);
		
		return list;
	}

	public List<WishList_PropertyDTO> getAdminWish() {
		List<WishList_PropertyDTO> list = sqlSession.selectList("getAdminWish");
		return list;
	}

	public List<WishList_PropertyDTO> getWishRoom(String wish_id) {
		List<WishList_PropertyDTO> list = sqlSession.selectList("getWishRoom", wish_id);
		return list;
	}
	public List<WishList_PropertyDTO> getMoreWishRoom(Map<String, String> params) {
		List<WishList_PropertyDTO> list = sqlSession.selectList("getMoreWishRoom", params);
		return list;
	}
	public int updateWish(Map<String, String> params) {
		int res = sqlSession.update("updateWish",params);
		return res;
	}
	public int deleteWish(String wish_id) {
		int res = sqlSession.delete("deleteWish", wish_id);
		return res;
	}
	public int deleteWishRoom(String wish_id) {
		int res = sqlSession.delete("deleteWishRoom", wish_id);
		return res;
	}
	
	
	// 정석
	public List<WishListDTO> selectWishLists(Map<String, Object> wishMap){
		List<WishListDTO> wishLists = sqlSession.selectList("selectWishLists", wishMap);
		if(wishLists == null || wishLists.size() == 0) {
			// 내 아이디로 등록된 위시리스트가 없으면 id가 null인 상태로
			// 관리자 추천 위시리스트를 골라옴
			wishLists = sqlSession.selectList("selectWishLists");
		}
		return wishLists;
	}

	public int insertWishProperty(WishList_PropertyDTO dto) {
		int res = sqlSession.insert("insertWishProperty", dto);
		return res;
	}

	public int deletePropertyAsync(Map<String, String> params) {
		int res = sqlSession.delete("deletePropertyAsync", params);
		return res;
	}
}
