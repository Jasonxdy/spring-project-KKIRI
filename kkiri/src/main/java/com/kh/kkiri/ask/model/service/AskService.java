package com.kh.kkiri.ask.model.service;

import java.util.List;
import java.util.Map;

import com.kh.kkiri.ask.model.vo.Ask;
import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.member.model.vo.Member;

public interface AskService {
	
	/** 관리자: 1:1문의 수 조회 Service
	 * @param map
	 * @return aList
	 * @throws Exception
	 */
	int adminAskCount(Map<String, String> map) throws Exception;

	/** 관리자: 1:1문의 조회 Service
	 * @param map
	 * @param pInf
	 * @return aList
	 * @throws Exception
	 */
	List<Member> adminSelectAsk(Map<String, String> map, PageInfo pInf) throws Exception;

	/** 관리자: 1:1문의 답변 작성 Service
	 * @param ask
	 * @return result
	 * @throws Exception
	 */
	int adminSendAnswer(Ask ask) throws Exception;

	/** 1:1문의 등록 Service
	 * @param ask
	 * @return result
	 * @throws Exception
	 */
	int askWrite(Ask ask) throws Exception;
	
	
}
