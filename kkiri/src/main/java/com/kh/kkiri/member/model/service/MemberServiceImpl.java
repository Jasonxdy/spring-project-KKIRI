package com.kh.kkiri.member.model.service;

import java.util.List;

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
		
		if( !bCryptPasswordEncoder.matches(member.getMemberPwd(), 
				loginMember.getMemberPwd()) ) {
			// 비번이 일치하지 않는다면?? 
			
			loginMember = null;
			
		} else { // 입력받은 비밀번호와 db비번이 일치한다면
			
			loginMember.setMemberPwd("");
			// session에 올라갈 loginMember객체의 비밀번호 값을 공백으로 변경
		}
		
		
		
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
		
		String encPwd = bCryptPasswordEncoder.encode(createMember.getMemberPwd());
		createMember.setMemberPwd(encPwd);
		
		int result = memberDAO.createId(createMember);
		
		
		
		System.out.println("4. 가입 결과 result:" + result);
		return result;
	}
	
	/** 아이디 중복 체크 Service
	 * @param memberId
	 * @return result
	 * @throws Exception
	 */
	@Override
	public int idUniqueCheck(String memberId) throws Exception {
		
		return memberDAO.idUniqueCheck(memberId);
	}
	
	/** 닉네임 중복 체크 Service
	 * @param memberNickname
	 * @return result
	 * @throws Exception
	 */
	@Override
	public int memberNickUnique(String memberNickname) throws Exception {
		
		return memberDAO.memberNickUnique(memberNickname);
	}
	
	/** 이메일 중복 체크 Service
	 * @param memberEmail
	 * @return return
	 * @throws Exception
	 */
	@Override
	public int memberEmailUnique(String memberEmail) throws Exception {
		
		return memberDAO.memberEmailUnique(memberEmail);
	}
	
	
	/** social 계정 가입 여부 체크 Service
	 * @param memberId
	 * @return signUpCheck
	 * @throws Exception
	 */
	@Override
	public Member checkSocialId(String memberId) throws Exception {
		return memberDAO.checkSocialId(memberId);
	}
	
	/** social 계정으로 가입 Service
	 * @param googleMember
	 * @return signUpResult
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int socialSignUp(Member socialMember) throws Exception {
		return memberDAO.socialSignUp(socialMember);
	}
	
	/** social Email 중복 확인 Service
	 * @param memberEmail
	 * @return checkSocialEmail
	 * @throws Exception
	 */
	@Override
	public Member checkSocialEmail(String memberEmail) throws Exception {
		return memberDAO.checkSocialEmail(memberEmail);
	}
	
}
