package com.kh.kkiri.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kh.kkiri.admin.model.vo.EventStatistic;
import com.kh.kkiri.admin.model.vo.Video;
import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.member.model.vo.Member;

@Repository
public class AdminDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	/** 회원 수 조회 DAO
	 * @return memberCount
	 * @throws Exception
	 */
	public int adminMemberCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("memberMapper.adminMemberCount", map);
	}

	/** 회원 정보 조회 DAO
	 * @param map
	 * @param pInf
	 * @return mList
	 */
	public List<Member> adminSelectMember(Map<String, Object> map, PageInfo pInf)
	throws Exception{
		int offset = (pInf.getCurrentPage() - 1) * pInf.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pInf.getLimit());
		return sqlSession.selectList("memberMapper.adminSelectMember", map, rowBounds);
	}

	/** 티켓 환불 DAO
	 * @param map
	 * @return result
	 * @throws Exception
	 */
	public int refundTicket(Map<String, Object> map) throws Exception {
		return sqlSession.update("memberMapper.refundTicket", map);
	}

	/** 회원 삭제 DAO
	 * @param memberNo
	 * @return result
	 * @throws Exception
	 */
	public int delete(Integer memberNo) throws Exception {
		return sqlSession.update("memberMapper.adminDelete", memberNo);
	}

	/** 회원 삭제 복구 DAO
	 * @param memberNo
	 * @return result
	 * @throws Exception
	 */
	public int recover(Integer memberNo) throws Exception {
		return sqlSession.update("memberMapper.adminRecover", memberNo);
	}

	/** 영상 업로드 DAO
	 * @param videoName
	 * @return result
	 * @throws Exception
	 */
	public int insertVideo(Video video) throws Exception {
		return sqlSession.insert("adminMapper.insertVideo", video);
	}

	/** 영상 조회 DAO
	 * @return vList
	 * @throws Exception
	 */
	public List<Video> adminSelectVideo() throws Exception {
		return sqlSession.selectList("adminMapper.adminSelectVideo");
	}

	/** 메인 영상 교체 DAO
	 * @param changeVideo
	 * @return result
	 * @throws Exception
	 */
	public int adminChangeVideo(String changeVideo) throws Exception{
		int result = sqlSession.update("adminMapper.changeMain", changeVideo);
		result += sqlSession.update("adminMapper.changeNormal", changeVideo);
		return result;
	}

	/** 메인 영상 가져오기 DAO
	 * @return mainVideo
	 * @throws Exception
	 */
	public String selectMainVideo() throws Exception {
		return sqlSession.selectOne("adminMapper.selectMainVideo");
	}

	/** 영상 삭제 DAO
	 * @param changeVideo
	 * @return
	 * @throws Exception
	 */
	public int adminDeleteVideo(String changeVideo) throws Exception {
		return sqlSession.update("adminMapper.adminDeleteVideo", changeVideo);
	}

	public List<EventStatistic> eventStatistic() throws Exception {
		return sqlSession.selectList("adminMapper.eventStatistic");
	}


}
