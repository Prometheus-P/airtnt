package com.airtnt.airtnt.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
