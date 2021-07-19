package com.airtnt.airtnt.model;

import java.util.List;

public class PropertyTypeDTO extends AbstractTypeDTO {
	private static final long serialVersionUID = 1L;
	
	private List<SubPropertyTypeDTO> subPropertyTypes;
	
	public PropertyTypeDTO() {}
	public PropertyTypeDTO(String name, String isUse) {
		super(name, isUse);
	}
	public PropertyTypeDTO(String id, String name, String isUse) {
		super(id, name, isUse);
	}
	
	public List<SubPropertyTypeDTO> getSubPropertyTypes() {
		return subPropertyTypes;
	}
	public void setSubPropertyTypes(List<SubPropertyTypeDTO> subPropertyTypes) {
		this.subPropertyTypes = subPropertyTypes;
	}
}
