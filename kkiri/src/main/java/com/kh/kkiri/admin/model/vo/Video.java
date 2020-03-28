package com.kh.kkiri.admin.model.vo;

import java.sql.Date;

public class Video {
	private int videoNo;
	private String videoOriginalName;
	private String videoChangeName;
	private Date videoEnrollDate;
	private String videoStatus;
	private String videoUse;
	
	public Video() {
		// TODO Auto-generated constructor stub
	}

	public Video(int videoNo, String videoOriginalName, String videoChangeName, Date videoEnrollDate,
			String videoStatus, String videoUse) {
		super();
		this.videoNo = videoNo;
		this.videoOriginalName = videoOriginalName;
		this.videoChangeName = videoChangeName;
		this.videoEnrollDate = videoEnrollDate;
		this.videoStatus = videoStatus;
		this.videoUse = videoUse;
	}
	
	

	public Video(String videoOriginalName, String videoChangeName) {
		super();
		this.videoOriginalName = videoOriginalName;
		this.videoChangeName = videoChangeName;
	}

	public int getVideoNo() {
		return videoNo;
	}

	public void setVideoNo(int videoNo) {
		this.videoNo = videoNo;
	}

	public String getVideoOriginalName() {
		return videoOriginalName;
	}

	public void setVideoOriginalName(String videoOriginalName) {
		this.videoOriginalName = videoOriginalName;
	}

	public String getVideoChangeName() {
		return videoChangeName;
	}

	public void setVideoChangeName(String videoChangeName) {
		this.videoChangeName = videoChangeName;
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

	public String getVideoUse() {
		return videoUse;
	}

	public void setVideoUse(String videoUse) {
		this.videoUse = videoUse;
	}

	@Override
	public String toString() {
		return "Video [videoNo=" + videoNo + ", videoOriginalName=" + videoOriginalName + ", videoChangeName="
				+ videoChangeName + ", videoEnrollDate=" + videoEnrollDate + ", videoStatus=" + videoStatus
				+ ", videoUse=" + videoUse + "]";
	}

	
	
	
	
}
