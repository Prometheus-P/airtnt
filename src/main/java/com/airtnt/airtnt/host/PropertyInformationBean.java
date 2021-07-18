package com.airtnt.airtnt.host;

import java.util.List;

import com.airtnt.airtnt.model.AmenityTypeDTO;
import com.airtnt.airtnt.model.ImageDTO;
import com.airtnt.airtnt.model.PropertyInformationDTO;
import com.airtnt.airtnt.model.PropertyTypeDTO;
import com.airtnt.airtnt.model.RoomTypeDTO;
import com.airtnt.airtnt.model.SubPropertyTypeDTO;

public class PropertyInformationBean {
	PropertyInformationDTO propertyInfo = new PropertyInformationDTO();

	private PropertyInformationBean() {}

	private static PropertyInformationBean instance = new PropertyInformationBean();

	public static PropertyInformationBean getInstance() {
		return instance;
	}

	public void clear() {
	    instance = null;
	  }
	// resetTheInstance(M_Singleton.class, null, "instance", null);

	public void setPropertyDTO(PropertyInformationDTO propertyInfo) {
		this.propertyInfo = propertyInfo;
	}
	
	public PropertyInformationDTO getPropertyDTO() {
		return propertyInfo;
	}
}
