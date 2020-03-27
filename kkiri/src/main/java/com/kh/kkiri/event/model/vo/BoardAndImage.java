package com.kh.kkiri.event.model.vo;

import java.sql.Timestamp;

public class BoardAndImage {
	private int imgNo;
	private int eventNo;
	private String imgOriginalName;
	private String imgChangeName;
	private Timestamp imgEnrollDt;
	private int boardNo;
	private String boardTitle;
	private String boardContent;
	private Timestamp boardModifyDt;
	private int memberNo;
	
	
	public BoardAndImage() {
		// TODO Auto-generated constructor stub
	}


	public BoardAndImage(int imgNo, int eventNo, String imgOriginalName, String imgChangeName, Timestamp imgEnrollDt,
			int boardNo, String boardTitle, String boardContent, Timestamp boardModifyDt, int memberNo) {
		super();
		this.imgNo = imgNo;
		this.eventNo = eventNo;
		this.imgOriginalName = imgOriginalName;
		this.imgChangeName = imgChangeName;
		this.imgEnrollDt = imgEnrollDt;
		this.boardNo = boardNo;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.boardModifyDt = boardModifyDt;
		this.memberNo = memberNo;
	}


	int getImgNo() {
		return imgNo;
	}


	void setImgNo(int imgNo) {
		this.imgNo = imgNo;
	}


	int getEventNo() {
		return eventNo;
	}


	void setEventNo(int eventNo) {
		this.eventNo = eventNo;
	}


	String getImgOriginalName() {
		return imgOriginalName;
	}


	void setImgOriginalName(String imgOriginalName) {
		this.imgOriginalName = imgOriginalName;
	}


	String getImgChangeName() {
		return imgChangeName;
	}


	void setImgChangeName(String imgChangeName) {
		this.imgChangeName = imgChangeName;
	}


	Timestamp getImgEnrollDt() {
		return imgEnrollDt;
	}


	void setImgEnrollDt(Timestamp imgEnrollDt) {
		this.imgEnrollDt = imgEnrollDt;
	}


	int getBoardNo() {
		return boardNo;
	}


	void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}


	String getBoardTitle() {
		return boardTitle;
	}


	void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}


	String getBoardContent() {
		return boardContent;
	}


	void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}


	Timestamp getBoardModifyDt() {
		return boardModifyDt;
	}


	void setBoardModifyDt(Timestamp boardModifyDt) {
		this.boardModifyDt = boardModifyDt;
	}


	int getMemberNo() {
		return memberNo;
	}


	void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}


	@Override
	public String toString() {
		return "BoardAndImage [imgNo=" + imgNo + ", eventNo=" + eventNo + ", imgOriginalName=" + imgOriginalName
				+ ", imgChangeName=" + imgChangeName + ", imgEnrollDt=" + imgEnrollDt + ", boardNo=" + boardNo
				+ ", boardTitle=" + boardTitle + ", boardContent=" + boardContent + ", boardModifyDt=" + boardModifyDt
				+ ", memberNo=" + memberNo + "]";
	}
	
	
}
