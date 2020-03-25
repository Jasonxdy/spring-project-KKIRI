package com.kh.kkiri.home.model.service;

import java.util.List;

import com.kh.kkiri.event.model.vo.Event;
import com.kh.kkiri.member.model.vo.Member;

public interface HomeService {

	
	
	/**
	 * 전체 회원 수 조회용 service
	 * @return memberCount
	 * @throws Exception
	 */
	int selectMemberCount() throws Exception;
	
	
	
	/**
	 * 메인 화면 한주간 높은 평점 회원 리스트
	 * @param memberCount 
	 * @return list : List<Member>
	 * @throws Exception
	 */
	List<Member> selectMemberList(int memberCount) throws Exception;



	/** 추천 이벤트 5개 뽑아오기
	 * @return eventList
	 * @throws Exception
	 */
	List<Event> recommandEvent() throws Exception;


}
