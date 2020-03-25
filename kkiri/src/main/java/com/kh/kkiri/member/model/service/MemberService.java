package com.kh.kkiri.member.model.service;

import java.util.List;


import com.kh.kkiri.member.model.vo.Member;

public interface MemberService {

	
	/** 로그인 Service
	 * @param member
	 * @return member
	 * @throws Exception
	 */
	Member loginMember(Member member)throws Exception;

	
	
	/** 회원가입(ID 만들기) Service
	 * @param createMember
	 * @return return
	 * @throws Exception
	 */
	int createId(Member createMember)throws Exception;


	
	/** 아이디 중복 체크 Service
	 * @param memberId
	 * @return result
	 * @throws Exception
	 */
	int idUniqueCheck(String memberId)throws Exception;
	
	

	/** social 계정 가입 여부 체크 Service
	 * @param memberId
	 * @return signUpCheck
	 * @throws Exception
	 */
	Member checkSocialId(String memberId) throws Exception;



	/** social 계정으로 가입 Service
	 * @param googleMember
	 * @return signUpResult
	 * @throws Exception
	 */
	int socialSignUp(Member socialMember) throws Exception;



	/** social Email 중복 확인 Service
	 * @param memberEmail
	 * @return checkSocialEmail
	 * @throws Exception
	 */
	Member checkSocialEmail(String memberEmail) throws Exception;



	

	





	
	
}
