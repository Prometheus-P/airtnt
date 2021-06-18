package com.airtnt.airtnt.model;

public class RoomDTO {
	
	public static final int NONE = 0;
	
	// room type
	public static final int HOUSE = 1;
	public static final int APARTMENT = 2;
	public static final int HOTEL = 3;
	public static final int CO_HOUSE = 4;
	public static final int WOOD_HOUSE = 5;
	
	// privacy type
	public static final int ENTIRE = 1;
	public static final int PRIVATE = 2;
	public static final int PUBLIC = 3;
	
	
	private int roomId;
	private String roomName;
	private String hostId;
	private String description;
	private int roomTypeId;		// 
	private int privacyTypeId;
	private String address;
	private String latitude;
	private String longitude;
	private int price;
	private int bedCount;
	private int maxGuest;
	
	public RoomDTO() {}
	
	
	public int getRoomId() {
		return roomId;
	}
	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public String getHostId() {
		return hostId;
	}
	public void setHostId(String hostId) {
		this.hostId = hostId;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getRoomTypeId() {
		return roomTypeId;
	}
	public void setRoomTypeId(int roomTypeId) {
		this.roomTypeId = roomTypeId;
	}
	public int getPrivacyTypeId() {
		return privacyTypeId;
	}
	public void setPrivacyTypeId(int privacyTypeId) {
		this.privacyTypeId = privacyTypeId;
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
	
}
