package com.airtnt.airtnt.model;

import java.sql.Date;
import java.util.List;

public class PropertyTypeDTO {
	private int id;
	private String name;
	private char isUse;
	private Date regDate;
	private Date modDate;
	
	
	private List<SubPropertyTypeDTO> subPropertyTypes;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	
	
	public List<SubPropertyTypeDTO> getSubPropertyTypes() {
		return subPropertyTypes;
	}
	public void setSubPropertyTypes(List<SubPropertyTypeDTO> subPropertyTypes) {
		this.subPropertyTypes = subPropertyTypes;
	}
	
	@Override
	public String toString() {
		return "PropertyTypeDTO [id=" + id + ", name=" + name + ", isUse=" + isUse + ", regDate=" + regDate
				+ ", modDate=" + modDate + ", subPropertyTypes=" + subPropertyTypes + "]";
	}
}
