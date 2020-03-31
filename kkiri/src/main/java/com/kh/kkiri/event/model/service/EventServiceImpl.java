package com.kh.kkiri.event.model.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.kkiri.common.FileRename;
import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.event.model.dao.EventDAO;
import com.kh.kkiri.event.model.vo.BoardAndImage;
import com.kh.kkiri.event.model.vo.Chat;
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
		
		// 1. 이벤트 참여 구성원 가져오기 (참여자, 대기자)
		List<Party> partyList = eventDAO.selectFinalPartyList(event.getEventNo());
		
		// 실제 참여자 list
		List<Party> finalPartyList = new ArrayList<Party>();
		
		// 대기자 list
		List<Party> waitPartyList = new ArrayList<Party>();
		
		for (Party party : partyList) {
			if(party.getPermission().equals("Y")) { // 마지막 참여자인 경우
				finalPartyList.add(party);
			} else {
				waitPartyList.add(party);
			}
		}
		
		if(!partyList.isEmpty() && partyList !=null) {
			
			int eventOriginTicket = event.getEventTicket(); // 원래 티켓 장수 저장
			
			// 주최자 티켓 증가
			// 티켓 수 추가 (참가자 수 - 1 (주최자 자신이므로)) * 이벤트 티켓 장수
			event.setEventTicket((finalPartyList.size()-1) * eventOriginTicket);
			result = eventDAO.increaseTicket(event);
			
			if(result>0) {
				// 2. 주최자 결제내역 추가
				result = eventDAO.insertPaymentEarn(event);

				if(result > 0) {
					event.setEventTicket(-eventOriginTicket); // 원래 이벤트 티켓 수로 돌림
					// 3. 참가자 결제내역 추가
					for (Party party : finalPartyList) {
						if(party.getMemberType().equals("P")) { // 참가자인 경우에만 추가
							event.setMemberNo(party.getMemberNo()); // 참가자 아이디 설정
							result = 0; // 재활용용 result
							result = eventDAO.insertPaymentUse(event);
							
							if(result == 0) {
								throw new Exception(); // rollback 유도
							}
						}
					}
					
					// 4. 대기자 티켓 환불
					for (Party party : waitPartyList) { 
						event.setMemberNo(party.getMemberNo()); // 대기자 아이디 설정 
						event.setEventTicket(eventOriginTicket); // 원래 티켓수로 돌림
						result = 0;
						result = eventDAO.increaseTicket(event);
						if(result == 0) {
							throw new Exception(); // rollback 유도
						}
					}
					
					// 전체 완료된 경우 -> eventConfirm
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
	
	
	
	/**
	 * 이벤트 사진 목록 개수 조회 service 
	 * @param eventNo
	 * @return imageListCount
	 * @throws Exception
	 */
	@Override
	public int getImageListCount(int eventNo) throws Exception {
		return eventDAO.getImageListCount(eventNo);
	}
	
	
	
	/**
	 * 사진 목록 조회
	 * @param eventNo
	 * @param pInf
	 * @return imageList
	 * @throws Exception
	 */
	@Override
	public List<BoardAndImage> selectImageList(int eventNo, PageInfo pInf) throws Exception {
		return eventDAO.selectImageList(eventNo, pInf);
	}
	
	
	/**
	 * 사진 수정 service
	 * @param boardAndImage
	 * @param image 
	 * @return result
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateBoard(BoardAndImage boardAndImage, MultipartFile image, String savePath) throws Exception {
		
		int result = 0;
		
		// 사진이 수정된 경우
		if (!image.getOriginalFilename().equals("")) {
			
			// rename 처리
			String imgChangeName = FileRename.rename(image.getOriginalFilename());
			
			boardAndImage.setImgChangeName(imgChangeName);
			boardAndImage.setImgOriginalName(image.getOriginalFilename());
			
			// IMAGE 테이블 UPDATE
			result = eventDAO.updateImage(boardAndImage);
			
			if(result > 0) {
				
				// 새로 생긴 파일 저장
				image.transferTo(new File(savePath + "/" + imgChangeName));
				
				result = eventDAO.updateBoard(boardAndImage);
			}
		} else {
			result = eventDAO.updateBoard(boardAndImage);
		}
		
		
		return result;
		
	}
	
	
	
	/**
	 * 사진 등록 service
	 * @param boardAndImage
	 * @param image
	 * @param savePath
	 * @return result
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertBoard(BoardAndImage boardAndImage, MultipartFile image, String savePath) throws Exception {
		
		// 1.IMAGE 테이블에 값 추가
		
		// 원래 이름 추가
		boardAndImage.setImgOriginalName(image.getOriginalFilename());
		
		// 변경된 이름 추가
		String imgChangeName = FileRename.rename(image.getOriginalFilename());
		boardAndImage.setImgChangeName(imgChangeName);
		
		int imgNo = eventDAO.selectImageNo();
		boardAndImage.setImgNo(imgNo);
		
		int result = eventDAO.insertEventImage(boardAndImage);
		
		// result > 0 일때 BOARD에 값 추가
		if(result>0) {
			result = eventDAO.insertBoard(boardAndImage);
			if(result > 0) {
				// board에 추가한 다음 파일 생성
				// 새로 생긴 파일 저장
				image.transferTo(new File(savePath + "/" + imgChangeName));
			}
		}
		
		return result;
		
	}
	
	/**
	 * 후기 사진 삭제 service
	 * @param boardAndImage
	 * @return result
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deletePicture(BoardAndImage boardAndImage) throws Exception {
		
		// 1. 이미지 상태 변경
		int result = eventDAO.deleteImage(boardAndImage);
		
		// 2. 게시글 상태 변경
		if(result > 0) {
			result = eventDAO.deleteBoard(boardAndImage);
		}
		return result;
	}
	
	
	/**
	 * 주최자인 경우 참가 신청 목록 조회 
	 * @param eventNo
	 * @return eventParty
	 * @throws Exception
	 */
	@Override
	public List<Member> selectEventParty(int eventNo) throws Exception {
		return eventDAO.selectEventParty(eventNo);
	}
	
	/**
	 * 주최자 참여 승인 service
	 * @param party
	 * @return result
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int approveJoinEvent(Party party) throws Exception {
		return eventDAO.approveJoinEvent(party);
	}
	
	/**
	 * 주최자  참여 거절 service
	 * @param event
	 * @return
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int rejectJoinEvent(Event event) throws Exception {
		
		int result = 0;
		
		// member 티켓 회수
		result = eventDAO.increaseTicket(event);
		
		// permission 변경
		if(result>0) {
			result = eventDAO.rejectJoinEvent(event);
		}
		
		return result;
	}
	
	
	/**
	 * 로그인 회원 티켓 수 조회
	 * @param memberNo
	 * @return result
	 * @throws Exception
	 */
	@Override
	public int getMemberTicket(int memberNo) throws Exception {
		return eventDAO.getMemberTicket(memberNo);
	}

	
	/** 채팅 저장용 Service
	 * @param chat
	 * @return
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertChat(Chat chat) {
		int chatNo = eventDAO.selectChatNo();
		
		chat.setChatNo(chatNo);
		
		chat.setChatContent(chat.getChatContent()+","+chatNo);
		
		eventDAO.insertChat(chat);
		
		return chatNo;
	}

	/** 채팅 출력용 Service
	 * @param eventNo
	 * @return chatList
	 */
	@Override
	public List<Chat> selectChat(int eventNo) {
		return eventDAO.selectChat(eventNo);
	}
	
	/** 채팅 삭제용 Service
	 * @param chatNo
	 * @return result
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteChat(int chatNo) {
		return eventDAO.deleteChat(chatNo);
	}

	/**  이벤트 수정(서진웅) service
	 * @param event
	 * @param image
	 * @param savePath
	 * @param thumbnailImg
	 * @return result
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateEvent(Event event, Image image, String savePath, MultipartFile thumbnailImg) throws Exception {
		return 0;
	}
}
