package com.kh.kkiri.search.model.vo;

import java.sql.Timestamp;
import java.sql.Timestamp;

public class Search {
	private int eventNo;
	private String eventTitle;
	private String eventContent;
	private String eventCategory;
	private String eventLocation;
	private double latitude;
	private double longitude;
	private Timestamp eventStart;
	private Timestamp eventEnd;
	private int eventTicket;
	private String eventThumbnail;
	private int eventQuota;
	private String memberId;
	private double eventScore;
	
	public Search(){}

	public Search(int eventNo, String eventTitle, String eventContent, String eventCategory, String eventLocation,
			double latitude, double longitude, Timestamp eventStart, Timestamp eventEnd, int eventTicket, String eventThumbnail,
			int eventQuota, String memberId, double eventScore) {
		super();
		this.eventNo = eventNo;
		this.eventTitle = eventTitle;
		this.eventContent = eventContent;
		this.eventCategory = eventCategory;
		this.eventLocation = eventLocation;
		this.latitude = latitude;
		this.longitude = longitude;
		this.eventStart = eventStart;
		this.eventEnd = eventEnd;
		this.eventTicket = eventTicket;
		this.eventThumbnail = eventThumbnail;
		this.eventQuota = eventQuota;
		this.memberId = memberId;
		this.eventScore = eventScore;
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

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public Timestamp getEventStart() {
		return eventStart;
	}

	public void setEventStart(Timestamp eventStart) {
		this.eventStart = eventStart;
	}

	public Timestamp getEventEnd() {
		return eventEnd;
	}

	public void setEventEnd(Timestamp eventEnd) {
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

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public double getEventScore() {
		return eventScore;
	}

	public void setEventScore(double eventScore) {
		this.eventScore = eventScore;
	}

	@Override
	public String toString() {
		return "Search [eventNo=" + eventNo + ", eventTitle=" + eventTitle + ", eventContent=" + eventContent
				+ ", eventCategory=" + eventCategory + ", eventLocation=" + eventLocation + ", latitude=" + latitude
				+ ", longitude=" + longitude + ", eventStart=" + eventStart + ", eventEnd=" + eventEnd
				+ ", eventTicket=" + eventTicket + ", eventThumbnail=" + eventThumbnail + ", eventQuota=" + eventQuota
				+ ", memberId=" + memberId + ", eventScore=" + eventScore + "]";
	}
	
	
}
