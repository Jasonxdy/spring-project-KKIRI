package com.kh.kkiri.event.model.service;

import com.kh.kkiri.event.model.vo.Event;
import com.kh.kkiri.member.model.vo.Member;

public interface EventService {

	/**
	 * 이벤트 상세 조회
	 * @param eventNo
	 * @return event
	 * @throws Exception
	 */
	Event selectEvent(int eventNo) throws Exception;

	/**
	 * 이벤트 주최자 정보 조회
	 * @param eventNo
	 * @return member
	 * @throws Exception
	 */
	Member selectMember(int eventNo) throws Exception;
	
	
	
}
