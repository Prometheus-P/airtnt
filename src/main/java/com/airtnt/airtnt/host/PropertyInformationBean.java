package com.airtnt.airtnt.host;

import com.airtnt.airtnt.model.PropertyInformationDTO;

public class PropertyInformationBean {
	private PropertyInformationDTO propertyInfo = null;

	private PropertyInformationBean() {
		propertyInfo = new PropertyInformationDTO();
	}

	private static PropertyInformationBean instance = null;

	public synchronized static PropertyInformationBean getInstance() {
		if (instance == null) {
			instance = new PropertyInformationBean();
		}
		return instance;
	}

	public void clear() {
		instance = null;
	}

	public void setPropertyInformationDTO(PropertyInformationDTO propertyInfo) {
		this.propertyInfo = propertyInfo;
	}

	public PropertyInformationDTO getPropertyInformationDTO() {
		return propertyInfo;
	}
}
