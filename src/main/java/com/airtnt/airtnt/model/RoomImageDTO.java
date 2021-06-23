package com.airtnt.airtnt.model;

public class RoomImageDTO {
	
	private int id;
	private int propertyId;
	private String imageName;
	private String imageSize;
	private int priority;
	
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
	public String getImageSize() {
		return imageSize;
	}
	public void setImageSize(String imageSize) {
		this.imageSize = imageSize;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	@Override
	public String toString() {
		return "RoomImageDTO [id=" + id + ", propertyId=" + propertyId + ", imageName=" + imageName + ", imageSize="
				+ imageSize + ", priority=" + priority + "]";
	}
	
	
}
