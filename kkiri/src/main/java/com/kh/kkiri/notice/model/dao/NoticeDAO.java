package com.kh.kkiri.notice.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.notice.model.vo.Notice;

@Repository("noticeDAO")

public class NoticeDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int getListCount(Map<String, String> map)throws Exception {
		
		return sqlSession.selectOne("noticeMapper.getListCount",map);
	}

	public List<Notice> selectList(Map<String, String> map, PageInfo pInf) {
		
		int offset =(pInf.getCurrentPage() -1) * pInf.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pInf.getLimit());
		
		return sqlSession.selectList("noticeMapper.selectList",map,rowBounds);
	}

	
	public int selectNextNo() {
		
		return sqlSession.selectOne("noticeMapper.selectNextNo");
	}

	public int insertNotice(Notice notice) throws Exception {
		
		return sqlSession.insert("noticeMapper.insertNotice", notice);
	}

	
	/** 공지사항 상세 조회용 
	 * @param no
	 * @return
	 * @throws Exception
	 */
	public Notice selectNotice(Integer no) throws Exception {
		
		return sqlSession.selectOne("noticeMapper.selectNotice", no);
	}

	
	
	public int increaseCount(Integer no) throws Exception {
		
		return sqlSession.update("noticeMapper.increaseCount", no);
	}

	public int updateNotice(Notice notice) throws Exception {
		
		return sqlSession.update("noticeMapper.updateNotice", notice);
	}

	public int deleteNotice(Integer no) {
		return sqlSession.update("noticeMapper.deleteNotice", no);
	}

	
	
	
	
	
	
}
