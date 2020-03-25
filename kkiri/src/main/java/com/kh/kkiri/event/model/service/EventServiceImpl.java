package com.kh.kkiri.event.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.event.model.dao.EventDAO;
import com.kh.kkiri.event.model.vo.Event;
import com.kh.kkiri.event.model.vo.Image;
import com.kh.kkiri.event.model.vo.Party;
import com.kh.kkiri.event.model.vo.Report;
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
	
	
	/**
	 * 로그인된 회원이 참석한 이벤트 목록 조회
	 * @param memberNo
	 * @return myEventList
	 * @throws Exception
	 */
	@Override
	public List<Party> selectMyEventList(int memberNo) throws Exception {
		return eventDAO.selectMyEventList(memberNo);
	}
	
	/**
	 * 이벤트 참가 service
	 * @param party
	 * @return result
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int joinEvent(Party party) throws Exception {
		return eventDAO.joinEvent(party);
	}
	
	
	/**
	 * 이벤트 참가 취소
	 * @param party
	 * @return result
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int cancelEvent(Party party) throws Exception {
		return eventDAO.cancelEvent(party);
	}
	
	/**
	 * 이벤트 참가 취소 서비스
	 * @param party
	 * @return result
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int cancelJoinEvent(Party party, int eventTicket) throws Exception {
		
		// party 테이블에서 삭제
		int result = eventDAO.cancelEvent(party);
		if(result > 0) {
			// 티켓 회수
			int memberNo = party.getMemberNo();
			result = eventDAO.increaseTicket(memberNo, eventTicket);
			// 결제 내역
		}
		
		return result;
	}
	
	
	/**
	 * 신고 등록
	 * @param report
	 * @return result
	 * @throws Exception
	 */
	@Override
	public int insertReport(Report report) throws Exception {
		return eventDAO.insertReport(report);
	}

	
	/** 이벤트 생성용 Service
	 * @param event
	 * @param image
	 * @return result
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int createEvent(Event event, Image image) throws Exception {
		int result = 0;
		
		// 다음 이벤트 번호 얻어오기
		int eventNo = eventDAO.selectNextNo();
		
		// 이벤트 게시글 삽입
		if(eventNo>0) {
			event.setEventContent(event.getEventContent().replace("\r\n", "<br>"));
			
			// 조회한 eventNo을 event에 세팅
			event.setEventNo(eventNo);
			
			// 이벤트 게시글을 DB에 등록
			result = eventDAO.createEvent(event);
			
			if(result>0) { // PARTY 테이블에 데이터 추가
				result = 0;
				
				result = eventDAO.insertParty(event);
			}
		}
		
		if(result > 0 && image!=null) { // 이벤트 썸네일(image) 삽입 
			result = 0;
			
			image.setEventNo(eventNo);
			result = eventDAO.insertImage(image);
			if(result==0) {
				throw new Exception();
			}
		}
		
		if(result>0) {
			// result에 생성된 이벤트 번호 저장
			result = eventNo;
		}
		return result;
	}

}
