package com.kh.kkiri.myPage.model.vo;

import java.sql.Date;

public class Ticket {

	private int paymentNo;
	private int memberNo;
	private String eventName;
	private String paymentType;
	private int paymentTicket;
	private Date paymentDate;
	
	public Ticket() {
		// TODO Auto-generated constructor stub
	}

	public Ticket(int paymentNo, int memberNo, String eventName, String paymentType, int paymentTicket, Date paymentDate) {
		super();
		this.paymentNo = paymentNo;
		this.memberNo = memberNo;
		this.eventName = eventName;
		this.paymentType = paymentType;
		this.paymentTicket = paymentTicket;
		this.paymentDate = paymentDate;
	}

	public int getPaymentNo() {
		return paymentNo;
	}

	public void setPaymentNo(int paymentNo) {
		this.paymentNo = paymentNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public String geteventName() {
		return eventName;
	}

	public void seteventName(String eventName) {
		this.eventName = eventName;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public int getPaymentTicket() {
		return paymentTicket;
	}

	public void setPaymentTicket(int paymentTicket) {
		this.paymentTicket = paymentTicket;
	}

	public Date getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(Date paymentDate) {
		this.paymentDate = paymentDate;
	}

	@Override
	public String toString() {
		return "Ticket [paymentNo=" + paymentNo + ", memberNo=" + memberNo + ", eventName=" + eventName + ", paymentType="
				+ paymentType + ", paymentTicket=" + paymentTicket + ", paymentDate=" + paymentDate + "]";
	}
	
	
	
	
}
