package com.kh.kkiri.profile.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.profile.model.dao.ProfileDAO;

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
	public Member selectMember(int no) throws Exception {
		return profileDAO.selectMember(no);
	}
}
