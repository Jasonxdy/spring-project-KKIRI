package com.kh.kkiri.myPage.model.service;

import com.kh.kkiri.member.model.vo.Member;

public interface MypageService {

	/** 계좌정보 변경을 위한 Service
	 * @param loginMember
	 * @return result
	 * @throws Exception
	 */
	int updateAccount(Member loginMember)throws Exception;

	/**
	 * @param loginMember
	 * @param changePassword
	 * @return result
	 * @throws Exception
	 */
	int updatePassword(Member loginMember, String changePassword)throws Exception;

	
}
