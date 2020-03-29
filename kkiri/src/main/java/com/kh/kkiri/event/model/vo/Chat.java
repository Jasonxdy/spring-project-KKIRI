package com.kh.kkiri.event.model.vo;

public class Chat {
	private int chatNo;
	private int eventNo;
	private String chatContent;
	
	public Chat(){}

	public Chat(int chatNo, int eventNo, String chatContent) {
		super();
		this.chatNo = chatNo;
		this.eventNo = eventNo;
		this.chatContent = chatContent;
	}

	public Chat(int eventNo, String chatContent) {
		super();
		this.eventNo = eventNo;
		this.chatContent = chatContent;
	}

	public int getChatNo() {
		return chatNo;
	}

	public void setChatNo(int chatNo) {
		this.chatNo = chatNo;
	}

	public int getEventNo() {
		return eventNo;
	}

	public void setEventNo(int eventNo) {
		this.eventNo = eventNo;
	}

	public String getChatContent() {
		return chatContent;
	}

	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}

	@Override
	public String toString() {
		return "Chat [chatNo=" + chatNo + ", eventNo=" + eventNo + ", chatContent=" + chatContent + "]";
	}
	
	
}
