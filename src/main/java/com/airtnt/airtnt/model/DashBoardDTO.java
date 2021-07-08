package com.airtnt.airtnt.model;

public class DashBoardDTO {

	private String checkInMonth;
	private int thisYearCheckInMonthCnt;
	private int lastYearCheckInMonthCnt;
	
	public String getCheckInMonth() {
		return checkInMonth;
	}
	public int getThisYearCheckInMonthCnt() {
		return thisYearCheckInMonthCnt;
	}
	public int getLastYearCheckInMonthCnt() {
		return lastYearCheckInMonthCnt;
	}
	public void setCheckInMonth(String checkInMonth) {
		this.checkInMonth = checkInMonth;
	}
	public void setThisYearCheckInMonthCnt(int thisYearCheckInMonthCnt) {
		this.thisYearCheckInMonthCnt = thisYearCheckInMonthCnt;
	}
	public void setLastYearCheckInMonthCnt(int lastYearCheckInMonthCnt) {
		this.lastYearCheckInMonthCnt = lastYearCheckInMonthCnt;
	}
	
	
	
}
