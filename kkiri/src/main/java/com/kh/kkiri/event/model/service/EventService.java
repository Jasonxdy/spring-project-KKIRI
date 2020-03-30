package com.kh.kkiri.event.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.event.model.vo.BoardAndImage;
import com.kh.kkiri.event.model.vo.Event;
import com.kh.kkiri.event.model.vo.Party;
import com.kh.kkiri.event.model.vo.Rating;
import com.kh.kkiri.event.model.vo.Report;
import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.event.model.vo.Image;

public interface EventService {

	/**
	 * 이벤트 상세 조회
	 * @param eventNo
	 * @return event
	 * @throws Exception
	 */
	Event selectEvent(int eventNo) throws Exception;

	/**
	 * 이벤트 참석자 조회
	 * @param eventNo
	 * @return partyList
	 * @throws Exception
	 */
	List<Member> selectPartyList(int eventNo) throws Exception;

	/** 관리자: 이벤트 수 조회 Service
	 * @param map
	 * @return eventCount
	 * @throws Exception
	 */
	int adminEventCount(Map<String, String> map) throws Exception;

	/** 관리자: 이벤트 목록 조회 Service
	 * @param map
	 * @param pInf
	 * @return eList
	 * @throws Exception
	 */
	List<Member> adminSelectEvent(Map<String, String> map, PageInfo pInf) throws Exception;

	
	
	/**
	 * 참가회원 목록 처음 조회 Service
	 * @param eventNo
	 * @return partyList
	 * @throws Exception
	 */
	List<Member> selectInitPartyList(int eventNo) throws Exception;

	/**
	 * 참가회원 목록 추가 조회 Service
	 * @param count
	 * @param eventNo
	 * @param eventNo2 
	 * @return partyList
	 */
	List<Member> selectAddPartyList(int count, int limit, int eventNo);

	
	/**
	 * 로그인된 회원이 참석한 이벤트 목록 조회
	 * @param memberNo
	 * @return myEventList
	 * @throws Exception
	 */
	List<Party> selectMyEventList(int memberNo) throws Exception;

	/**
	 * 이벤트 참가 service
	 * @param event
	 * @return result
	 * @throws Exception
	 */
	int joinEvent(Event event) throws Exception;

	/**
	 * 이벤트 승인 대기중 취소
	 * @param event
	 * @return result
	 */
	int cancelEvent(Event event) throws Exception;

	
	/**
	 * 신고 등록
	 * @param report
	 * @return result
	 * @throws Exception
	 */
	int insertReport(Report report) throws Exception;



	
	
	/** 이벤트 생성용 Service
	 * @param event
	 * @param image
	 * @return result
	 * @throws Exception
	 */
	int createEvent(Event event, Image image) throws Exception;

	/**
	 * 이벤트 완료 확인 service
	 * @param event
	 * @return result
	 * @throws Exception
	 */
	int confirmEventComplete(Event event) throws Exception;

	
	/**
	 * 후기 목록 조회용 service
	 * @param eventNo
	 * @param pInf 
	 * @return ratingList
	 * @throws Exception
	 */
	List<Rating> selectRatingList(int eventNo, PageInfo pInf) throws Exception;

	/**
	 * 전체 후기 수 조회용 service
	 * @param eventNo
	 * @return listCount
	 * @throws Exception
	 */
	int getListCount(int eventNo) throws Exception;

	/**
	 * 내가 작성한 후기 가져오기
	 * @param party
	 * @return myRating
	 * @throws Exception
	 */
	Rating selectMyRating(Party party) throws Exception;

	
	/**
	 * 이벤트 후기 등록 service
	 * @param rating
	 * @return result
	 * @throws Exception
	 */
	int insertRating(Rating rating) throws Exception;

	
	
	/**
	 * 이벤트 후기 수정 service
	 * @param rating
	 * @return result
	 * @throws Exception
	 */
	int updateRating(Rating rating) throws Exception;

	
	
	/**
	 * 이벤트 후기 삭제 service
	 * @param ratingNo
	 * @return result
	 * @throws Exception
	 */
	int deleteRating(int ratingNo) throws Exception;

	
	
	
	/**
	 * 이벤트 사진 목록 개수 조회 service 
	 * @param eventNo
	 * @return imageListCount
	 * @throws Exception
	 */
	int getImageListCount(int eventNo) throws Exception;

	
	
	
	/**
	 * 사진 목록 조회
	 * @param eventNo
	 * @param pInf
	 * @return imageList
	 * @throws Exception
	 */
	List<BoardAndImage> selectImageList(int eventNo, PageInfo pInf) throws Exception;

	
	
	/**
	 * 사진 수정 service
	 * @param boardAndImage
	 * @param image 
	 * @param savePath 
	 * @return result
	 * @throws Exception
	 */
	int updateBoard(BoardAndImage boardAndImage, MultipartFile image, String savePath) throws Exception;

	
	
	/**
	 * 사진 등록 service
	 * @param boardAndImage
	 * @param image
	 * @param savePath
	 * @return result
	 * @throws Exception
	 */
	int insertBoard(BoardAndImage boardAndImage, MultipartFile image, String savePath) throws Exception;

	
	
	
	/**
	 * 후기 사진 삭제 service
	 * @param boardAndImage
	 * @return result
	 * @throws Exception
	 */
	int deletePicture(BoardAndImage boardAndImage) throws Exception;
}
