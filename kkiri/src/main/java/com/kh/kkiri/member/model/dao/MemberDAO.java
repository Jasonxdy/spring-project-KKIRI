package com.kh.kkiri.member.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.kkiri.member.model.vo.Attachment;
import com.kh.kkiri.member.model.vo.Member;

@Repository("memberDAO")


public class MemberDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	
	/** 회원 로그인 DAO
	 * @param member
	 * @return signInMember
	 * @throws Exception
	 */
	public Member signInMember(Member member)throws Exception {
		
		return sqlSession.selectOne("memberMapper.signInMember", member);
	}


	
	/** 회원 가입 DAO
	 * @param createMember
	 * @param files 
	 * @return result
	 * @throws Exception
	 */
	public int createId(Member createMember) throws Exception {
		
		return sqlSession.insert("memberMapper.createId", createMember);
		
	}

	

	public int updateMember(Member member) throws Exception{
		return sqlSession.update("memberMapper.updateMember", member);
	}



	/** google 계정 가입 여부 체크 DAO
	 * @param memberId
	 * @return signUpCheck
	 * @throws Exception
	 */
	public Member checkSocialId(String memberId) throws Exception {
		return sqlSession.selectOne("memberMapper.checkSocialId", memberId);
	}

	/** google 계정으로 가입 Service
	 * @param googleMember
	 * @return signUpResult
	 * @throws Exception
	 */
	public int socialSignUp(Member socialMember) throws Exception {
		return sqlSession.insert("memberMapper.socialSignUp", socialMember);
	}
	
	/** social Email 중복 확인 Service
	 * @param memberEmail
	 * @return checkSocialEmail
	 * @throws Exception
	 */
	public Member checkSocialEmail(String memberEmail) throws Exception {
		return sqlSession.selectOne("memberMapper.checkSocialEmail", memberEmail);
	}



	



	
	
	
	
	
	
	
	
	
}
