package com.kh.kkiri.event.model.vo;

import java.sql.Timestamp;

public class EventMember {
	private int memberNo;
	private String memberNickname;
	private String memberProfile;
	private Timestamp memberSignupDate;
	private String permission;
	
	public EventMember() {
		// TODO Auto-generated constructor stub
	}

	public EventMember(int memberNo, String memberNickname, String memberProfile, Timestamp memberSignupDate,
			String permission) {
		super();
		this.memberNo = memberNo;
		this.memberNickname = memberNickname;
		this.memberProfile = memberProfile;
		this.memberSignupDate = memberSignupDate;
		this.permission = permission;
	}

	

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public String getMemberNickname() {
		return memberNickname;
	}

	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}

	public String getMemberProfile() {
		return memberProfile;
	}

	public void setMemberProfile(String memberProfile) {
		this.memberProfile = memberProfile;
	}

	public Timestamp getMemberSignupDate() {
		return memberSignupDate;
	}

	public void setMemberSignupDate(Timestamp memberSignupDate) {
		this.memberSignupDate = memberSignupDate;
	}

	public String getPermission() {
		return permission;
	}

	public void setPermission(String permission) {
		this.permission = permission;
	}

	@Override
	public String toString() {
		return "EventMember [memberNo=" + memberNo + ", memberNickname=" + memberNickname + ", memberProfile="
				+ memberProfile + ", memberSignupDate=" + memberSignupDate + ", permission=" + permission + "]";
	}
	
	
}
