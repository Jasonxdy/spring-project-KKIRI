package com.kh.kkiri.profile.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.kkiri.event.model.vo.Chat;
import com.kh.kkiri.member.model.vo.Favorite;
import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.search.model.vo.Search;

/**
 * @author 정미경
 *
 */
@Service
public interface ProfileService {

	/** 회원 프로필 조회용 Service
	 * @param no
	 * @return member
	 * @throws Exception
	 */
	public abstract Member selectMember(int memberNo) throws Exception;

	/** 이벤트 수 조회용 Service
	 * @param memberNo
	 * @param flag
	 * @return listCount
	 */
	public abstract int listCount(int memberNo, int flag);

	/** 이벤트 조회용 Service
	 * @param memberNo
	 * @param currentPage
	 * @param limit
	 * @param flag
	 * @return eList
	 */
	public abstract List<Search> selectEventList(int memberNo, int currentPage, int limit, Integer flag);

	/** 좋아요 기능 Service
	 * @param memberNo
	 * @param favoriteNo
	 * @return result
	 */
	public abstract int theLove(Favorite favorite);

	/** 좋아요 체크용 Service
	 * @param favorite
	 * @return result
	 * @throws Exception
	 */
	public abstract int checkFavorite(Favorite favorite) throws Exception;


	/** 채팅 저장용 Service
	 * @param chat
	 * @return
	 */
	public abstract int insertChat(Chat chat);

	
	/** 채팅 출력용 Service
	 * @param eventNo
	 * @return chatList
	 */
	public abstract List<Chat> selectChat(int eventNo);
	
}
