package com.kh.kkiri.event.model.vo;

public class Party {
	private int eventNo;
	private int memberNo;
	private String memberType;
	private String permission;
	
	public Party() {
		// TODO Auto-generated constructor stub
	}

	public Party(int eventNo, int memberNo, String memberType, String permission) {
		super();
		this.eventNo = eventNo;
		this.memberNo = memberNo;
		this.memberType = memberType;
		this.permission = permission;
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

	public String getMemberType() {
		return memberType;
	}

	public void setMemberType(String memberType) {
		this.memberType = memberType;
	}

	public String getPermission() {
		return permission;
	}

	public void setPermission(String permission) {
		this.permission = permission;
	}

	@Override
	public String toString() {
		return "Party [eventNo=" + eventNo + ", memberNo=" + memberNo + ", memberType=" + memberType + ", permission="
				+ permission + "]";
	}
	
	
	
	
}
