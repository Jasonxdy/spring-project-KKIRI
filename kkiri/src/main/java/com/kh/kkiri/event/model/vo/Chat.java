package com.kh.kkiri.event.model.vo;

public class Chat {
	private int eventNo;
	private String chatContent;
	
	public Chat (){}

	public Chat(int eventNo, String chatContent) {
		super();
		this.eventNo = eventNo;
		this.chatContent = chatContent;
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
		return "Chat [eventNo=" + eventNo + ", chatContent=" + chatContent + "]";
	}
	
}
