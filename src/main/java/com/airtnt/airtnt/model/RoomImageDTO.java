package com.airtnt.airtnt.model;

public class RoomImageDTO {
	private int id;
	private int propertyId;
	private String fileName;
	private String fileSize;
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
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	@Override
	public String toString() {
		return "RoomImageDTO [id=" + id + ", propertyId=" + propertyId + ", fileName=" + fileName + ", fileSize="
				+ fileSize + ", priority=" + priority + "]";
	}
}
