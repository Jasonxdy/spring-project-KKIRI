package com.kh.kkiri.event.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.event.model.vo.BoardAndImage;
import com.kh.kkiri.event.model.vo.Event;
import com.kh.kkiri.event.model.vo.Party;
import com.kh.kkiri.event.model.vo.Rating;
import com.kh.kkiri.event.model.vo.Report;
import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.event.model.vo.Image;

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

	
	/**
	 * 로그인된 회원이 참석한 이벤트 목록 조회
	 * @param memberNo
	 * @return myEventList
	 * @throws Exception
	 */
	public List<Party> selectMyEventList(int memberNo) throws Exception{
		return sqlSession.selectList("eventMapper.selectMyEventList", memberNo);
	}


	/**
	 * 이벤트 참가 DAO
	 * @param event
	 * @return result
	 * @throws Exception
	 */
	public int joinEvent(Event event) throws Exception{
		return sqlSession.insert("eventMapper.joinEvent", event);
	}


	/**
	 * 이벤트 승인 대기 취소 DAO
	 * @param event
	 * @return result
	 * @throws Exception
	 */
	public int cancelEvent(Event event) throws Exception {
		return sqlSession.delete("eventMapper.cancelEvent", event);
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

	/** 다음 이벤트글 번호 조회용 DAO
	 * @return eventNo
	 * @throws Exception
	 */
	public int selectNextNo() throws Exception{
		return sqlSession.selectOne("eventMapper.selectNextNo");
	}

	/** 이벤트 게시글을 DB에 등록용 DAO
	 * @param event
	 * @return result
	 * @throws Exception
	 */
	public int createEvent(Event event) throws Exception{
		return sqlSession.insert("eventMapper.createEvent",event);
	}


	/**
	 * 이벤트 취소에 따른 티켓 회수
	 * @param eventTicket 
	 * @param event 
	 * @return result
	 * @throws Exception
	 */
	public int increaseTicket(Event event) throws Exception{
		return sqlSession.update("eventMapper.increaseTicket", event);
	}


	

	/** 이벤트 썸네일 사진 삽입용 DAO
	 * @param image
	 * @return result
	 * @throws Exception
	 */
	public int insertImage(Image image) throws Exception{
		return sqlSession.insert("eventMapper.insertImage",image);
	}

	/** PARTY 테이블에 데이터 추가용
	 * @param event
	 * @return result
	 * @throws Exception
	 */
	public int insertParty(Event event) throws Exception{
		return sqlSession.insert("eventMapper.insertParty",event); 
	}


	/**
	 * 티켓 차감
	 * @param event
	 * @return result
	 * @throws Exception
	 */
	public int decreaseTicket(Event event) throws Exception{
		return sqlSession.update("eventMapper.decreaseTicket", event);
	}


	/**
	 * 최종 파티 구성원 list 조회
	 * @param eventNo
	 * @return partyList
	 */
	public List<Party> selectFinalPartyList(int eventNo) {
		return sqlSession.selectList("eventMapper.selectFinalPartyList", eventNo);
	}


	/**
	 * 주최자 이익 티켓 결제 내역 추가 
	 * @param event
	 * @return result
	 * @throws Exception
	 */
	public int insertPaymentEarn(Event event) throws Exception{
		return sqlSession.insert("eventMapper.insertPaymentEarn", event);
	}


	/**
	 * 참가자 티켓 사용 내역 추가
	 * @param event
	 * @return result
	 * @throws Exception
	 */
	public int insertPaymentUse(Event event) throws Exception{
		return sqlSession.insert("eventMapper.insertPaymentUse", event);
	}


	/**
	 * 이벤트 완료 후 상태 변경
	 * @param eventNo
	 * @return result
	 * @throws Exception
	 */
	public int updateEventConfirm(int eventNo) throws Exception{
		return sqlSession.update("eventMapper.updateEventConfirm", eventNo);
	}


	/**
	 * 전체 후기 수 조회 DAO
	 * @param eventNo
	 * @return listCount
	 * @throws Exception
	 */
	public int getListCount(int eventNo) throws Exception{
		return sqlSession.selectOne("eventMapper.getListCount", eventNo);
	}


	/**
	 * 후기 목록 조회 DAO
	 * @param eventNo
	 * @return ratingList
	 * @throws Exception
	 */
	public List<Rating> selectRatingList(int eventNo, PageInfo pInf) throws Exception{
		RowBounds rbounds = new RowBounds((pInf.getCurrentPage()-1)*pInf.getLimit(), pInf.getLimit());
		return sqlSession.selectList("eventMapper.selectRatingList", eventNo, rbounds);
	}


	/**
	 * 내가 작성한 후기 조회
	 * @param party
	 * @return myRating
	 * @throws Exception
	 */
	public Rating selectMyRating(Party party) throws Exception{
		return sqlSession.selectOne("eventMapper.selectMyRating", party);
	}


	
	
	/**
	 * 이벤트 후기 등록 DAO
	 * @param rating
	 * @return result
	 * @throws Exception
	 */
	public int insertRating(Rating rating) throws Exception{
		return sqlSession.insert("eventMapper.insertRating", rating);
	}


	/**
	 * 이벤트 후기 수정 service
	 * @param rating
	 * @return result
	 * @throws Exception
	 */
	public int updateRating(Rating rating) {
		return sqlSession.update("eventMapper.updateRating", rating);
	}


	/**
	 * 이벤트 후기 삭제 service
	 * @param ratingNo
	 * @return
	 * @throws Exception
	 */
	public int deleteRating(int ratingNo) throws Exception{
		return sqlSession.update("eventMapper.deleteRating", ratingNo);
	}


	
	
	/**
	 * 이벤트 사진 목록 개수 조회 dao 
	 * @param eventNo
	 * @return imageListCount
	 * @throws Exception
	 */
	public int getImageListCount(int eventNo) throws Exception{
		return sqlSession.selectOne("eventMapper.getImageListCount", eventNo);
	}



	
	/**
	 * 사진 목록 조회 dao
	 * @param eventNo
	 * @param pInf
	 * @return imageList
	 * @throws Exception
	 */
	public List<BoardAndImage> selectImageList(int eventNo, PageInfo pInf) throws Exception{
		RowBounds rowBounds = new RowBounds((pInf.getCurrentPage()-1) * pInf.getLimit(), pInf.getLimit());
		return sqlSession.selectList("eventMapper.selectImageList", eventNo, rowBounds);
	}


	
	
	/**
	 * 사진 수정 dao
	 * @param boardAndImage
	 * @return result
	 * @throws Exception
	 */
	public int updateImage(BoardAndImage boardAndImage) throws Exception{
		return sqlSession.update("eventMapper.updateImage", boardAndImage);
	}


	
	/**
	 * 사진에 대한 게시글 수정 dao
	 * @param boardAndImage
	 * @return result
	 * @throws Exception
	 */
	public int updateBoard(BoardAndImage boardAndImage) throws Exception{
		return sqlSession.update("eventMapper.updateBoard", boardAndImage);
	}


	
	
	/**
	 * 사진 등록용 dao
	 * @param boardAndImage
	 * @return result
	 * @throws Exception
	 */
	public int insertEventImage(BoardAndImage boardAndImage) throws Exception{
		return sqlSession.insert("eventMapper.insertEventImage", boardAndImage);
	}


	
	
	/**
	 * 게시글 등록용 dao
	 * @param boardAndImage
	 * @return result
	 * @throws Exception
	 */
	public int insertBoard(BoardAndImage boardAndImage) throws Exception{
		return sqlSession.insert("eventMapper.insertBoard", boardAndImage);
	}


	/**
	 * 이미지 번호 조회용 dao
	 * @return imgNo
	 * @throws Exception
	 */
	public int selectImageNo() throws Exception{
		return sqlSession.selectOne("eventMapper.selectImageNo");
	}


	/**
	 * 이미지 삭제 dao
	 * @param boardAndImage
	 * @return result
	 * @throws Exception
	 */
	public int deleteImage(BoardAndImage boardAndImage) throws Exception{
		return sqlSession.update("eventMapper.deleteImage", boardAndImage);
	}


	
	/**
	 * 게시글 삭제
	 * @param boardAndImage
	 * @return result
	 * @throws Exception
	 */
	public int deleteBoard(BoardAndImage boardAndImage) throws Exception{
		return sqlSession.update("eventMapper.deleteBoard", boardAndImage);
	}


	
	
	/**
	 * 주최자인 경우 참가 신청 회원 목록 조회
	 * @param eventNo
	 * @return eventParty
	 * @throws Exception
	 */
	public List<Member> selectEventParty(int eventNo) throws Exception{
		return sqlSession.selectList("eventMapper.selectEventParty", eventNo);
	}


	/**
	 * 주최자 승인 dao
	 * @param party
	 * @return result
	 * @throws Exception
	 */
	public int approveJoinEvent(Party party) throws Exception{
		return sqlSession.update("eventMapper.approveJoinEvent", party);
	}


	
	
	/**
	 * 주최자 거절 dao
	 * @param event
	 * @return result
	 * @throws Exception
	 */
	public int rejectJoinEvent(Event event) throws Exception{
		return sqlSession.update("eventMapper.rejectJoinEvent", event);
	}




}
