package com.airtnt.airtnt.model;

public class SubPropertyTypeDTO extends AbstractTypeDTO {
	
	private Integer propertyTypeId;
	private String propertyTypeName;
	
	private PropertyTypeDTO propertyType;
	
	public SubPropertyTypeDTO() {}
	public SubPropertyTypeDTO(String name, String isUse, String propertyTypeId) {
		super(name, isUse);
		this.propertyTypeId = Integer.parseInt(propertyTypeId);
	}
	public SubPropertyTypeDTO(String id, String name, String isUse, String propertyTypeId) {
		super(id, name, isUse);
		this.propertyTypeId = Integer.parseInt(propertyTypeId);
	}
	
	public Integer getPropertyTypeId() {
		return propertyTypeId;
	}
	public void setPropertyTypeId(Integer propertyTypeId) {
		this.propertyTypeId = propertyTypeId;
	}
	public String getPropertyTypeName() {
		return propertyTypeName;
	}
	public void setPropertyTypeName(String propertyTypeName) {
		this.propertyTypeName = propertyTypeName;
	}
	
	public PropertyTypeDTO getPropertyType() {
		return propertyType;
	}
	public void setPropertyType(PropertyTypeDTO propertyType) {
		this.propertyType = propertyType;
	}
}
