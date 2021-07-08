package com.airtnt.airtnt.model;


import java.sql.Date;

public class ReviewDTO {
	private int id;
	private int property_id;
	private int booking_id;
	private String writer_id;
	private int rating;
	private String content;
	private String content_host;
	private Date content_Host_date;
	private Date reg_date;
	private Date mod_date;
	
	//view에서 담을 데이터
	private String name;
	private String address;
	private int price;
	private Date check_in_date;
	private Date check_out_date;
	private String path;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getProperty_id() {
		return property_id;
	}
	public void setProperty_id(int property_id) {
		this.property_id = property_id;
	}
	public int getBooking_id() {
		return booking_id;
	}
	public void setBooking_id(int booking_id) {
		this.booking_id = booking_id;
	}
	public String getWriter_id() {
		return writer_id;
	}
	public void setWriter_id(String writer_id) {
		this.writer_id = writer_id;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getContent_host() {
		return content_host;
	}
	public void setContent_host(String content_host) {
		this.content_host = content_host;
	}
	public Date getContent_Host_date() {
		return content_Host_date;
	}
	public void setContent_Host_date(Date content_Host_date) {
		this.content_Host_date = content_Host_date;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public Date getMod_date() {
		return mod_date;
	}
	public void setMod_date(Date mod_date) {
		this.mod_date = mod_date;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public Date getCheck_in_date() {
		return check_in_date;
	}
	public void setCheck_in_date(Date check_in_date) {
		this.check_in_date = check_in_date;
	}
	public Date getCheck_out_date() {
		return check_out_date;
	}
	public void setCheck_out_date(Date check_out_date) {
		this.check_out_date = check_out_date;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	
}
