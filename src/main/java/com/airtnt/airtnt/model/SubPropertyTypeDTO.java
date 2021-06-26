package com.airtnt.airtnt.model;

import java.sql.Date;

public class SubPropertyTypeDTO {
	private int id;
	private int propertyTypeId;
	private String name;
	private char isUse;
	private Date regDate;
	private Date modDate;
	
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
	public char getIsUse() {
		return isUse;
	}
	public void setIsUse(char isUse) {
		this.isUse = isUse;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public Date getModDate() {
		return modDate;
	}
	public void setModDate(Date modDate) {
		this.modDate = modDate;
	}
	
	@Override
	public String toString() {
		return "SubPropertyTypeDTO [id=" + id + ", propertyTypeId=" + propertyTypeId + ", name=" + name + ", isUse="
				+ isUse + ", regDate=" + regDate + ", modDate=" + modDate + "]";
	}
}
