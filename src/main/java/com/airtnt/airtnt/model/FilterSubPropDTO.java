package com.airtnt.airtnt.model;

public class FilterSubPropDTO {

	private int id;
	private int property_type_id;	//부모테이블 key (id)
	private String name;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getProperty_type_id() {
		return property_type_id;
	}
	public void setProperty_type_id(int property_type_id) {
		this.property_type_id = property_type_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

}
