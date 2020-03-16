package com.kh.kkiri.report.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.report.model.dao.ReportDAO;

@Service
public class ReportServiceImpl implements ReportService {
	
	@Autowired
	private ReportDAO reportDAO;
	
	/** 관리자: 신고 수 조회용 Service
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Override
	public int adminReportCount(Map<String, String> map) throws Exception {
		return reportDAO.adminReportCount(map);
	}
	
	/** 관리자: 신고 조회용 Service
	 * @param map
	 * @param pInf
	 * @return rList
	 * @throws Exception
	 */
	@Override
	public List<Member> adminSelectReport(Map<String, String> map, PageInfo pInf) throws Exception {
		return reportDAO.adminSelectReport(map, pInf);
	}
}
