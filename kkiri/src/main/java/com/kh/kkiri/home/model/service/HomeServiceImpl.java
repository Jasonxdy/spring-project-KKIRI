package com.kh.kkiri.home.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.kkiri.event.model.vo.Event;
import com.kh.kkiri.home.model.dao.HomeDAO;
import com.kh.kkiri.member.model.vo.Member;

@Service
public class HomeServiceImpl implements HomeService {
	
	@Autowired
	private HomeDAO homeDAO;
	
	/**
	 * 전체 회원 수 조회용 service
	 * @return memberCount
	 * @throws Exception
	 */
	@Override
	public int selectMemberCount() throws Exception {
		return homeDAO.selectMemberCount();
	}
	
	
	/**
	 * 메인 화면 한주간 높은 평점 회원 리스트
	 * @param memberCount 
	 * @return list : List<Member>
	 * @throws Exception
	 */
	@Override
	public List<Member> selectMemberList(int memberCount) throws Exception {
		return homeDAO.selectMemberList(memberCount);
	}

	/** 추천 이벤트 5개 뽑아오기
	 * @return eventList
	 * @throws Exception
	 */
	@Override
	public List<Event> recommandEvent() throws Exception {
		return homeDAO.recommandEvent();
	}

}
