package com.kh.kkiri.ask.model.vo;

import java.sql.Timestamp;

public class Ask {
	private int askNo;
	private String askTitle;
	private String askContent;
	private String askEmail;
	private String answerStatus;
	private String askAnswer;
	private Timestamp askEnrollDate;
	private Timestamp answerEnrollDate;
	private int memberNo;
	private String memberId;
	
	public Ask() {
		// TODO Auto-generated constructor stub
	}

	public Ask(int askNo, String askTitle, String askContent, String askEmail, String answerStatus, String askAnswer,
			Timestamp askEnrollDate, Timestamp answerEnrollDate, int memberNo, String memberId) {
		super();
		this.askNo = askNo;
		this.askTitle = askTitle;
		this.askContent = askContent;
		this.askEmail = askEmail;
		this.answerStatus = answerStatus;
		this.askAnswer = askAnswer;
		this.askEnrollDate = askEnrollDate;
		this.answerEnrollDate = answerEnrollDate;
		this.memberNo = memberNo;
		this.memberId = memberId;
	}

	public int getAskNo() {
		return askNo;
	}

	public void setAskNo(int askNo) {
		this.askNo = askNo;
	}

	public String getAskTitle() {
		return askTitle;
	}

	public void setAskTitle(String askTitle) {
		this.askTitle = askTitle;
	}

	public String getAskContent() {
		return askContent;
	}

	public void setAskContent(String askContent) {
		this.askContent = askContent;
	}

	public String getAskEmail() {
		return askEmail;
	}

	public void setAskEmail(String askEmail) {
		this.askEmail = askEmail;
	}

	public String getAnswerStatus() {
		return answerStatus;
	}

	public void setAnswerStatus(String answerStatus) {
		this.answerStatus = answerStatus;
	}

	public String getAskAnswer() {
		return askAnswer;
	}

	public void setAskAnswer(String askAnswer) {
		this.askAnswer = askAnswer;
	}

	public Timestamp getAskEnrollDate() {
		return askEnrollDate;
	}

	public void setAskEnrollDate(Timestamp askEnrollDate) {
		this.askEnrollDate = askEnrollDate;
	}

	public Timestamp getAnswerEnrollDate() {
		return answerEnrollDate;
	}

	public void setAnswerEnrollDate(Timestamp answerEnrollDate) {
		this.answerEnrollDate = answerEnrollDate;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	@Override
	public String toString() {
		return "Ask [askNo=" + askNo + ", askTitle=" + askTitle + ", askContent=" + askContent + ", askEmail="
				+ askEmail + ", answerStatus=" + answerStatus + ", askAnswer=" + askAnswer + ", askEnrollDate="
				+ askEnrollDate + ", answerEnrollDate=" + answerEnrollDate + ", memberNo=" + memberNo + ", memberId="
				+ memberId + "]";
	}
	
}
