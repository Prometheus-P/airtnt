package com.airtnt.airtnt.model;

public class SuperHostDTO {
	//이거 일단 만들었는데 노답이라 잠시 보류
	private int hostId;
	private int totProperty;
	private int totReservation;
	private int declineReservationRate;
	private int averageReviewRate;

	public int getTotProperty() {
		return totProperty;
	}

	public void setTotProperty(int totProperty) {
		this.totProperty = totProperty;
	}

	public int getTotReservation() {
		return totReservation;
	}

	public void setTotReservation(int totReservation) {
		this.totReservation = totReservation;
	}

	public int getDeclineReservationRate() {
		return declineReservationRate;
	}

	public void setDeclineReservationRate(int declineReservationRate) {
		this.declineReservationRate = declineReservationRate;
	}

	public int getAverageReviewRate() {
		return averageReviewRate;
	}

	public void setAverageReviewRate(int averageReviewRate) {
		this.averageReviewRate = averageReviewRate;
	}

	public int getHostId() {
		return hostId;
	}

	public void setHostId(int hostId) {
		this.hostId = hostId;
	}

}
