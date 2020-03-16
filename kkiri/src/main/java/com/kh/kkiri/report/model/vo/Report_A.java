package com.kh.kkiri.report.model.vo;

import java.sql.Date;

public class Report_A {
	private int reportNo;
	private String reportMember;
	private String reportedMember;
	private String reportCategory;
	private String eventTitle;
	private Date reportDate;
	private String reportContent;
	private int eventNo;
	
	public Report_A() {
		// TODO Auto-generated constructor stub
	}

	public Report_A(int reportNo, String reportMember, String reportedMember, String reportCategory, String eventTitle,
			Date reportDate, String reportContent, int eventNo) {
		super();
		this.reportNo = reportNo;
		this.reportMember = reportMember;
		this.reportedMember = reportedMember;
		this.reportCategory = reportCategory;
		this.eventTitle = eventTitle;
		this.reportDate = reportDate;
		this.reportContent = reportContent;
		this.eventNo = eventNo;
	}

	public int getReportNo() {
		return reportNo;
	}

	public void setReportNo(int reportNo) {
		this.reportNo = reportNo;
	}

	public String getReportMember() {
		return reportMember;
	}

	public void setReportMember(String reportMember) {
		this.reportMember = reportMember;
	}

	public String getReportedMember() {
		return reportedMember;
	}

	public void setReportedMember(String reportedMember) {
		this.reportedMember = reportedMember;
	}

	public String getReportCategory() {
		return reportCategory;
	}

	public void setReportCategory(String reportCategory) {
		this.reportCategory = reportCategory;
	}

	public String getEventTitle() {
		return eventTitle;
	}

	public void setEventTitle(String eventTitle) {
		this.eventTitle = eventTitle;
	}

	public Date getReportDate() {
		return reportDate;
	}

	public void setReportDate(Date reportDate) {
		this.reportDate = reportDate;
	}

	public String getReportContent() {
		return reportContent;
	}

	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}

	public int getEventNo() {
		return eventNo;
	}

	public void setEventNo(int eventNo) {
		this.eventNo = eventNo;
	}

	@Override
	public String toString() {
		return "Report_A [reportNo=" + reportNo + ", reportMember=" + reportMember + ", reportedMember="
				+ reportedMember + ", reportCategory=" + reportCategory + ", eventTitle=" + eventTitle + ", reportDate="
				+ reportDate + ", reportContent=" + reportContent + ", eventNo=" + eventNo + "]";
	}

		
}
