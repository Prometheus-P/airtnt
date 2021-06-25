package com.airtnt.airtnt.model;

public class RoomTypeDTO {
	private int id;	// fk
	private String name;
	private String isUSe;
	
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
	public String getIsUSe() {
		return isUSe;
	}
	public void setIsUSe(String isUSe) {
		this.isUSe = isUSe;
	}
	@Override
	public String toString() {
		return "RoomTypeDTO [id=" + id + ", name=" + name + "]";
	}
}
