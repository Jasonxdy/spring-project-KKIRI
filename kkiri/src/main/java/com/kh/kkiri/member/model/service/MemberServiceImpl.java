package com.kh.kkiri.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.kkiri.member.model.dao.MemberDAO;
import com.kh.kkiri.member.model.vo.Member;

@Service

public class MemberServiceImpl implements MemberService{

	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired 
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	// 암호화 준비
	
	
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
	
	
	
	/** 회원가입(ID 만들기) Service
	 * @param createMember
	 * @return return
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int createId(Member createMember) throws Exception {
		
		System.out.println("2. 가입 회원정보:" + createMember);
		
		int result = memberDAO.createId(createMember);
		
		System.out.println("4. 가입 결과 result:" + result);
		return result;
	}
	
	/** google 계정 가입 여부 체크 Service
	 * @param memberId
	 * @return signUpCheck
	 * @throws Exception
	 */
	@Override
	public Member checkGoogleId(String memberId) throws Exception {
		return memberDAO.checkGoogleId(memberId);
	}
	
	/** google 계정으로 가입 Service
	 * @param googleMember
	 * @return signUpResult
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int googleSignUp(Member googleMember) throws Exception {
		return memberDAO.googleSignUp(googleMember);
	}
	
}
