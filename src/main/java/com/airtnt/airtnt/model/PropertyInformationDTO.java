package com.airtnt.airtnt.model;

import java.io.File;
import java.io.InputStream;
import java.io.Serializable;
import java.util.List;

public class PropertyInformationDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	// 입력을 위한 정보
	private List<PropertyTypeDTO> listPropertyType;
	private List<SubPropertyTypeDTO> listSubPropertyType;
	private List<RoomTypeDTO> listRoomType;
	private List<AmenityTypeDTO> listAmenityType;

	// 저장을 위한 정보
	private String hostId;
	private Integer propertyTypeId;
	private String propertyTypeName;
	private Integer subPropertyTypeId;
	private String subPropertyTypeName;
	private Integer roomTypeId;
	private String roomTypeName;
	private String address;
	private String latitude;
	private String longitude;
	private Integer bedCount;
	private Integer maxGuest;
	private List<AmenityTypeDTO> listAmenityInsert;
	private List<ImageDTO> listImage;
	private String name;
	private String description;
	private Integer price;

	private List<InputStream> listInputStream;
	private List<File> listFile;

	public List<PropertyTypeDTO> getListPropertyType() {
		return listPropertyType;
	}

	public void setListPropertyType(List<PropertyTypeDTO> listPropertyType) {
		this.listPropertyType = listPropertyType;
	}

	public List<SubPropertyTypeDTO> getListSubPropertyType() {
		return listSubPropertyType;
	}

	public void setListSubPropertyType(List<SubPropertyTypeDTO> listSubPropertyType) {
		this.listSubPropertyType = listSubPropertyType;
	}

	public List<RoomTypeDTO> getListRoomType() {
		return listRoomType;
	}

	public void setListRoomType(List<RoomTypeDTO> listRoomType) {
		this.listRoomType = listRoomType;
	}

	public List<AmenityTypeDTO> getListAmenityType() {
		return listAmenityType;
	}

	public void setListAmenityType(List<AmenityTypeDTO> listAmenityType) {
		this.listAmenityType = listAmenityType;
	}

	// 저장을 위해

	public String getHostId() {
		return hostId;
	}

	public void setHostId(String hostId) {
		this.hostId = hostId;
	}

	public Integer getPropertyTypeId() {
		return propertyTypeId;
	}

	public void setPropertyTypeId(Integer propertyTypeId) {
		this.propertyTypeId = propertyTypeId;
	}

	public String getPropertyTypeName() {
		return propertyTypeName;
	}

	public void setPropertyTypeName(String propertyTypeName) {
		this.propertyTypeName = propertyTypeName;
	}

	public Integer getSubPropertyTypeId() {
		return subPropertyTypeId;
	}

	public void setSubPropertyTypeId(Integer subPropertyTypeId) {
		this.subPropertyTypeId = subPropertyTypeId;
	}

	public String getSubPropertyTypeName() {
		return subPropertyTypeName;
	}

	public void setSubPropertyTypeName(String subPropertyTypeName) {
		this.subPropertyTypeName = subPropertyTypeName;
	}

	public Integer getRoomTypeId() {
		return roomTypeId;
	}

	public void setRoomTypeId(Integer roomTypeId) {
		this.roomTypeId = roomTypeId;
	}

	public String getRoomTypeName() {
		return roomTypeName;
	}

	public void setRoomTypeName(String roomTypeName) {
		this.roomTypeName = roomTypeName;
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

	public Integer getBedCount() {
		return bedCount;
	}

	public void setBedCount(Integer bedCount) {
		this.bedCount = bedCount;
	}

	public Integer getMaxGuest() {
		return maxGuest;
	}

	public void setMaxGuest(Integer maxGuest) {
		this.maxGuest = maxGuest;
	}

	public List<AmenityTypeDTO> getListAmenityInsert() {
		return listAmenityInsert;
	}

	public void setListAmenityInsert(List<AmenityTypeDTO> listAmenityInsert) {
		this.listAmenityInsert = listAmenityInsert;
	}

	public List<ImageDTO> getListImage() {
		return listImage;
	}

	public void setListImage(List<ImageDTO> listImage) {
		this.listImage = listImage;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public List<InputStream> getListInputStream() {
		return listInputStream;
	}

	public void setListInputStream(List<InputStream> listInputStream) {
		this.listInputStream = listInputStream;
	}

	public List<File> getListFile() {
		return listFile;
	}

	public void setListFile(List<File> listFile) {
		this.listFile = listFile;
	}

}
