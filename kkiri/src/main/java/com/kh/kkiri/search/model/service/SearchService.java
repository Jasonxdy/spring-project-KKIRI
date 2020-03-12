package com.kh.kkiri.search.model.service;

import org.springframework.stereotype.Service;

import com.kh.kkiri.search.model.vo.Search;

@Service
public interface SearchService {

	public abstract Search selectSearchList() throws Exception;

}
