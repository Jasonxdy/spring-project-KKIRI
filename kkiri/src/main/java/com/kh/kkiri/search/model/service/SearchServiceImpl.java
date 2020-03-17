package com.kh.kkiri.search.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.search.model.dao.SearchDAO;
import com.kh.kkiri.search.model.vo.Search;

@Service("searchService")
public class SearchServiceImpl implements SearchService {

	@Autowired
	private SearchDAO searchDAO;

	/** 탐색 페이지 이벤트 조회용 Service
	 * @param map
	 * @param currentPage
	 * @param limit
	 * @return search
	 */
	@Override
	public List<Search> selectSearchList(Map<String, Object> map, int currentPage, int limit) {
		return searchDAO.selectSearchList(map, currentPage, limit);
	}

	
	/** 탐색페이지 이벤트 수 조회용 Service
	 * @param map
	 * @return searchCount
	 * @throws Exception
	 */
	/*
	@Override
	public int getSearchCount(Map<String, String> map) throws Exception{
		return searchDAO.getSearchCount(map);
	}
	*/

}
