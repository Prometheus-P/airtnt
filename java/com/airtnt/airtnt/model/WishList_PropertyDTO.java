package com.airtnt.airtnt.model;

public class WishList_PropertyDTO {
	private int id;
	private int wish_id;
	private int property_id;
	private String reg_date;
	private String mod_date;
	
	//wishlist_view담을거
	private String member_id;
	private String is_admin;
	private String path;
	private String is_main;
	private String name;
	
	//wishlist_room_view 담을거
	private String property_name;
	private String property_address;
	private String type_name;
	private String sub_type_name;
	private String room_type_name;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getWish_id() {
		return wish_id;
	}
	public void setWish_id(int wish_id) {
		this.wish_id = wish_id;
	}
	public int getProperty_id() {
		return property_id;
	}
	public void setProperty_id(int property_id) {
		this.property_id = property_id;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getMod_date() {
		return mod_date;
	}
	public void setMod_date(String mod_date) {
		this.mod_date = mod_date;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getIs_admin() {
		return is_admin;
	}
	public void setIs_admin(String is_admin) {
		this.is_admin = is_admin;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getIs_main() {
		return is_main;
	}
	public void setIs_main(String is_main) {
		this.is_main = is_main;
	}
	public String getProperty_name() {
		return property_name;
	}
	public void setProperty_name(String property_name) {
		this.property_name = property_name;
	}
	public String getProperty_address() {
		return property_address;
	}
	public void setProperty_address(String property_address) {
		this.property_address = property_address;
	}
	public String getType_name() {
		return type_name;
	}
	public void setType_name(String type_name) {
		this.type_name = type_name;
	}
	public String getSub_type_name() {
		return sub_type_name;
	}
	public void setSub_type_name(String sub_type_name) {
		this.sub_type_name = sub_type_name;
	}
	public String getRoom_type_name() {
		return room_type_name;
	}
	public void setRoom_type_name(String room_type_name) {
		this.room_type_name = room_type_name;
	}
	
}
