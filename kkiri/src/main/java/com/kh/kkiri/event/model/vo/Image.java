package com.kh.kkiri.event.model.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class Image {
	int imgNo;
	int eventNo;
	String imgOriginalName;
	String imgChangeName;
	Timestamp imgEnrollDate;
	char imgStatus;
	char imgType;
	
	public Image() {}

	public Image(String imgOriginalName, String imgChangeName) {
		super();
		this.imgOriginalName = imgOriginalName;
		this.imgChangeName = imgChangeName;
	}

	public Image(int imgNo, int eventNo, String imgOriginalName, String imgChangeName, Timestamp imgEnrollDate,
			char imgStatus, char imgType) {
		super();
		this.imgNo = imgNo;
		this.eventNo = eventNo;
		this.imgOriginalName = imgOriginalName;
		this.imgChangeName = imgChangeName;
		this.imgEnrollDate = imgEnrollDate;
		this.imgStatus = imgStatus;
		this.imgType = imgType;
	}

	public int getImgNo() {
		return imgNo;
	}

	public void setImgNo(int imgNo) {
		this.imgNo = imgNo;
	}

	public int getEventNo() {
		return eventNo;
	}

	public void setEventNo(int eventNo) {
		this.eventNo = eventNo;
	}

	public String getImgOriginalName() {
		return imgOriginalName;
	}

	public void setImgOriginalName(String imgOriginalName) {
		this.imgOriginalName = imgOriginalName;
	}

	public String getImgChangeName() {
		return imgChangeName;
	}

	public void setImgChangeName(String imgChangeName) {
		this.imgChangeName = imgChangeName;
	}

	public Timestamp getImgEnrollDate() {
		return imgEnrollDate;
	}

	public void setImgEnrollDate(Timestamp imgEnrollDate) {
		this.imgEnrollDate = imgEnrollDate;
	}

	public char getImgStatus() {
		return imgStatus;
	}

	public void setImgStatus(char imgStatus) {
		this.imgStatus = imgStatus;
	}

	public char getImgType() {
		return imgType;
	}

	public void setImgType(char imgType) {
		this.imgType = imgType;
	}

	@Override
	public String toString() {
		return "Image [imgNo=" + imgNo + ", eventNo=" + eventNo + ", imgOriginalName=" + imgOriginalName
				+ ", imgChangeName=" + imgChangeName + ", imgEnrollDate=" + imgEnrollDate + ", imgStatus=" + imgStatus
				+ ", imgType=" + imgType + "]";
	}
	
	
}
