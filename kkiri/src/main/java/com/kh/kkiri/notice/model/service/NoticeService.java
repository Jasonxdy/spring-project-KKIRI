package com.kh.kkiri.notice.model.service;

import java.util.List;
import java.util.Map;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.notice.model.vo.Notice;

public interface NoticeService {

	int getListCount(Map<String, String> map)throws Exception;

	List<Notice> selectList(Map<String, String> 
	map, PageInfo pInf)throws Exception;

	
	/** 공지사항 등록
	 * @param notice
	 * @return
	 * @throws Exception
	 */
	int insertNotice(Notice notice)throws Exception;

	
	
	/** 공지사항 상세 조회용
	 * @param no
	 * @return
	 * @throws Exception
	 */
	Notice selectNotice(Integer no)throws Exception;

	
	
	
	Notice updateView(Integer no)throws Exception;

	
	
	
	int updatetNotice(Notice notice)throws Exception;

	
	int deletetNotice(Integer no)throws Exception;

	
	
	

	

	
	
	
}
