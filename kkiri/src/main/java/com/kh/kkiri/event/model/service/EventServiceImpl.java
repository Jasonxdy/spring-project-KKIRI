package com.kh.kkiri.event.model.service;

import java.util.HashMap;
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
import com.kh.kkiri.event.model.vo.Rating;
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
	 * @param event
	 * @return result
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int joinEvent(Event event) throws Exception {
		// party에 추가
		int result = eventDAO.joinEvent(event);
		if(result > 0) {
			// 티켓 차감
			result = eventDAO.decreaseTicket(event);
		}
		return result;
	}
	
	
	/**
	 * 이벤트 참가 취소
	 * @param event
	 * @return result
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int cancelEvent(Event event) throws Exception {
		
		int result = eventDAO.cancelEvent(event);
		if(result > 0) {
			result = eventDAO.increaseTicket(event);
		}
		return result;
	}
	
	/**
	 * 이벤트 완료 확인 service
	 * @param event
	 * @return result
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int confirmEventComplete(Event event) throws Exception {
		
		int result = 0;
		
		// 1. 이벤트 참여 구성원 가져오기
		List<Party> partyList = eventDAO.selectFinalPartyList(event.getEventNo());
		
		if(!partyList.isEmpty() && partyList !=null) {
			
			int eventOriginTicket = event.getEventTicket(); // 원래 티켓 장수 저장
			
			// 주최자 티켓 증가
			// 티켓 수 추가 (참가자 수 - 1 (주최자 자신이므로)) * 이벤트 티켓 장수
			event.setEventTicket((partyList.size()-1) * eventOriginTicket);
			result = eventDAO.increaseTicket(event);
			
			if(result>0) {
				// 2. 주최자 결제내역 추가
				result = eventDAO.insertPaymentEarn(event);

				if(result > 0) {
					event.setEventTicket(-eventOriginTicket); // 원래 이벤트 티켓 수로 돌림
					// 3. 참가자 결제내역 추가
					for (Party party : partyList) {
						if(party.getMemberType().equals("P")) { // 참가자인 경우에만 추가
							event.setMemberNo(party.getMemberNo()); // 참가자 아이디 설정
							result = 0; // 재활용용 result
							result = eventDAO.insertPaymentUse(event);
							
							if(result == 0) {
								throw new Exception(); // rollback 유도
							}
						}
					}
					if(result > 0) {
						result = eventDAO.updateEventConfirm(event.getEventNo());
					}
				}
			}
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
	
	
	
	/**
	 * 전체 후기 수 조회용 service
	 * @param eventNo
	 * @return listCount
	 * @throws Exception
	 */
	@Override
	public int getListCount(int eventNo) throws Exception {
		return eventDAO.getListCount(eventNo);
	}

	/**
	 * 후기 목록 조회용 service
	 * @param eventNo
	 * @return ratingList
	 * @throws Exception
	 */
	@Override
	public List<Rating> selectRatingList(int eventNo, PageInfo pInf) throws Exception {
		return eventDAO.selectRatingList(eventNo, pInf);
	}
	
	/**
	 * 내가 작성한 후기 가져오기
	 * @param party
	 * @return myRating
	 * @throws Exception
	 */
	@Override
	public Rating selectMyRating(Party party) throws Exception {
		return eventDAO.selectMyRating(party);
	}
	
	
	
	/**
	 * 이벤트 후기 등록 service
	 * @param rating
	 * @return result
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertRating(Rating rating) throws Exception {
		return eventDAO.insertRating(rating);
	}
	
	
	/**
	 * 이벤트 후기 수정 service
	 * @param rating
	 * @return result
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateRating(Rating rating) throws Exception {
		return eventDAO.updateRating(rating);
	}
	
	
	/**
	 * 이벤트 후기 삭제 service
	 * @param ratingNo
	 * @return result
	 * @throws Exception
	 */
	@Override
	public int deleteRating(int ratingNo) throws Exception {
		return eventDAO.deleteRating(ratingNo);
	}

}
