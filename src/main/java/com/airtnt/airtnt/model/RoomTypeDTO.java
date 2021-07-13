package com.airtnt.airtnt.model;

public class RoomTypeDTO extends AbstractTypeDTO {
	
	public RoomTypeDTO() {}
	public RoomTypeDTO(String name, String isUse) {
		super(name, isUse);
	}
	public RoomTypeDTO(String id, String name, String isUse) {
		super(id, name, isUse);
	}
}
