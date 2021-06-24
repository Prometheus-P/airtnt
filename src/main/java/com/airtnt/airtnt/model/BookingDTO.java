package com.airtnt.airtnt.model;

import java.sql.Date;

public class BookingDTO {
	
	private int id;
	private int propertyId;
	private String guestId;
	private String hostId;
	private Date checkInDate;
	private Date checkOutDate;
	private int guestCount;
	private int totalPrice;
	private char isRefund;
	private String bookingNumber;
	private Date regDate;
	private Date modDate;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPropertyId() {
		return propertyId;
	}
	public void setPropertyId(int propertyId) {
		this.propertyId = propertyId;
	}
	public String getGuestId() {
		return guestId;
	}
	public void setGuestId(String guestId) {
		this.guestId = guestId;
	}
	public String getHostId() {
		return hostId;
	}
	public void setHostId(String hostId) {
		this.hostId = hostId;
	}
	public Date getCheckInDate() {
		return checkInDate;
	}
	public void setCheckInDate(Date checkInDate) {
		this.checkInDate = checkInDate;
	}
	public Date getCheckOutDate() {
		return checkOutDate;
	}
	public void setCheckOutDate(Date checkOutDate) {
		this.checkOutDate = checkOutDate;
	}
	public int getGuestCount() {
		return guestCount;
	}
	public void setGuestCount(int guestCount) {
		this.guestCount = guestCount;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	public char getIsRefund() {
		return isRefund;
	}
	public void setIsRefund(char isRefund) {
		this.isRefund = isRefund;
	}
	public String getBookingNumber() {
		return bookingNumber;
	}
	public void setBookingNumber(String bookingNumber) {
		this.bookingNumber = bookingNumber;
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
	
	
}
