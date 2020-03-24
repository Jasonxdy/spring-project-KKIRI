package com.kh.kkiri.profile.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.profile.model.dao.ProfileDAO;
import com.kh.kkiri.search.model.vo.Search;

@Service("profileService")
public class ProfileServiceImpl implements ProfileService {
	
	@Autowired
	private ProfileDAO profileDAO;

	/** 회원 프로필 조회용 Service
	 * @param no
	 * @return member
	 * @throws Exception
	 */
	@Override
	public Member selectMember(int memberNo) throws Exception {
		return profileDAO.selectMember(memberNo);
	}

	/** 프로필 생성한 이벤트 조회용 Service
	 * @param memberNo
	 * @return cList
	 */
	@Override
	public List<Search> selectCreateEvent(Integer memberNo, int currentPage, int limit) {
		return profileDAO.selectCreateEvent(memberNo, currentPage, limit);
	}

	/** 생성한 이벤트 개수 조회용 Service
	 * @param memberNo
	 * @return cListCount
	 * @throws Exception
	 */
	@Override
	public int cListCount(int memberNo) throws Exception {
		return profileDAO.cListCount(memberNo);
	}

	/** 참여한 이벤트 개수 조회용 Service
	 * @param memberNo
	 * @return jListCount
	 * @throws Exception
	 */
	@Override
	public int jListCount(int memberNo) throws Exception {
		return profileDAO.jListCount(memberNo);
	}
}
