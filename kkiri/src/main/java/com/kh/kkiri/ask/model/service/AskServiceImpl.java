package com.kh.kkiri.ask.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.kkiri.ask.model.dao.AskDAO;
import com.kh.kkiri.ask.model.vo.Ask;
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
	public List<Ask> adminSelectAsk(Map<String, String> map, PageInfo pInf) throws Exception {
		List<Ask> aList = askDAO.adminSelectAsk(map, pInf);
//		for(Ask ask : aList) {
//			if(ask.getAskContent() != null) {
//				ask.setAskContent(ask.getAskContent().replace("<br>", "\r\n"));
//			}
//		}
		return aList; 
	}
	
	/** 관리자: 1:1문의 답변 작성 Service
	 * @param ask
	 * @return result
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int adminSendAnswer(Ask ask) throws Exception {
		return askDAO.adminSendAnswer(ask);
	}
	
	/** 1:1문의 등록 Service
	 * @param ask
	 * @return result
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int askWrite(Ask ask) throws Exception {
		ask.setAskContent(ask.getAskContent().replace("\n", "<br>"));
		return askDAO.askWrite(ask);
	}
}
