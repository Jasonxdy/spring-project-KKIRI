package com.kh.kkiri.event.model.vo;

import java.sql.Date;

public class Event {
	private int eventNo;
	private String eventTitle;
	private String eventContent;
	private String eventCategory;
	private String eventLocation;
	private double latitude;
	private double longtitude;
	private Date eventStart;
	private Date eventEnd;
	private int eventTicket;
	private String eventThumbnail;
	private int eventQuota;
	
	public Event() {
		// TODO Auto-generated constructor stub
	}

	public Event(int eventNo, String eventTitle, String eventContent, String eventCategory, String eventLocation,
			double latitude, double longtitude, Date eventStart, Date eventEnd, int eventTicket, String eventThumbnail,
			int eventQuota) {
		super();
		this.eventNo = eventNo;
		this.eventTitle = eventTitle;
		this.eventContent = eventContent;
		this.eventCategory = eventCategory;
		this.eventLocation = eventLocation;
		this.latitude = latitude;
		this.longtitude = longtitude;
		this.eventStart = eventStart;
		this.eventEnd = eventEnd;
		this.eventTicket = eventTicket;
		this.eventThumbnail = eventThumbnail;
		this.eventQuota = eventQuota;
	}

	public int getEventNo() {
		return eventNo;
	}

	public void setEventNo(int eventNo) {
		this.eventNo = eventNo;
	}

	public String getEventTitle() {
		return eventTitle;
	}

	public void setEventTitle(String eventTitle) {
		this.eventTitle = eventTitle;
	}

	public String getEventContent() {
		return eventContent;
	}

	public void setEventContent(String eventContent) {
		this.eventContent = eventContent;
	}

	public String getEventCategory() {
		return eventCategory;
	}

	public void setEventCategory(String eventCategory) {
		this.eventCategory = eventCategory;
	}

	public String getEventLocation() {
		return eventLocation;
	}

	public void setEventLocation(String eventLocation) {
		this.eventLocation = eventLocation;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongtitude() {
		return longtitude;
	}

	public void setLongtitude(double longtitude) {
		this.longtitude = longtitude;
	}

	public Date getEventStart() {
		return eventStart;
	}

	public void setEventStart(Date eventStart) {
		this.eventStart = eventStart;
	}

	public Date getEventEnd() {
		return eventEnd;
	}

	public void setEventEnd(Date eventEnd) {
		this.eventEnd = eventEnd;
	}

	public int getEventTicket() {
		return eventTicket;
	}

	public void setEventTicket(int eventTicket) {
		this.eventTicket = eventTicket;
	}

	public String getEventThumbnail() {
		return eventThumbnail;
	}

	public void setEventThumbnail(String eventThumbnail) {
		this.eventThumbnail = eventThumbnail;
	}

	public int getEventQuota() {
		return eventQuota;
	}

	public void setEventQuota(int eventQuota) {
		this.eventQuota = eventQuota;
	}

	@Override
	public String toString() {
		return "Event [eventNo=" + eventNo + ", eventTitle=" + eventTitle + ", eventContent=" + eventContent
				+ ", eventCategory=" + eventCategory + ", eventLocation=" + eventLocation + ", latitude=" + latitude
				+ ", longtitude=" + longtitude + ", eventStart=" + eventStart + ", eventEnd=" + eventEnd
				+ ", eventTicket=" + eventTicket + ", eventThumbnail=" + eventThumbnail + ", eventQuota=" + eventQuota
				+ "]";
	}
	
	
	
}
