package com.kh.kkiri.notice.model.vo;

import java.sql.Date;

public class Notice {

	private int noticeNo;
	private String noticeTitle;
	private String noticeContent;
	private Date noticeEnrollDate;
	private Date noticeModifyDate;
	private String noticeStatus;
	private int noticeCount;
	private String noticeWriter;
	
	public Notice() {
	}

	public Notice(int noticeNo, String noticeTitle, String noticeContent, Date noticeEnrollDate, Date noticeModifyDate,
			String noticeStatus, int noticeCount, String noticeWriter) {
		super();
		this.noticeNo = noticeNo;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
		this.noticeEnrollDate = noticeEnrollDate;
		this.noticeModifyDate = noticeModifyDate;
		this.noticeStatus = noticeStatus;
		this.noticeCount = noticeCount;
		this.noticeWriter = noticeWriter;
	}

	
	
	
	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeContent() {
		return noticeContent;
	}

	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}

	public Date getNoticeEnrollDate() {
		return noticeEnrollDate;
	}

	public void setNoticeEnrollDate(Date noticeEnrollDate) {
		this.noticeEnrollDate = noticeEnrollDate;
	}

	public Date getNoticeModifyDate() {
		return noticeModifyDate;
	}

	public void setNoticeModifyDate(Date noticeModifyDate) {
		this.noticeModifyDate = noticeModifyDate;
	}

	public String getNoticeStatus() {
		return noticeStatus;
	}

	public void setNoticeStatus(String noticeStatus) {
		this.noticeStatus = noticeStatus;
	}

	public int getNoticeCount() {
		return noticeCount;
	}

	public void setNoticeCount(int noticeCount) {
		this.noticeCount = noticeCount;
	}

	public String getNoticeWriter() {
		return noticeWriter;
	}

	public void setNoticeWriter(String noticeWriter) {
		this.noticeWriter = noticeWriter;
	}

	@Override
	public String toString() {
		return "Notice [noticeNo=" + noticeNo + ", noticeTitle=" + noticeTitle + ", noticeContent=" + noticeContent
				+ ", noticeEnrollDate=" + noticeEnrollDate + ", noticeModifyDate=" + noticeModifyDate
				+ ", noticeStatus=" + noticeStatus + ", noticeCount=" + noticeCount + ", noticeWriter=" + noticeWriter
				+ "]";
	}

	

	
	
	
	
	
	
	
}
