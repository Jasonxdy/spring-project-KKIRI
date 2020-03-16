package com.kh.kkiri.member.model.vo;

import java.sql.Date;

public class Member {
	private int memberNo;
	private String memberId;
	private String memberNickname;
	private String memberPwd;
	private String memberEmail;
	private String memberGender;
	private String memberPhone;
	private String memberBirth;
	private String memberIntroduce;
	private String memberPlace;
	private String memberCategory;
	private String memberProfile;
	private Date memberSignupDate;
	private String memberGrade;
	private int memberTicket;
	private String memberAccount;
	private String memberIdSort;
	private String memberStatus;
	private double memberRating;
	
	public Member() { }

	public Member(int memberNo, String memberId, String memberNickname, String memberPwd, String memberEmail,
			String memberGender, String memberPhone, String memberBirth, String memberIntroduce, String memberPlace,
			String memberCategory, String memberProfile, Date memberSignupDate, String memberGrade, int memberTicket,
			String memberAccount, String memberIdSort, String memberStatus, double memberRating) {
		super();
		memberNo = memberNo;
		this.memberId = memberId;
		this.memberNickname = memberNickname;
		this.memberPwd = memberPwd;
		this.memberEmail = memberEmail;
		this.memberGender = memberGender;
		this.memberPhone = memberPhone;
		this.memberBirth = memberBirth;
		this.memberIntroduce = memberIntroduce;
		this.memberPlace = memberPlace;
		this.memberCategory = memberCategory;
		this.memberProfile = memberProfile;
		this.memberSignupDate = memberSignupDate;
		this.memberGrade = memberGrade;
		this.memberTicket = memberTicket;
		this.memberAccount = memberAccount;
		this.memberIdSort = memberIdSort;
		this.memberStatus = memberStatus;
		this.memberRating = memberRating;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		memberNo = memberNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberNickname() {
		return memberNickname;
	}

	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}

	public String getMemberPwd() {
		return memberPwd;
	}

	public void setMemberPwd(String memberPwd) {
		this.memberPwd = memberPwd;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public String getMemberGender() {
		return memberGender;
	}

	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}

	public String getMemberPhone() {
		return memberPhone;
	}

	public void setMemberPhone(String memberPhone) {
		this.memberPhone = memberPhone;
	}

	public String getMemberBirth() {
		return memberBirth;
	}

	public void setMemberBirth(String memberBirth) {
		this.memberBirth = memberBirth;
	}

	public String getMemberIntroduce() {
		return memberIntroduce;
	}

	public void setMemberIntroduce(String memberIntroduce) {
		this.memberIntroduce = memberIntroduce;
	}

	public String getMemberPlace() {
		return memberPlace;
	}

	public void setMemberPlace(String memberPlace) {
		this.memberPlace = memberPlace;
	}

	public String getMemberCategory() {
		return memberCategory;
	}

	public void setMemberCategory(String memberCategory) {
		this.memberCategory = memberCategory;
	}

	public String getMemberProfile() {
		return memberProfile;
	}

	public void setMemberProfile(String memberProfile) {
		this.memberProfile = memberProfile;
	}

	public Date getMemberSignupDate() {
		return memberSignupDate;
	}

	public void setMemberSignupDate(Date memberSignupDate) {
		this.memberSignupDate = memberSignupDate;
	}

	public String getMemberGrade() {
		return memberGrade;
	}

	public void setMemberGrade(String memberGrade) {
		this.memberGrade = memberGrade;
	}

	public int getMemberTicket() {
		return memberTicket;
	}

	public void setMemberTicket(int memberTicket) {
		this.memberTicket = memberTicket;
	}

	public String getMemberAccount() {
		return memberAccount;
	}

	public void setMemberAccount(String memberAccount) {
		this.memberAccount = memberAccount;
	}

	public String getMemberIdSort() {
		return memberIdSort;
	}

	public void setMemberIdSort(String memberIdSort) {
		this.memberIdSort = memberIdSort;
	}

	public String getMemberStatus() {
		return memberStatus;
	}

	public void setMemberStatus(String memberStatus) {
		this.memberStatus = memberStatus;
	}

	public double getMemberRating() {
		return memberRating;
	}

	public void setMemberRating(double memberRating) {
		this.memberRating = memberRating;
	}

	@Override
	public String toString() {
		return "Member [MemberNo=" + memberNo + ", memberId=" + memberId + ", memberNickname=" + memberNickname
				+ ", memberPwd=" + memberPwd + ", memberEmail=" + memberEmail + ", memberGender=" + memberGender
				+ ", memberPhone=" + memberPhone + ", memberBirth=" + memberBirth + ", memberIntroduce="
				+ memberIntroduce + ", memberPlace=" + memberPlace + ", memberCategory=" + memberCategory
				+ ", memberProfile=" + memberProfile + ", memberSignupDate=" + memberSignupDate + ", memberGrade="
				+ memberGrade + ", memberTicket=" + memberTicket + ", memberAccount=" + memberAccount
				+ ", memberIdSort=" + memberIdSort + ", memberStatus=" + memberStatus + ", memberRating=" + memberRating
				+ "]";
	}
	
	
}
 
