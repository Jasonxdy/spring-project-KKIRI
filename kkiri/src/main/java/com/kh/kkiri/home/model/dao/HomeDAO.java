package com.kh.kkiri.home.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kkiri.member.model.vo.Member;

@Repository
public class HomeDAO {
	
	private SqlSessionTemplate sqlSession;

	public List<Member> selectMemberList() {
		return sqlSession.selectList("homeMapper.selectMemberList");
	}

}
