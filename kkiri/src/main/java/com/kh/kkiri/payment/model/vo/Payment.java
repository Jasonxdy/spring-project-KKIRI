package com.kh.kkiri.payment.model.vo;

import java.sql.Date;

public class Payment {
	private int paymentNo;
	private int memberNo;
	private int eventNo;
	private String paymentType;
	private int paymentTicket;
	private Date paymentDate;
	
	public Payment() {	}

	public Payment(int paymentNo, int memberNo, int eventNo, String paymentType, int paymentTicket, Date paymentDate) {
		super();
		this.paymentNo = paymentNo;
		this.memberNo = memberNo;
		this.eventNo = eventNo;
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

	public int getEventNo() {
		return eventNo;
	}

	public void setEventNo(int eventNo) {
		this.eventNo = eventNo;
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
		return "Payment [paymentNo=" + paymentNo + ", memberNo=" + memberNo + ", eventNo=" + eventNo + ", paymentType="
				+ paymentType + ", paymentTicket=" + paymentTicket + ", paymentDate=" + paymentDate + "]";
	}
	
	
}
