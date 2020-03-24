package com.kh.kkiri.profile.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.search.model.vo.Search;

@Service
public interface ProfileService {

	/** 회원 프로필 조회용 Service
	 * @param no
	 * @return member
	 * @throws Exception
	 */
	public abstract Member selectMember(int memberNo) throws Exception;

	/** 프로필 생성한 이벤트 조회용 Service
	 * @param memberNo
	 * @return cList
	 */
	public abstract List<Search> selectCreateEvent(Integer memberNo, int currentPage, int limit);
	
}
