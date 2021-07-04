package com.airtnt.airtnt.model;

import java.util.List;

public class WishListDTO {
	private int id;
	private String name;
	private String member_id;
	private String is_admin;
	private String reg_date;
	private String mod_date;
	
	private List<PropertyDTO> properties;
	
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
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getIs_admin() {
		return is_admin;
	}
	public void setIs_admin(String is_admin) {
		this.is_admin = is_admin;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getMod_date() {
		return mod_date;
	}
	public void setMod_date(String mod_date) {
		this.mod_date = mod_date;
	}
	
	
	public List<PropertyDTO> getProperties() {
		return properties;
	}
	public void setProperties(List<PropertyDTO> properties) {
		this.properties = properties;
	}
}
