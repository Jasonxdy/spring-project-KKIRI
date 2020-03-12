package com.kh.kkiri.admin.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kkiri.member.model.vo.Member;

@Repository
public class AdminDAO {
	
	private SqlSessionTemplate sqlSession;
	
	public List<Member> adminSelectMember() throws Exception {
		return null;
	}

	public int adminMemberCount() throws Exception {
		return sqlSession.selectOne("memberMapper.adminMemberCount");
	}

}
