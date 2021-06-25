package com.airtnt.airtnt.model;

public class DashBoardDTO {

	private String transactionDate;
	private int thisTotSiteFee;
	private int lastTotSiteFee;
	
	public String getTransactionDate() {
		return transactionDate;
	}
	public void setTransactionDate(String transactionDate) {
		this.transactionDate = transactionDate;
	}
	public int getThisTotSiteFee() {
		return thisTotSiteFee;
	}
	public void setThisTotSiteFee(int thisTotSiteFee) {
		this.thisTotSiteFee = thisTotSiteFee;
	}
	public int getLastTotSiteFee() {
		return lastTotSiteFee;
	}
	public void setLastTotSiteFee(int lastTotSiteFee) {
		this.lastTotSiteFee = lastTotSiteFee;
	}
	
	
}
