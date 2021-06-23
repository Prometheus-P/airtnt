package com.airtnt.airtnt.service;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airtnt.airtnt.model.AmenityDTO;

@Service
public class AmenityMapper {
	
	@Autowired
	SqlSession sqlSession;
	
	public List<AmenityDTO> selectAmenities(int propertyId){
		List<AmenityDTO> amenities = sqlSession.selectList("selectAmenities", propertyId);
		for(AmenityDTO amenity : amenities) {
			System.out.println(amenity);
		}
		return amenities;
	}
}
