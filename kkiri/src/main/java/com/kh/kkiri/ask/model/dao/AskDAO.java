package com.kh.kkiri.ask.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.member.model.vo.Member;

@Repository
public class AskDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	public int adminAskCount(Map<String, String> map) {
		return sqlSession.selectOne("askMapper.adminAskCount", map);
	}


	public List<Member> adminSelectAsk(Map<String, String> map, PageInfo pInf) throws Exception {
		int offset = (pInf.getCurrentPage() - 1) * pInf.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pInf.getLimit());
		return sqlSession.selectList("askMapper.adminSelectAsk", map, rowBounds);
	}

}
