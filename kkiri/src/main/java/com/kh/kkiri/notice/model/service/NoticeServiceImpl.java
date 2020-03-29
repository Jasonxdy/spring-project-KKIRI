package com.kh.kkiri.notice.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	
	
	
	/**공지사항 등록 Service
	 *
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertNotice(Notice notice) throws Exception {
		
		int result = 0;
		// 공지사항 다음 글번호 얻어오기
		// -> 공지사항 등록 성공 시 해당 게시글로 돌아갈 수 있게하기 위함
		int no = noticeDAO.selectNextNo();
		System.out.println("no : " + no);
		
		if(no > 0) { // 글번호 얻어오기 성공 시 
			// 조회된 글번호 세팅
			notice.setNoticeNo(no);
			
			// DB 저장 시 개행문자를 <br>로 변경해줘야
			// 상세 조회시 줄바꿈이 유지됨.
			notice.setNoticeContent(
					notice.getNoticeContent().replace("\r\n", "<br>"));
			
			result = noticeDAO.insertNotice(notice);
			System.out.println("result : " + result);
			
			if(result > 0)	result = no;
		}
		
		return result;
		
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public Notice selectNotice(Integer no) throws Exception {
		
		Notice notice = noticeDAO.selectNotice(no);
		
		if(notice != null) {
			// 조회수 증가
			int result = noticeDAO.increaseCount(no);
			
			if(result > 0) {
				notice.setNoticeCount(notice.getNoticeCount() + 1);
			}else {
				notice = null;
			}
		}
		
		return notice;
	}
	
	
	@Override
	public Notice updateView(Integer no) throws Exception {
		Notice notice = noticeDAO.selectNotice(no);
		
		notice.setNoticeContent(notice.getNoticeContent().replace("<br>", "\r\n"));
		notice.setNoticeNo(no);
		
		return notice;
	}
	
	
	@Override
	public int updatetNotice(Notice notice) throws Exception {
		notice.setNoticeContent(
				notice.getNoticeContent().replace("\r\n", "<br>"));
		return noticeDAO.updateNotice(notice);
	}
	
	@Override
	public int deletetNotice(Integer no) throws Exception {
		return  noticeDAO.deleteNotice(no);
	}


}
