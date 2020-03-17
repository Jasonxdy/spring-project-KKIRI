package com.kh.kkiri.search.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.search.model.vo.Search;

@Repository("searchDAO")
public class SearchDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	/** 탐색 목록 조회용 DAO
	 * @param map
	 * @param currentPage
	 * @param limit
	 * @return search
	 */
	public List<Search> selectSearchList(Map<String, Object> map, int currentPage, int limit) {
		int offset = (currentPage-1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return sqlSession.selectList("searchMapper.selectList", map, rowBounds);
	}

	/** 탐색페이지 이벤트 수 조회용 DAO
	 * @param map
	 * @return searchCount
	 * @throws Exception
	 */
	/*
	public int getSearchCount(Map<String, String> map) throws Exception{
		return sqlSession.selectOne("searchMapper.getSearchCount", map);
	}
	*/

	/** 탐색 목록 조회용 DAO
	 * @param map
	 * @param pInf
	 * @return list
	 * @throws Exception
	 */
	/*
	public List<Search> selectList(Map<String, String> map, PageInfo pInf) throws Exception{
		int offset = (pInf.getCurrentPage()-1) * pInf.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pInf.getLimit());
		
		return sqlSession.selectList("searchMapper.selectList", map, rowBounds);
	}
	*/
}
