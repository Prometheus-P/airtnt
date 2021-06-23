package com.airtnt.airtnt.model;

import java.sql.Date;

public class PropertyDTO {
	
	private int id;
	private String name;
	private String hostId;
	private String propertyDesc;
	private String address;
	private String latitude;
	private String longitude;
	private int price;
	private int bedCount;
	private int maxGuest;
	private Date regDate;
	private Date modDate;
	
	// property_type 테이블 참조값
	private int propertyTypeId;
	private String propertyTypeName;
	
	// sub_property_type 테이블 참조값
	private int subPropertyTypeId;
	private String subPropertyTypeName;
	
	// room_type 테이블 참조값
	private int roomTypeId;
	private String roomTypeName;
	
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
	public String getHostId() {
		return hostId;
	}
	public void setHostId(String hostId) {
		this.hostId = hostId;
	}
	public String getPropertyDesc() {
		return propertyDesc;
	}
	public void setPropertyDesc(String propertyDesc) {
		this.propertyDesc = propertyDesc;
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
	public int getBedCount() {
		return bedCount;
	}
	public void setBedCount(int bedCount) {
		this.bedCount = bedCount;
	}
	public int getMaxGuest() {
		return maxGuest;
	}
	public void setMaxGuest(int maxGuest) {
		this.maxGuest = maxGuest;
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
	public int getPropertyTypeId() {
		return propertyTypeId;
	}
	public void setPropertyTypeId(int propertyTypeId) {
		this.propertyTypeId = propertyTypeId;
	}
	public String getPropertyTypeName() {
		return propertyTypeName;
	}
	public void setPropertyTypeName(String propertyTypeName) {
		this.propertyTypeName = propertyTypeName;
	}
	public int getSubPropertyTypeId() {
		return subPropertyTypeId;
	}
	public void setSubPropertyTypeId(int subPropertyTypeId) {
		this.subPropertyTypeId = subPropertyTypeId;
	}
	public String getSubPropertyTypeName() {
		return subPropertyTypeName;
	}
	public void setSubPropertyTypeName(String subPropertyTypeName) {
		this.subPropertyTypeName = subPropertyTypeName;
	}
	public int getRoomTypeId() {
		return roomTypeId;
	}
	public void setRoomTypeId(int roomTypeId) {
		this.roomTypeId = roomTypeId;
	}
	public String getRoomTypeName() {
		return roomTypeName;
	}
	public void setRoomTypeName(String roomTypeName) {
		this.roomTypeName = roomTypeName;
	}
	@Override
	public String toString() {
		return "PropertyDTO [id=" + id + ", name=" + name + ", hostId=" + hostId + ", propertyDesc=" + propertyDesc
				+ ", address=" + address + ", latitude=" + latitude + ", longitude=" + longitude + ", price=" + price
				+ ", bedCount=" + bedCount + ", maxGuest=" + maxGuest + ", regDate=" + regDate + ", modDate=" + modDate
				+ ", propertyTypeId=" + propertyTypeId + ", propertyTypeName=" + propertyTypeName
				+ ", subPropertyTypeId=" + subPropertyTypeId + ", subPropertyTypeName=" + subPropertyTypeName
				+ ", roomTypeId=" + roomTypeId + ", roomTypeName=" + roomTypeName + "]";
	}
}
