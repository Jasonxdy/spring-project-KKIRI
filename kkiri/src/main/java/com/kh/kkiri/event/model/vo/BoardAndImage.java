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
	



	public int getImgNo() {
		return imgNo;
	}


	public void setImgNo(int imgNo) {
		this.imgNo = imgNo;
	}


	public int getEventNo() {
		return eventNo;
	}


	public void setEventNo(int eventNo) {
		this.eventNo = eventNo;
	}


	public String getImgOriginalName() {
		return imgOriginalName;
	}


	public void setImgOriginalName(String imgOriginalName) {
		this.imgOriginalName = imgOriginalName;
	}


	public String getImgChangeName() {
		return imgChangeName;
	}


	public void setImgChangeName(String imgChangeName) {
		this.imgChangeName = imgChangeName;
	}


	public Timestamp getImgEnrollDt() {
		return imgEnrollDt;
	}


	public void setImgEnrollDt(Timestamp imgEnrollDt) {
		this.imgEnrollDt = imgEnrollDt;
	}


	public int getBoardNo() {
		return boardNo;
	}


	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}


	public String getBoardTitle() {
		return boardTitle;
	}


	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}


	public String getBoardContent() {
		return boardContent;
	}


	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}


	public Timestamp getBoardModifyDt() {
		return boardModifyDt;
	}


	public void setBoardModifyDt(Timestamp boardModifyDt) {
		this.boardModifyDt = boardModifyDt;
	}


	public int getMemberNo() {
		return memberNo;
	}


	public void setMemberNo(int memberNo) {
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
