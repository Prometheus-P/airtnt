package com.airtnt.airtnt.model;

import java.sql.Date;

public class BookingDTO {
	
	private Integer id;
	private Integer propertyId;
	private String guestId;
	private String hostId;
	private Integer guestCount;
	private Integer dayCount;
	private Integer totalPrice;
	private String bookingNumber;
	private Date checkInDate;
	private Date checkOutDate;
	private Date confirmDate;
	private Date regDate;
	private Date modDate;
	
	//tour.jsp 담을거
	private String guest_id;
	private String booking_number;
	private Date check_in_date;
	private Date check_out_date;
	private Integer total_price;
	private Date confirm_date;
	private Integer property_id;
	private String property_name;
	private String property_address;
	private String type_name;
	private String sub_type_name;
	private String room_type_name;
	private String path;
	private String is_main;
	
	//host_mode페이지에서 사용한답니다 *^^*
	private String memberId;
	private String guestName;
	private String propertyName;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getPropertyId() {
		return propertyId;
	}
	public void setPropertyId(Integer propertyId) {
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
	public Integer getGuestCount() {
		return guestCount;
	}
	public void setGuestCount(Integer guestCount) {
		this.guestCount = guestCount;
	}
	public Integer getDayCount() {
		return dayCount;
	}
	public void setDayCount(Integer dayCount) {
		this.dayCount = dayCount;
	}
	public Integer getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(Integer totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getBookingNumber() {
		return bookingNumber;
	}
	public void setBookingNumber(String bookingNumber) {
		this.bookingNumber = bookingNumber;
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
	public Date getConfirmDate() {
		return confirmDate;
	}
	public void setConfirmDate(Date confirmDate) {
		this.confirmDate = confirmDate;
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
		return "BookingDTO [id=" + id + ", propertyId=" + propertyId + ", guestId=" + guestId + ", hostId=" + hostId
				+ ", guestCount=" + guestCount + ", dayCount=" + dayCount + ", totalPrice=" + totalPrice
				+ ", bookingNumber=" + bookingNumber + ", checkInDate=" + checkInDate + ", checkOutDate=" + checkOutDate
				+ ", confirmDate=" + confirmDate + ", regDate=" + regDate + ", modDate=" + modDate + "]";
	}
	
	//tour.jsp 담을거
	public String getGuest_id() {
		return guest_id;
	}
	public void setGuest_id(String guest_id) {
		this.guest_id = guest_id;
	}
	public String getBooking_number() {
		return booking_number;
	}
	public void setBooking_number(String booking_number) {
		this.booking_number = booking_number;
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
	public Integer getTotal_price() {
		return total_price;
	}
	public void setTotal_price(Integer total_price) {
		this.total_price = total_price;
	}
	public Date getConfirm_date() {
		return confirm_date;
	}
	public void setConfirm_date(Date confirm_date) {
		this.confirm_date = confirm_date;
	}
	public Integer getProperty_id() {
		return property_id;
	}
	public void setProperty_id(Integer property_id) {
		this.property_id = property_id;
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
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getGuestName() {
		return guestName;
	}
	public void setGuestName(String guestName) {
		this.guestName = guestName;
	}
	public String getPropertyName() {
		return propertyName;
	}
	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}
}
