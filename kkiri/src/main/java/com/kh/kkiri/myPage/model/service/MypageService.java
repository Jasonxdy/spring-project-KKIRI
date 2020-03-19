package com.kh.kkiri.myPage.model.service;

import org.springframework.web.multipart.MultipartFile;

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

	/**
	 * @param loginMember
	 * @return result
	 * @throws Exception
	 */
	int deleteMember(Member loginMember)throws Exception;

	/** 마이페이지 정보 수정을 위한 Service
	 * @param loginMember
	 * @param member
	 * @param profile
	 * @return result 
	 * @throws Exception
	 */
	int updateMember(Member loginMember, Member member, MultipartFile profile, String savepath)throws Exception;

	
}
