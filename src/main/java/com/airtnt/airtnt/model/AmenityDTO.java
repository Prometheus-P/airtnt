package com.airtnt.airtnt.model;

public class AmenityDTO {
	
	private int id;
	private int propertyId;
	
	// amenity 테이블 참조값
	private int amenityTypeId;
	private String amenityTypeName;

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
	public int getAmenityTypeId() {
		return amenityTypeId;
	}
	public void setAmenityTypeId(int amenityTypeId) {
		this.amenityTypeId = amenityTypeId;
	}
	public String getAmenityTypeName() {
		return amenityTypeName;
	}
	public void setAmenityTypeName(String amenityTypeName) {
		this.amenityTypeName = amenityTypeName;
	}
	
	@Override
	public String toString() {
		return "AmenityDTO [id=" + id + ", propertyId=" + propertyId + ", amenityTypeId=" + amenityTypeId
				+ ", amenityTypeName=" + amenityTypeName + "]";
	}
}
