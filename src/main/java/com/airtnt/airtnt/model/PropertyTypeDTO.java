package com.airtnt.airtnt.model;

import java.util.List;

public class PropertyTypeDTO extends AbstractTypeDTO {
	
	private List<SubPropertyTypeDTO> subPropertyTypes;
	
	public PropertyTypeDTO() {}
	public PropertyTypeDTO(String name, String isUse) {
		setName(name);
		setIsUse(isUse.charAt(0));
	}
	public PropertyTypeDTO(String id, String name, String isUse) {
		setId(Integer.parseInt(id));
		setName(name);
		setIsUse(isUse.charAt(0));
	}
	
	public List<SubPropertyTypeDTO> getSubPropertyTypes() {
		return subPropertyTypes;
	}
	public void setSubPropertyTypes(List<SubPropertyTypeDTO> subPropertyTypes) {
		this.subPropertyTypes = subPropertyTypes;
	}
}
