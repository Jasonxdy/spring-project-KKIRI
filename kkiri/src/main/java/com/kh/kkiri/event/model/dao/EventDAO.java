package com.kh.kkiri.event.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.event.model.vo.Event;
import com.kh.kkiri.event.model.vo.Party;
import com.kh.kkiri.event.model.vo.Report;
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


	public List<Member> adminSelectEvent(Map<String, String> map, PageInfo pInf) {
		int offset = (pInf.getCurrentPage() - 1) * pInf.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pInf.getLimit());
		return sqlSession.selectList("eventMapper.adminSelectEvent", map, rowBounds);
	}


	
	/**
	 * 참가회원 목록 처음 조회 DAO
	 * @param eventNo
	 * @return partyList
	 * @throws Exception
	 */
	public List<Member> selectInitPartyList(int eventNo) throws Exception{
		int offset = 0;
		int limit = 4;
		RowBounds rbound = new RowBounds(offset, limit);
		return sqlSession.selectList("eventMapper.selectPartyList", eventNo, rbound);
	}


	/**
	 * 참가회원 목록 추가 조회 DAO
	 * @param count
	 * @param eventNo
	 * @param limit 
	 * @return partyList
	 */
	public List<Member> selectAddPartyList(int count, int limit, int eventNo) {
		int offset = count*limit + 4;
		RowBounds rbound = new RowBounds(offset, limit);
		return sqlSession.selectList("eventMapper.selectPartyList", eventNo, rbound);
	}


	public List<Party> selectMyEventList(int memberNo) throws Exception{
		return sqlSession.selectList("eventMapper.selectMyEventList", memberNo);
	}


	/**
	 * 이벤트 참가 DAO
	 * @param party
	 * @return result
	 * @throws Exception
	 */
	public int joinEvent(Party party) throws Exception{
		return sqlSession.insert("eventMapper.joinEvent", party);
	}


	/**
	 * 이벤트 승인 대기 취소 DAO
	 * @param party
	 * @return result
	 * @throws Exception
	 */
	public int cancelEvent(Party party) throws Exception {
		return sqlSession.delete("eventMapper.cancelEvent", party);
	}
	
	/**
	 * 신고 등록용 DAO
	 * @param report
	 * @return result
	 * @throws Exception
	 */
	public int insertReport(Report report) throws Exception{
		return sqlSession.insert("eventMapper.insertReport", report);
	}


	/**
	 * 
	 * @param eventTicket 
	 * @param memberNo 
	 * @return
	 * @throws Exception
	 */
	public int increaseTicket(int memberNo, int eventTicket) throws Exception{
		return sqlSession.update("eventMapper.increaseTicket", parameter);
	}


	



}
