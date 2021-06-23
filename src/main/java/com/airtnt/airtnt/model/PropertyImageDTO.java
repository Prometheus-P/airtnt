package com.airtnt.airtnt.model;

public class PropertyImageDTO {
	
	private int id;
	private int propertyId;
	private String imageName;
	
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
	public String getImageName() {
		return imageName;
	}
	public void setImageName(String imageName) {
		this.imageName = imageName;
	}
	
	@Override
	public String toString() {
		return "PropertyImageDTO [id=" + id + ", propertyId=" + propertyId + ", imageName=" + imageName + "]";
	}
}
