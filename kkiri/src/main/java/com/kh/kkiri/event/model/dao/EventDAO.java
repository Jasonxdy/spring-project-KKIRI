package com.kh.kkiri.event.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
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
	 * 이벤트 참석자 조회
	 * @param eventNo
	 * @return partyList
	 * @throws Exception
	 */
	public List<Member> selectPartyList(int eventNo) throws Exception{
		int offset = 0;
		int limit = 11;
		RowBounds rbound = new RowBounds(offset, limit);
		return sqlSession.selectList("eventMapper.selectPartyList", eventNo, rbound);
	}


	/** 관리자: 이벤트 수 조회 DAO
	 * @param map
	 * @return eventCount
	 * @throws Exception
	 */
	public int adminEventCount(Map<String, String> map) throws Exception {
		return sqlSession.selectOne("eventMapper.adminEventCount", map);
	}



}
