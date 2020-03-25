package com.kh.kkiri.myPage.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.event.model.vo.Event;
import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.myPage.model.vo.Ticket;

/**
 * @author user1
 *
 */
@Repository
public class MypageDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public int updateAccount(Member account) throws Exception{

		return sqlSession.update("memberMapper.updateAccount", account);
	}

	public int updatePassword(Member loginMember) throws Exception{

		return sqlSession.update("memberMapper.updatePassword", loginMember);
	}

	public int deleteMember(Member loginMember) throws Exception{
		
		return sqlSession.update("memberMapper.deleteMember", loginMember);
	}

	public List<Ticket> ticketLog(Ticket ticket, PageInfo pinf)throws Exception {
		
		int OffSet  = (pinf.getCurrentPage()-1)*pinf.getLimit();
		RowBounds rowbound = new RowBounds(OffSet,pinf.getLimit());
		
		
		return sqlSession.selectList("paymentMapper.ticketLog", ticket,rowbound);
	}

	public int getListCount(Ticket ticket) throws Exception{
		return sqlSession.selectOne("paymentMapper.getListCount", ticket);
	}

	/** 환조씨가 작업중
	 * @param memberNo
	 * @return
	 * @throws Exception
	 */
	public List<Event> moveEvent(int memberNo) throws Exception{
		
		
		return sqlSession.selectList("eventMapper.get", memberNo);
	}
	
}
