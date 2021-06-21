package com.airtnt.airtnt.model;

import java.sql.Date;

public class PropertyDTO {
	
	private int id;
	private String name;
	private String host_id;
	private String property_desc;
	private String property_type_name;	// 주거형태
	private String sub_property_type_name;	
	private String room_type_name;
	private String address;
	private String latitude;
	private String longitude;
	private int price;
	private int bed_count;
	private int max_guest;
	private Date reg_date;
	private Date mod_date;
	
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
	public String getHost_id() {
		return host_id;
	}
	public void setHost_id(String host_id) {
		this.host_id = host_id;
	}
	public String getProperty_desc() {
		return property_desc;
	}
	public void setProperty_desc(String property_desc) {
		this.property_desc = property_desc;
	}
	public String getProperty_type_name() {
		return property_type_name;
	}
	public void setProperty_type_name(String property_type_name) {
		this.property_type_name = property_type_name;
	}
	public String getSub_property_type_name() {
		return sub_property_type_name;
	}
	public void setSub_property_type_name(String sub_property_type_name) {
		this.sub_property_type_name = sub_property_type_name;
	}
	public String getRoom_type_name() {
		return room_type_name;
	}
	public void setRoom_type_name(String room_type_name) {
		this.room_type_name = room_type_name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getBed_count() {
		return bed_count;
	}
	public void setBed_count(int bed_count) {
		this.bed_count = bed_count;
	}
	public int getMax_guest() {
		return max_guest;
	}
	public void setMax_guest(int max_guest) {
		this.max_guest = max_guest;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public Date getMod_date() {
		return mod_date;
	}
	public void setMod_date(Date mod_date) {
		this.mod_date = mod_date;
	}
	
}
