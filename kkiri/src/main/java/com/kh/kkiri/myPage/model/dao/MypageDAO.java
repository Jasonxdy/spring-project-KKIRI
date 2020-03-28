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

	/** 티켓 기록을 가지고 오는 DAO
	 * @param ticket
	 * @param pinf
	 * @return
	 * @throws Exception
	 */
	public List<Ticket> ticketLog(Ticket ticket, PageInfo pinf)throws Exception {
		
		int OffSet  = (pinf.getCurrentPage()-1)*pinf.getLimit();
		RowBounds rowbound = new RowBounds(OffSet,pinf.getLimit());
		
		
		return sqlSession.selectList("paymentMapper.ticketLog", ticket,rowbound);
	}

	public int getListCount(Ticket ticket) throws Exception{
		return sqlSession.selectOne("paymentMapper.getListCount", ticket);
	}

	/** event 리스트를 가져가는 DAO
	 * @param memberNo
	 * @param pInf 
	 * @return
	 * @throws Exception
	 */
	public List<Event> moveEvent(int memberNo, PageInfo pInf) throws Exception{
		int OffSet = (pInf.getCurrentPage()-1)*pInf.getLimit();
		RowBounds rbounds = new RowBounds(OffSet, pInf.getLimit());
		return sqlSession.selectList("eventMapper.moveEvent1", memberNo, rbounds);
	}

	public int costTicket(Ticket ticket) throws Exception{
		// TODO Auto-generated method stub
		return sqlSession.insert("paymentMapper.costTicket", ticket);
	}

	public int updateTicket(Ticket ticket) throws Exception{
		return sqlSession.update("memberMapper.updateTicket", ticket);
	}

	public Event moveEvent2(int eveNo)throws Exception {
		return sqlSession.selectOne("eventMapper.moveEvent2", eveNo);
	}

	public List<Integer> countEveNo(int memberNo, PageInfo pInf) throws Exception{
		int offSet = (pInf.getCurrentPage()-1)*pInf.getLimit();
		RowBounds rbounds = new RowBounds(offSet, pInf.getLimit());
		
		
		return sqlSession.selectList("eventMapper.countEveNo", memberNo,rbounds);
	}

	public int listEventCount(int memberNo) throws Exception{
		return sqlSession.selectOne("eventMapper.listEventCount", memberNo);
	}

	public int listEventCount2(int memberNo)throws Exception{
		return sqlSession.selectOne("eventMapper.listEventCount2", memberNo);
	}
	
}
