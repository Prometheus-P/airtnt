package com.airtnt.airtnt.model;

public class RoomPhotoDTO {
	private String memberId;
	private int propertyId;
	private String photoName;
	private String phtoSize;

	public int getPropertyId() {
		return propertyId;
	}

	public void setPropertyId(int propertyId) {
		this.propertyId = propertyId;
	}

	public String getPhotoName() {
		return photoName;
	}

	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getPhtoSize() {
		return phtoSize;
	}

	public void setPhtoSize(String phtoSize) {
		this.phtoSize = phtoSize;
	}

}
