package com.kh.kkiri.search.controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.kkiri.common.Pagination;
import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.search.model.service.SearchService;
import com.kh.kkiri.search.model.vo.Search;

@Controller
@RequestMapping("/search/*")
@SessionAttributes({"msg"})
public class SearchController {
	
	@Autowired
	private SearchService searchService;
	
	private int limit=10;
	private int pagingBarSize=10;
	
	@RequestMapping("searchEvent")
	public String searchEvent(Model model,
								@RequestParam(value="searchKey", required=false) String searchKey,
								@RequestParam(value="searchValue", required=false) String searchValue,
								@RequestParam(value="currentPage", required=false) Integer currentPage
								) {
		try {
			Map<String, String> map = null;
			if(searchKey != null && searchValue != null) {
				map = new HashMap<String, String>();
				map.put("searchKey", searchKey);
				map.put("searchValue", searchValue);
			}
			
			int listCount = searchService.getSearchCount(map);
			
			if(currentPage == null) currentPage = 1;
			
			PageInfo pInf = Pagination.getPageInfo(limit, pagingBarSize, currentPage, listCount);
			
			List<Search> search = searchService.selectList(map, pInf);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 E요일 a h시 mm분 ss초");
			System.out.println(search.get(0).getEventStart());
			//SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 hh:mm");
			
			model.addAttribute("search", search);
			model.addAttribute("pInf", pInf);
			
			return "search/searchEvent";
			
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "탐색페이지 목록 조회중 오류발생");
			return "common/errorPage";
		}
	}
}
