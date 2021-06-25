package com.airtnt.airtnt.model;

public class FilterPropDTO {
	private int id;
	private String name;
	private String isUse;
	
	public FilterPropDTO(){};
	
	public FilterPropDTO(String name, String isUse){
		this.name = name;
		this.isUse = isUse;
	}
	
	public FilterPropDTO(String id, String name, String isUse){
		this.id = Integer.parseInt(id);
		this.name = name;
		this.isUse = isUse;
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
	public String getIsUse() {
		return isUse;
	}
	public void setIsUse(String isUse) {
		this.isUse = isUse;
	}
	
}
