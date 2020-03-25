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
		int offset = (currentPage - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return sqlSession.selectList("searchMapper.selectCreateEvent", memberNo, rowBounds);
	}

	/** 이벤트 수 조회용 DAO
	 * @param memberNo
	 * @param flag
	 * @return listCount
	 */
	public int listCount(int memberNo, int flag) {
		if(flag == 0) {
			return sqlSession.selectOne("searchMapper.cListCount",memberNo);
		} else {
			return sqlSession.selectOne("searchMapper.jListCount",memberNo);
		}
	}

	/** 이벤트 조회용 DAO
	 * @param memberNo
	 * @param currentPage
	 * @param limit
	 * @param flag
	 * @return eList
	 */
	public List<Search> selectEventList(int memberNo, int currentPage, int limit, Integer flag) {
		int offset = (currentPage - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		if(flag == 0) {
			return sqlSession.selectList("searchMapper.selectCreateEvent", memberNo, rowBounds);
		} else {
			return sqlSession.selectList("searchMapper.selectJoinEvent", memberNo, rowBounds);
		}
	}

	/** 좋아요 여부 체크용 DAO
	 * @param memberNo
	 * @param favoriteNo
	 * @return result
	 */
	public int checkFavorite(int memberNo, int favoriteNo) {
		return sqlSession.selectOne("memberMapper.checkFavorite", memberNo, favoriteNo);
	}
}
