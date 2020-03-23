package com.kh.kkiri.event.model.vo;

import java.sql.Date;

public class Report {
	
	private int reportNo;
	private int eventNo;
	private int memberNo;
	private String reportCategory;
	private String reportContent;
	private Date reportDate;
	
	public Report() {
		// TODO Auto-generated constructor stub
	}

	public Report(int reportNo, int eventNo, int memberNo, String reportCategory, String reportContent,
			Date reportDate) {
		super();
		this.reportNo = reportNo;
		this.eventNo = eventNo;
		this.memberNo = memberNo;
		this.reportCategory = reportCategory;
		this.reportContent = reportContent;
		this.reportDate = reportDate;
	}

	public int getReportNo() {
		return reportNo;
	}

	public void setReportNo(int reportNo) {
		this.reportNo = reportNo;
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

	public String getReportCategory() {
		return reportCategory;
	}

	public void setReportCategory(String reportCategory) {
		this.reportCategory = reportCategory;
	}

	public String getReportContent() {
		return reportContent;
	}

	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}

	public Date getReportDate() {
		return reportDate;
	}

	public void setReportDate(Date reportDate) {
		this.reportDate = reportDate;
	}

	@Override
	public String toString() {
		return "Report [reportNo=" + reportNo + ", eventNo=" + eventNo + ", memberNo=" + memberNo + ", reportCategory="
				+ reportCategory + ", reportContent=" + reportContent + ", reportDate=" + reportDate + "]";
	}
	
	
	

}
