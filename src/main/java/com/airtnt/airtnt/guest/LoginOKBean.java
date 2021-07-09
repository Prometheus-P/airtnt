package com.airtnt.airtnt.guest;

import com.airtnt.airtnt.model.MemberDTO;

public class LoginOKBean {
	private String id;
	private String name;
	private String passwd;
	private String email;
	private String birth;
	private String tel;
	private String member_mode;
	private String gender;
	private String member_image;
	private String reg_date;
	private String mod_date;
	
	private LoginOKBean() {}
	private static LoginOKBean instance = new LoginOKBean();
	public static LoginOKBean getInstance() {
		return instance;
	}
	
	public void init_setting(MemberDTO dto) {
		this.id = dto.getId();
		this.name = dto.getName();
		this.passwd = dto.getPasswd();
		this.email = dto.getEmail();
		this.birth = dto.getBirth();
		this.tel = dto.getTel();
		this.member_mode = dto.getMember_mode();
		this.gender = dto.getGender();
		this.member_image = dto.getMember_image();
		this.reg_date = dto.getMember_mode();
		this.mod_date = dto.getMod_date();
	}
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getMember_mode() {
		return member_mode;
	}
	public void setMember_mode(String member_mode) {
		this.member_mode = member_mode;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getMember_image() {
		return member_image;
	}
	public void setMember_image(String member_image) {
		this.member_image = member_image;
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
	
}
