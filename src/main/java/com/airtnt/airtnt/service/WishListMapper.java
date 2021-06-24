package com.airtnt.airtnt.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.model.WishListDTO;
import com.airtnt.airtnt.model.WishList_RoomDTO;

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

	public List<WishListDTO> getWish(String member_id) {
		List<WishListDTO> list = sqlSession.selectList("getWish", member_id);
		return list;
	}

	public List<WishListDTO> getAdminWish() {
		List<WishListDTO> list = sqlSession.selectList("getAdminWish");
		return list;
	}

	public List<WishList_RoomDTO> getWishRoom(String wish_id) {
		List<WishList_RoomDTO> list = sqlSession.selectList("getWishRoom", wish_id);
		return list;
	}

}
