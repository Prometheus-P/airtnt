package com.airtnt.airtnt.model;

import java.sql.Date;

public class AmenityTypeDTO {
	private int id;
	private String name;
	private char isUse;
	private Date regDate;
	private Date modDate;
	
	public AmenityTypeDTO() {};
	
	public AmenityTypeDTO(String name, String isUse) {
		this.name = name;
		this.isUse = isUse.charAt(0);
	}
	
	public AmenityTypeDTO(String id, String name, String isUse) {
		this.id = Integer.parseInt(id);
		this.name = name;
		this.isUse = isUse.charAt(0);
	}
	
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
	
	@Override
	public String toString() {
		return "AmenityTypeDTO [id=" + id + ", name=" + name + ", isUse=" + isUse + ", regDate=" + regDate
				+ ", modDate=" + modDate + "]";
	}
}
