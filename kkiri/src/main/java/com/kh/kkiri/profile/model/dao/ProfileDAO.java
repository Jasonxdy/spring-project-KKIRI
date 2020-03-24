package com.kh.kkiri.profile.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.search.model.vo.Search;

@Repository("profileDAO")
public class ProfileDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	/** 프로필 조회용 DAO
	 * @param no
	 * @return member
	 */
	public Member selectMember(int memberNo) {
		return sqlSession.selectOne("memberMapper.selectMember", memberNo);
	}

	
	/** 프로필 생성한 이벤트 조회용 DAO
	 * @param memberNo
	 * @return cList
	 */
	public List<Search> selectCreateEvent(Integer memberNo, int currentPage, int limit) {
		//int offset = (pInf.getCurrentPage() - 1) * pInf.getLimit();
		//RowBounds rowBounds = new RowBounds(offset, pInf.getLimit());
		
		return sqlSession.selectList("searchMapper.selectCreateEvent");
	}
}
