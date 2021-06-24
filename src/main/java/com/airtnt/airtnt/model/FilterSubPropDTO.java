package com.airtnt.airtnt.model;

public class FilterSubPropDTO{

	private int id;
	private int propertyTypeId;
	private String name;
	private String propertyTypeName;
	private String isUse;
	
	public FilterSubPropDTO(){};
	
	public FilterSubPropDTO(String id, String name, String isUse) {
		this.id = Integer.parseInt(id);
		this.name = name;
		this.isUse = isUse;
	}
	
	public FilterSubPropDTO(String id, String propertyTypeId, String name, String isUse) {
		this.id = Integer.parseInt(id);
		this.propertyTypeId = Integer.parseInt(propertyTypeId);
		this.name = name;
		this.isUse = isUse;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPropertyTypeId() {
		return propertyTypeId;
	}
	public void setPropertyTypeId(int propertyTypeId) {
		this.propertyTypeId = propertyTypeId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPropertyTypeName() {
		return propertyTypeName;
	}
	public void setPropertyTypeName(String propertyTypeName) {
		this.propertyTypeName = propertyTypeName;
	}
	public String getIsUse() {
		return isUse;
	}
	public void setIsUse(String isUse) {
		this.isUse = isUse;
	}

}
