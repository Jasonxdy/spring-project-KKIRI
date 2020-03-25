package com.kh.kkiri.event.model.vo;

import java.sql.Timestamp;

public class Rating {
	
	private int ratingNo;
	private int eventNo;
	private int memberNo;
	private String ratingContent;
	private Timestamp ratingModifyDate;
	private double ratingScore;
	private String ratingStatus;
	
	
	public Rating() {
		// TODO Auto-generated constructor stub
	}


	public Rating(int ratingNo, int eventNo, int memberNo, String ratingContent, Timestamp ratingModifyDate,
			double ratingScore, String ratingStatus) {
		super();
		this.ratingNo = ratingNo;
		this.eventNo = eventNo;
		this.memberNo = memberNo;
		this.ratingContent = ratingContent;
		this.ratingModifyDate = ratingModifyDate;
		this.ratingScore = ratingScore;
		this.ratingStatus = ratingStatus;
	}


	public int getRatingNo() {
		return ratingNo;
	}


	public void setRatingNo(int ratingNo) {
		this.ratingNo = ratingNo;
	}


	public int getEventNo() {
		return eventNo;
	}


	public void setEventNo(int eventNo) {
		this.eventNo = eventNo;
	}


	public int getMemberNo() {
		return memberNo;
	}


	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}


	public String getRatingContent() {
		return ratingContent;
	}


	public void setRatingContent(String ratingContent) {
		this.ratingContent = ratingContent;
	}


	public Timestamp getRatingModifyDate() {
		return ratingModifyDate;
	}


	public void setRatingModifyDate(Timestamp ratingModifyDate) {
		this.ratingModifyDate = ratingModifyDate;
	}


	public double getRatingScore() {
		return ratingScore;
	}


	public void setRatingScore(double ratingScore) {
		this.ratingScore = ratingScore;
	}


	public String getRatingStatus() {
		return ratingStatus;
	}


	public void setRatingStatus(String ratingStatus) {
		this.ratingStatus = ratingStatus;
	}


	@Override
	public String toString() {
		return "Rating [ratingNo=" + ratingNo + ", eventNo=" + eventNo + ", memberNo=" + memberNo + ", ratingContent="
				+ ratingContent + ", ratingModifyDate=" + ratingModifyDate + ", ratingScore=" + ratingScore
				+ ", ratingStatus=" + ratingStatus + "]";
	}
	
	
	

}
