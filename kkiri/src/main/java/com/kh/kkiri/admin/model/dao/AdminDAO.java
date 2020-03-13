package com.kh.kkiri.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.member.model.vo.Member;

@Repository
public class AdminDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	

	/** 회원 수 조회 DAO
	 * @return memberCount
	 * @throws Exception
	 */
	public int adminMemberCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("memberMapper.adminMemberCount", map);
	}

	/** 회원 정보 조회 DAO
	 * @param map
	 * @param pInf
	 * @return mList
	 */
	public List<Member> adminSelectMember(Map<String, Object> map, PageInfo pInf) {
		int offset = (pInf.getCurrentPage() - 1) * pInf.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pInf.getLimit());
		return sqlSession.selectList("memberMapper.adminSelectMember", map, rowBounds);
	}

}
