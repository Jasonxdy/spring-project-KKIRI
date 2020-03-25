package com.kh.kkiri.event.model.service;

import java.util.List;
import java.util.Map;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.event.model.vo.Event;
import com.kh.kkiri.event.model.vo.Party;
import com.kh.kkiri.event.model.vo.Report;
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
	 * 이벤트 참석자 조회
	 * @param eventNo
	 * @return partyList
	 * @throws Exception
	 */
	List<Member> selectPartyList(int eventNo) throws Exception;

	/** 관리자: 이벤트 수 조회 Service
	 * @param map
	 * @return eventCount
	 * @throws Exception
	 */
	int adminEventCount(Map<String, String> map) throws Exception;

	/** 관리자: 이벤트 목록 조회 Service
	 * @param map
	 * @param pInf
	 * @return eList
	 * @throws Exception
	 */
	List<Member> adminSelectEvent(Map<String, String> map, PageInfo pInf) throws Exception;

	
	
	/**
	 * 참가회원 목록 처음 조회 Service
	 * @param eventNo
	 * @return partyList
	 * @throws Exception
	 */
	List<Member> selectInitPartyList(int eventNo) throws Exception;

	/**
	 * 참가회원 목록 추가 조회 Service
	 * @param count
	 * @param eventNo
	 * @param eventNo2 
	 * @return partyList
	 */
	List<Member> selectAddPartyList(int count, int limit, int eventNo);

	
	/**
	 * 로그인된 회원이 참석한 이벤트 목록 조회
	 * @param memberNo
	 * @return myEventList
	 * @throws Exception
	 */
	List<Party> selectMyEventList(int memberNo) throws Exception;

	/**
	 * 이벤트 참가 service
	 * @param party
	 * @return result
	 * @throws Exception
	 */
	int joinEvent(Party party) throws Exception;

	/**
	 * 이벤트 승인 대기중 취소
	 * @param party
	 * @return result
	 */
	int cancelEvent(Party party) throws Exception;

	/**
	 * 이벤트 참가 취소 서비스
	 * @param party
	 * @param eventTicket 
	 * @return result
	 * @throws Exception
	 */
	int cancelJoinEvent(Party party, int eventTicket) throws Exception;
	
	
	/**
	 * 신고 등록
	 * @param report
	 * @return result
	 * @throws Exception
	 */
	int insertReport(Report report) throws Exception;



	
	
}
