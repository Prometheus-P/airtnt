package com.airtnt.airtnt.service;

import java.util.List;

import com.airtnt.airtnt.model.BookingDTO;
import com.airtnt.airtnt.model.GuideDTO;
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
	public List<PropertyDTO> getPropertyList();
	public PropertyDTO getPropertyDetail(int propertyId);
	public List<BookingDTO> getBookingList(int hostId);
	public List<PropertyTypeDTO> getPropertyType();
	public List<SubPropertyTypeDTO> getSubPropertyType(int propertyTypeId);
	public List<RoomTypeDTO> getRoomType();
	public List<TransactionDTO> getTransactionList(int bookingId);
	//public List<QuestionDTO> getQuestionList(int hostId);
	//pubilc List<ReviewDTO> getReiewList(int bookingId);
	//public SuperHostDTO checkSuperHost(int hostId);
}
