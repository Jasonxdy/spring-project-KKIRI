package com.kh.kkiri.search.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.search.model.vo.Search;

@Service
public interface SearchService {

	/** 탐색 페이지 이벤트 조회용 Service
	 * @param map
	 * @param currentPage
	 * @param limit
	 * @return search
	 */
	public abstract List<Search> selectSearchList(Map<String, Object> map, int currentPage, int limit, int checkEventStatus);

}
