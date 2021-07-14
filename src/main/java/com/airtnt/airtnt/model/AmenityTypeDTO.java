package com.airtnt.airtnt.model;

public class AmenityTypeDTO extends AbstractTypeDTO{

	private static final long serialVersionUID = 1L;
	private Integer propertyId;
	
	public AmenityTypeDTO() {}
	public AmenityTypeDTO(String name, String isUse) {
		setName(name);
		setIsUse(isUse.charAt(0));
	}
	public AmenityTypeDTO(String id, String name, String isUse) {
		setId(Integer.parseInt(id));
		setName(name);
		setIsUse(isUse.charAt(0));
	}
	public Integer getPropertyId() {
		return propertyId;
	}
	public void setPropertyId(Integer propertyId) {
		this.propertyId = propertyId;
	}
}
