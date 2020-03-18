package com.kh.kkiri.event.model.vo;

import java.sql.Timestamp;

public class Event {
	private int eventNo;
	private String eventTitle;
	private String eventContent;
	private String eventCategory;
	private String eventLocation;
	private double latitude;
	private double longtitude;
	private Timestamp eventStart;
	private Timestamp eventEnd;
	private int eventTicket;
	private String eventThumbnail;
	private int eventQuota;
	private int memberNo;
	private String memberNickname;
	private String memberProfile;
	private double memberRating;
	private int partyCount;
	
	
	public Event() {
		// TODO Auto-generated constructor stub
	}


	public Event(int eventNo, String eventTitle, String eventContent, String eventCategory, String eventLocation,
			double latitude, double longtitude, Timestamp eventStart, Timestamp eventEnd, int eventTicket,
			String eventThumbnail, int eventQuota, int memberNo, String memberNickname, String memberProfile,
			double memberRating, int partyCount) {
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
		this.memberNo = memberNo;
		this.memberNickname = memberNickname;
		this.memberProfile = memberProfile;
		this.memberRating = memberRating;
		this.partyCount = partyCount;
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


	public int getMemberNo() {
		return memberNo;
	}


	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}


	public String getMemberNickname() {
		return memberNickname;
	}


	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}


	public String getMemberProfile() {
		return memberProfile;
	}


	public void setMemberProfile(String memberProfile) {
		this.memberProfile = memberProfile;
	}


	public double getMemberRating() {
		return memberRating;
	}


	public void setMemberRating(double memberRating) {
		this.memberRating = memberRating;
	}


	public int getPartyCount() {
		return partyCount;
	}


	public void setPartyCount(int partyCount) {
		this.partyCount = partyCount;
	}


	@Override
	public String toString() {
		return "Event [eventNo=" + eventNo + ", eventTitle=" + eventTitle + ", eventContent=" + eventContent
				+ ", eventCategory=" + eventCategory + ", eventLocation=" + eventLocation + ", latitude=" + latitude
				+ ", longtitude=" + longtitude + ", eventStart=" + eventStart + ", eventEnd=" + eventEnd
				+ ", eventTicket=" + eventTicket + ", eventThumbnail=" + eventThumbnail + ", eventQuota=" + eventQuota
				+ ", memberNo=" + memberNo + ", memberNickname=" + memberNickname + ", memberProfile=" + memberProfile
				+ ", memberRating=" + memberRating + ", partyCount=" + partyCount + "]";
	}
	
	
	

	
		
	
}
