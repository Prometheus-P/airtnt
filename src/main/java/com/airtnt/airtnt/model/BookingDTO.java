package com.airtnt.airtnt.model;

public class BookingDTO extends RoomDTO {
	
	public static final char TRUE = 'T';
	public static final char FALSE = 'F';
	
	private int bookingId;
	private String guestId;
	private String bookingDate;
	private String checkInDate;
	private String checkOutDate;
	private int guestCount;
	private int amountPaid;
	private boolean refund;
	
	public BookingDTO() {
		super();
	}
	public BookingDTO(RoomDTO room) {
		this.setRoomId(room.getRoomId());
		this.setRoomName(room.getRoomName());
		this.setHostId(room.getHostId());
		this.setDescription(room.getDescription());
		this.setRoomTypeId(room.getRoomTypeId());
		this.setPrivacyTypeId(room.getPrivacyTypeId());
		this.setAddress(room.getAddress());
		this.setLatitude(room.getLatitude());
		this.setLongitude(room.getLongitude());
		this.setPrice(room.getPrice());
		this.setBedCount(room.getBedCount());
		this.setMaxGuest(room.getMaxGuest());
	}
	
	public int getBookingId() {
		return bookingId;
	}
	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}
	public String getGuestId() {
		return guestId;
	}
	public void setGuestId(String guestId) {
		this.guestId = guestId;
	}
	public String getBookingDate() {
		return bookingDate;
	}
	public void setBookingDate(String bookingDate) {
		this.bookingDate = bookingDate;
	}
	public String getCheckInDate() {
		return checkInDate;
	}
	public void setCheckInDate(String checkInDate) {
		this.checkInDate = checkInDate;
	}
	public String getCheckOutDate() {
		return checkOutDate;
	}
	public void setCheckOutDate(String checkOutDate) {
		this.checkOutDate = checkOutDate;
	}
	public int getGuestCount() {
		return guestCount;
	}
	public void setGuestCount(int guestCount) {
		this.guestCount = guestCount;
	}
	public int getAmountPaid() {
		return amountPaid;
	}
	public void setAmountPaid(int amountPaid) {
		this.amountPaid = amountPaid;
	}
	public boolean isRefund() {
		return refund;
	}
	public void setRefund(boolean refund) {
		this.refund = refund;
	}
	
}
