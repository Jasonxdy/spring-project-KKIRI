package com.kh.kkiri.member.model.service;

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

	





	
	
}
