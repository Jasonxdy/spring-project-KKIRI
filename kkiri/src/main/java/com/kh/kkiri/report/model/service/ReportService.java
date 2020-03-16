package com.kh.kkiri.report.model.service;

import java.util.List;
import java.util.Map;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.member.model.vo.Member;

public interface ReportService {

	/** 관리자: 신고 수 조회용 Service
	 * @param map
	 * @return
	 * @throws Exception
	 */
	int adminReportCount(Map<String, String> map) throws Exception;

	/** 관리자: 신고 조회용 Service
	 * @param map
	 * @param pInf
	 * @return rList
	 * @throws Exception
	 */
	List<Member> adminSelectReport(Map<String, String> map, PageInfo pInf) throws Exception;

		
}
