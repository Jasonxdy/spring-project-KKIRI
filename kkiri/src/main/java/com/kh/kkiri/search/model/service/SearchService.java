package com.kh.kkiri.search.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.search.model.vo.Search;

@Service
public interface SearchService {

	/** 탐색페이지 이벤트 수 조회용 Service
	 * @param map
	 * @return searchCount
	 * @throws Exception
	 */
	//public abstract int getSearchCount(Map<String, String> map) throws Exception;

	
	/** 탐색 목록 조회용 Service
	 * @param map
	 * @param pInf
	 * @return list
	 * @throws Exception
	 */
	//public abstract List<Search> selectList(Map<String, String> map, PageInfo pInf) throws Exception;

}
