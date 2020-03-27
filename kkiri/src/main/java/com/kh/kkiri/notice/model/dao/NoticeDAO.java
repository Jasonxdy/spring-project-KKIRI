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

}
