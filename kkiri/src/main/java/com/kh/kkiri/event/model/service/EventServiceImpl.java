package com.kh.kkiri.event.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.kkiri.common.vo.PageInfo;
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
	
	/** 관리자: 이벤트 수 조회 Service
	 * @param map
	 * @return eventCount
	 * @throws Exception
	 */
	@Override
	public int adminEventCount(Map<String, String> map) throws Exception {
		return eventDAO.adminEventCount(map);
	}
	
	/** 관리자: 이벤트 목록 조회 Service
	 * @param map
	 * @param pInf
	 * @return eList
	 * @throws Exception
	 */
	@Override
	public List<Member> adminSelectEvent(Map<String, String> map, PageInfo pInf) throws Exception {
		return eventDAO.adminSelectEvent(map, pInf);
	}
	
	
	
	/**
	 * 참가회원 목록 처음 조회 Service
	 * @param eventNo
	 * @return partyList
	 * @throws Exception
	 */
	@Override
	public List<Member> selectInitPartyList(int eventNo) throws Exception {
		return eventDAO.selectInitPartyList(eventNo);
	}
	
	
	
	/**
	 * 참가회원 목록 추가 조회 Service
	 * @param count
	 * @param eventNo
	 * @return partyList
	 */
	@Override
	public List<Member> selectAddPartyList(int count, int limit, int eventNo) {
		return eventDAO.selectAddPartyList(count, limit, eventNo);
	}

}
