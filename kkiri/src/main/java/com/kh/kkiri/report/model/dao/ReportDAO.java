package com.kh.kkiri.report.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.member.model.vo.Member;

@Repository
public class ReportDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	/** 관리자: 신고 수 조회용 DAO
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int adminReportCount(Map<String, String> map) throws Exception {
		return sqlSession.selectOne("reportMapper.adminReportCount", map);
	}
	
	/** 관리자: 신고 조회용 DAO
	 * @param map
	 * @param pInf
	 * @return rList
	 * @throws Exception
	 */
	public List<Member> adminSelectReport(Map<String, String> map, PageInfo pInf) throws Exception {
		int offset = (pInf.getCurrentPage() - 1) * pInf.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pInf.getLimit());
		return sqlSession.selectList("reportMapper.adminSelectReport", map, rowBounds);
	}
	
}
