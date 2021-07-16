package com.airtnt.airtnt.model;

import java.sql.Date;
import java.util.List;

import org.springframework.lang.Nullable;

public class PropertyDTO {
	
	// 디버깅용
	private int rowNum;
	public int getRowNum() {
		return rowNum;
	}
	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
	}
	
	private Integer id; // pk
	private String name;
	private String propertyDesc;
	private String address;
	private String latitude; //y
	private String longitude;
	private Integer price;
	private Integer bedCount;
	private Integer maxGuest;
	private Date regDate;
	private Date modDate;
	//호스트가 사용하는 메인 이미지
	private String mainImagePath;
	
	// 예전 방식
	private String hostId;
	
	// property_type 테이블 참조값
	private Integer propertyTypeId; // fk
	private String propertyTypeName;

	// sub_property_type 테이블 참조값
	private Integer subPropertyTypeId; // fk
	private String subPropertyTypeName;

	// room_type 테이블 참조값
	private Integer roomTypeId; // fk
	private String roomTypeName;
	
	// 요즘 방식
	private MemberDTO host;
	private PropertyTypeDTO propertyType;
	private SubPropertyTypeDTO subPropertyType;
	private RoomTypeDTO roomType;

	private List<AmenityTypeDTO> amenityTypes;
	private List<ImageDTO> images;
    private List<ReviewDTO> reviews;
	
	
	// 자바에서 셋팅하는 값들
	// 위시리스트에 있는지 판별하는 값
	private boolean wished;
	private Integer wishListId;
	// 별점
	private String rating;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
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
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
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
	
	// 예전 방식
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
	
	// 요즘 방식
	public MemberDTO getHost() {
		return host;
	}
	public void setHost(MemberDTO host) {
		this.host = host;
	}
	public PropertyTypeDTO getPropertyType() {
		return propertyType;
	}
	public void setPropertyType(PropertyTypeDTO propertyType) {
		this.propertyType = propertyType;
	}
	public SubPropertyTypeDTO getSubPropertyType() {
		return subPropertyType;
	}
	public void setSubPropertyType(SubPropertyTypeDTO subPropertyType) {
		this.subPropertyType = subPropertyType;
	}
	public RoomTypeDTO getRoomType() {
		return roomType;
	}
	public void setRoomType(RoomTypeDTO roomType) {
		this.roomType = roomType;
	}
	public List<AmenityTypeDTO> getAmenityTypes() {
		return amenityTypes;
	}
	public void setAmenityTypes(List<AmenityTypeDTO> amenityTypes) {
		this.amenityTypes = amenityTypes;
	}
	public List<ImageDTO> getImages() {
		return images;
	}
	public void setImages(List<ImageDTO> images) {
		this.images = images;
	}
	
	public List<ReviewDTO> getReviews() {
		return reviews;
	}
	public void setReviews(List<ReviewDTO> reviews) {
		this.reviews = reviews;
	}
	
	// 자바로 가져와서 셋팅
	// 위시리스트에 있는지 판별하는 값
	public boolean isWished() {
		return wished;
	}
	public void setWished(boolean wished) {
		this.wished = wished;
	}
	public Integer getWishListId() {
		return wishListId;
	}
	public void setWishListId(Integer wishListId) {
		this.wishListId = wishListId;
	}
	// 별점
	public String getRating() {
		return rating;
	}
	public void setRating(String rating) {
		this.rating = rating;
	}
	//main이미지의 경로만
	public String getMainImagePath() {
		return mainImagePath;
	}
	public void setMainImagePath(String mainImagePath) {
		this.mainImagePath = mainImagePath;
	}
}
