package com.airtnt.airtnt.model;

public class AmenityDTO {

	private Integer id;
	private Integer propertyId;

	private Integer amenityTypeId;
	private String name;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getPropertyId() {
		return propertyId;
	}

	public void setPropertyId(Integer propertyId) {
		this.propertyId = propertyId;
	}

	public Integer getAmenityTypeId() {
		return amenityTypeId;
	}

	public void setAmenityTypeId(Integer amenityTypeId) {
		this.amenityTypeId = amenityTypeId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
