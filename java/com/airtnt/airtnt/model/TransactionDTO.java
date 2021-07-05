package com.airtnt.airtnt.model;

import java.sql.Date;

public class TransactionDTO {

	private int id;
	private int bookingId;
	private char isRefund;
	private double siteFee;
	private Date payExptDate;
	private Date regDate;
	private Date modDate;

	// host가 사용하지롱
	private String hostId;
	private int totalPrice;
	private Date confirmDate;
	private Date checkOutDate;
	private int propertyId;
	private String bookingNumber;
	private String propertyName;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getBookingId() {
		return bookingId;
	}

	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}

	public char getIsRefund() {
		return isRefund;
	}

	public void setIsRefund(char isRefund) {
		this.isRefund = isRefund;
	}

	public double getSiteFee() {
		return siteFee;
	}

	public void setSiteFee(double siteFee) {
		this.siteFee = siteFee;
	}

	public Date getPayExptDate() {
		return payExptDate;
	}

	public void setPayExptDate(Date payExptDate) {
		this.payExptDate = payExptDate;
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

	@Override
	public String toString() {
		return "TransactionDTO [id=" + id + ", bookingId=" + bookingId + ", isRefund=" + isRefund + ", siteFee="
				+ siteFee + ", payExptDate=" + payExptDate + ", regDate=" + regDate + ", modDate=" + modDate + "]";
	}

	public String getHostId() {
		return hostId;
	}

	public void setHostId(String hostId) {
		this.hostId = hostId;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public Date getConfirmDate() {
		return confirmDate;
	}

	public void setConfirmDate(Date confirmDate) {
		this.confirmDate = confirmDate;
	}

	public int getPropertyId() {
		return propertyId;
	}

	public void setPropertyId(int propertyId) {
		this.propertyId = propertyId;
	}

	public String getBookingNumber() {
		return bookingNumber;
	}

	public void setBookingNumber(String bookingNumber) {
		this.bookingNumber = bookingNumber;
	}

	public Date getCheckOutDate() {
		return checkOutDate;
	}

	public void setCheckOutDate(Date checkOutDate) {
		this.checkOutDate = checkOutDate;
	}

	public String getPropertyName() {
		return propertyName;
	}

	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}

}
