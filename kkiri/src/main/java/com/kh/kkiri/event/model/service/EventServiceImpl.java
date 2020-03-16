package com.kh.kkiri.event.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.kkiri.event.model.dao.EventDAO;
import com.kh.kkiri.event.model.vo.Event;
import com.kh.kkiri.member.model.vo.Member;

@Service
public class EventServiceImpl implements EventService {
	
	@Autowired
	private EventDAO eventDAO;
	
	/**
	 * 이벤트 상세 조회 Service
	 * @param eventNo
	 * @return event
	 * @throws Exception
	 */
	@Override
	public Event selectEvent(int eventNo) throws Exception {
		return eventDAO.selectEvent(eventNo);
	}
	
	/**
	 * 이벤트 참석자 조회
	 * @param eventNo
	 * @return partyList
	 * @throws Exception
	 */
	@Override
	public List<Member> selectPartyList(int eventNo) throws Exception {
		return eventDAO.selectPartyList(eventNo);
	}
	

}
