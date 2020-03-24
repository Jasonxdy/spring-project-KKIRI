package com.kh.kkiri.profile.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.kkiri.member.model.vo.Member;

@Repository("profileDAO")
public class ProfileDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public Member selectMember(int no) {
		return sqlSession.selectOne("memberMapper.selectMember", no);
	}
}
