package com.kh.kkiri.ask.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.kkiri.ask.model.dao.AskDAO;
import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.member.model.vo.Member;

@Service
public class AskServiceImpl implements AskService {
	
	@Autowired
	private AskDAO askDAO;
	
	
	/** 관리자: 1:1문의 수 조회 Service
	 * @param map
	 * @return aList
	 * @throws Exception
	 */
	@Override
	public int adminAskCount(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return askDAO.adminAskCount(map);
	}
	
	/** 관리자: 1:1문의 조회 Service
	 * @param map
	 * @param pInf
	 * @return aList
	 * @throws Exception
	 */
	@Override
	public List<Member> adminSelectAsk(Map<String, String> map, PageInfo pInf) throws Exception {
		return askDAO.adminSelectAsk(map, pInf);
	}
}
