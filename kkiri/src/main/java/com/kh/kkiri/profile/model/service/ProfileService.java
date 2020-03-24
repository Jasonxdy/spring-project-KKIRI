package com.kh.kkiri.profile.model.service;

import org.springframework.stereotype.Service;

import com.kh.kkiri.member.model.vo.Member;

@Service
public interface ProfileService {

	/** 회원 프로필 조회용 Service
	 * @param no
	 * @return member
	 * @throws Exception
	 */
	public abstract Member selectMember(int no) throws Exception;
	
}
