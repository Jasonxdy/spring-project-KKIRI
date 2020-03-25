package com.kh.kkiri.member.model.vo;

public class Favorite {
	private int memberNo;
	private int favoriteNo;
	
	public Favorite(){}

	public Favorite(int memberNo, int favoriteNo) {
		super();
		this.memberNo = memberNo;
		this.favoriteNo = favoriteNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getFavoriteNo() {
		return favoriteNo;
	}

	public void setFavoriteNo(int favoriteNo) {
		this.favoriteNo = favoriteNo;
	}

	@Override
	public String toString() {
		return "Favorite [memberNo=" + memberNo + ", favoriteNo=" + favoriteNo + "]";
	}
}
