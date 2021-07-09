package com.airtnt.airtnt.model;

public class RoomTypeDTO extends AbstractTypeDTO {
	
	public RoomTypeDTO() {}
	public RoomTypeDTO(String name, String isUse) {
		setName(name);
		setIsUse(isUse.charAt(0));
	}
	public RoomTypeDTO(String id, String name, String isUse) {
		setId(Integer.parseInt(id));
		setName(name);
		setIsUse(isUse.charAt(0));
	}
}
