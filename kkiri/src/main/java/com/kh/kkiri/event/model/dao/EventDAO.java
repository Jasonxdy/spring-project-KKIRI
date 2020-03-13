package com.kh.kkiri.event.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.kkiri.event.model.vo.Event;
import com.kh.kkiri.member.model.vo.Member;

@Repository
public class EventDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	
	/**
	 * 이벤트 상세조회 DAO
	 * @param eventNo
	 * @return
	 * @throws Exception
	 */
	public Event selectEvent(int eventNo) throws Exception {
		return sqlSession.selectOne("eventMapper.selectEvent", eventNo);
	}


	/**
	 * 이벤트 주최자 정보 조회 dao
	 * @param eventNo
	 * @return member
	 * @throws Exception
	 */
	public Member selectMember(int eventNo) throws Exception{
		return sqlSession.selectOne("eventMapper.selectMember", eventNo);
	}

}
