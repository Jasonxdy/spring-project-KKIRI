package com.kh.kkiri.admin.model.vo;

import java.sql.Date;

public class EventStatistic {
	private Date eventDate;
	private int eventCount;
	
	public EventStatistic() {
		// TODO Auto-generated constructor stub
	}

	public EventStatistic(Date eventDate, int eventCount) {
		super();
		this.eventDate = eventDate;
		this.eventCount = eventCount;
	}

	public Date getEventDate() {
		return eventDate;
	}

	public void setEventDate(Date eventDate) {
		this.eventDate = eventDate;
	}

	public int getEventCount() {
		return eventCount;
	}

	public void setEventCount(int eventCount) {
		this.eventCount = eventCount;
	}

	@Override
	public String toString() {
		return "EventStatistic [eventDate=" + eventDate + ", eventCount=" + eventCount + "]";
	}
	
	
}
