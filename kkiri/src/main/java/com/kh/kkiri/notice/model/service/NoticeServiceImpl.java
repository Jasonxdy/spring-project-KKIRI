package com.kh.kkiri.notice.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.notice.model.dao.NoticeDAO;
import com.kh.kkiri.notice.model.vo.Notice;

@Service("noticeService")

public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDAO noticeDAO;

	
	@Override
	public int getListCount(Map<String, String> map) throws Exception {
		
		return noticeDAO.getListCount(map);
	}
	
	@Override
	public List<Notice> selectList(Map<String, String> map, PageInfo pInf) throws Exception {
		
		return noticeDAO.selectList(map,pInf);
	}
	
	
}
