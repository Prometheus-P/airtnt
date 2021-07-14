package com.airtnt.airtnt.model;

public class GuideContextDTO extends GuideDTO{
	private int id;
	private int guideId;
	private String regDate;
	private String modDate;
	private String context;
	
	public int getId() {
		return id;
	}
	public int getGuideId() {
		return guideId;
	}
	public String getRegDate() {
		return regDate;
	}
	public String getModDate() {
		return modDate;
	}
	public String getContext() {
		return context;
	}
	public void setId(int id) {
		this.id = id;
	}
	public void setGuideId(int guideId) {
		this.guideId = guideId;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public void setModDate(String modDate) {
		this.modDate = modDate;
	}
	public void setContext(String context) {
		this.context = context;
	}

}
