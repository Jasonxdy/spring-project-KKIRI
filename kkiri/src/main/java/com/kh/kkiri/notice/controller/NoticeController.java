package com.kh.kkiri.notice.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.kkiri.common.Pagination;
import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.notice.model.service.NoticeService;
import com.kh.kkiri.notice.model.vo.Notice;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	@RequestMapping("noticeList")
	public ModelAndView noticeList(ModelAndView mv,
			@RequestParam(value = "searchKey", required = false) String searchKey,
			@RequestParam(value = "searchValue", required = false) String searchValue,
			@RequestParam(value = "currentPage", required = false) Integer currentPage) {
	
		
		try {
			
			Map<String, String> map = null;
			if (searchKey != null && searchValue != null) {
				map = new HashMap<String, String>();
				// 맵 생성
				map.put("searchkey", searchKey);
				map.put("searchValue", searchValue);
			}
			
			int listCount = noticeService.getListCount(map);

			// 현재 페이지 계산
			if (currentPage == null)
				currentPage = 1;

			PageInfo pInf = Pagination.getPageInfo(5, 5, currentPage, listCount);
			
			List<Notice> list = noticeService.selectList(map, pInf);

			mv.addObject("list", list);
			mv.addObject("pInf", pInf);
			mv.setViewName("notice/noticeList");
			
			
			
			
		}catch (Exception e) {
			e.printStackTrace();
			mv.addObject("errorMsg", "공지사항 목록 조회중 오류 발생");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}
		
	
	
}
