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

	/** 이벤트 수 조회용 Service
	 * @param memberNo
	 * @param flag
	 * @return listCount
	 */
	@Override
	public int listCount(int memberNo, int flag) {
		return profileDAO.listCount(memberNo, flag);
	}

	/** 이벤트 조회용 Service
	 * @param memberNo
	 * @param currentPage
	 * @param limit
	 * @param flag
	 * @return eList
	 */
	@Override
	public List<Search> selectEventList(int memberNo, int currentPage, int limit, Integer flag) {
		return profileDAO.selectEventList(memberNo, currentPage, limit, flag);
	}
}
