package com.kh.kkiri.admin.model.vo;

import java.sql.Date;

public class Video {
	private int videoNo;
	private String videoName;
	private Date videoEnrollDate;
	private String videoStatus;
	
	public Video() {
		// TODO Auto-generated constructor stub
	}

	public Video(int videoNo, String videoName, Date videoEnrollDate, String videoStatus) {
		super();
		this.videoNo = videoNo;
		this.videoName = videoName;
		this.videoEnrollDate = videoEnrollDate;
		this.videoStatus = videoStatus;
	}

	public int getVideoNo() {
		return videoNo;
	}

	public void setVideoNo(int videoNo) {
		this.videoNo = videoNo;
	}

	public String getVideoName() {
		return videoName;
	}

	public void setVideoName(String videoName) {
		this.videoName = videoName;
	}

	public Date getVideoEnrollDate() {
		return videoEnrollDate;
	}

	public void setVideoEnrollDate(Date videoEnrollDate) {
		this.videoEnrollDate = videoEnrollDate;
	}

	public String getVideoStatus() {
		return videoStatus;
	}

	public void setVideoStatus(String videoStatus) {
		this.videoStatus = videoStatus;
	}

	@Override
	public String toString() {
		return "Video [videoNo=" + videoNo + ", videoName=" + videoName + ", videoEnrollDate=" + videoEnrollDate
				+ ", videoStatus=" + videoStatus + "]";
	}
	
	
}
