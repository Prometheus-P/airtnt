package com.airtnt.airtnt.service;

import java.util.List;

import com.airtnt.airtnt.model.AmenityDTO;
import com.airtnt.airtnt.model.BookingDTO;
import com.airtnt.airtnt.model.GuideDTO;
import com.airtnt.airtnt.model.MemberDTO;
import com.airtnt.airtnt.model.PropertyDTO;
import com.airtnt.airtnt.model.PropertyTypeDTO;
import com.airtnt.airtnt.model.RoomTypeDTO;
import com.airtnt.airtnt.model.SubPropertyTypeDTO;
import com.airtnt.airtnt.model.TransactionDTO;

public interface HostMapperInterface {
	public List<GuideDTO> getGuideList();
	public GuideDTO getGuide(int id) ;
	public int insertProperty(PropertyDTO dto);
	public int deleteProperty();
	public int updateProperty();
	public List<PropertyDTO> getPropertyList(String hostId);
	public PropertyDTO getPropertyDetail(int propertyId);
	public List<BookingDTO> getBookingList(String hostId);
	public List<PropertyTypeDTO> getPropertyType();
	public List<SubPropertyTypeDTO> getSubPropertyType(int propertyTypeId);
	public List<AmenityDTO> getAmenityTypeList();
	public List<RoomTypeDTO> getRoomType();
	public List<TransactionDTO> getTransactionList(String hostId);
	public MemberDTO getMemberDTO(String memberId);
	//public List<QuestionDTO> getQuestionList(int hostId);
	//pubilc List<ReviewDTO> getReiewList(int bookingId);
	//public SuperHostDTO checkSuperHost(int hostId);
}
