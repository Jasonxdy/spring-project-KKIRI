package com.kh.kkiri.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.kkiri.member.model.dao.MemberDAO;
import com.kh.kkiri.member.model.vo.Member;

@Service

public class MemberServiceImpl implements MemberService{

	
	@Autowired
	private MemberDAO memberDAO;
	
	
	/** 로그인 Service
	 * @param member
	 * @return loginMember
	 * @throws Exception
	 */
	@Override
	public Member loginMember(Member member) throws Exception {
		
		Member loginMember = memberDAO.signInMember(member);
		
		return loginMember;
	}
	
	
	
	
	
}
