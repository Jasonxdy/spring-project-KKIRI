package com.kh.kkiri.notice.model.service;

import java.util.List;
import java.util.Map;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.notice.model.vo.Notice;

public interface NoticeService {

	int getListCount(Map<String, String> map)throws Exception;

	List<Notice> selectList(Map<String, String> 
	map, PageInfo pInf)throws Exception;

	

	
	
	
}
