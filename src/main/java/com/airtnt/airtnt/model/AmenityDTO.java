package com.airtnt.airtnt.model;

public class AmenityDTO {
	
	private int id;
	private int propertyId;
	
	// amenity_type 테이블 참조값
	private int amenityId;
	private String amenityName;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPropertyId() {
		return propertyId;
	}
	public void setPropertyId(int propertyId) {
		this.propertyId = propertyId;
	}
	public int getAmenityId() {
		return amenityId;
	}
	public void setAmenityId(int amenityId) {
		this.amenityId = amenityId;
	}
	public String getAmenityName() {
		return amenityName;
	}
	public void setAmenityName(String amenityName) {
		this.amenityName = amenityName;
	}
	
	@Override
	public String toString() {
		return "AmenityDTO [id=" + id + ", propertyId=" + propertyId + ", amenityId=" + amenityId + ", amenityName="
				+ amenityName + "]";
	}
}
