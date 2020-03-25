package com.kh.kkiri.search.controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kh.kkiri.search.model.service.SearchService;
import com.kh.kkiri.search.model.vo.Search;

@Controller
@RequestMapping("/search/*")
@SessionAttributes({"msg", "loginMember"})
public class SearchController {
	
	@Autowired
	private SearchService searchService;
	
	//private int limit=2;
	private int pagingBarSize=10;
	
	/*
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
	*/
	
	@RequestMapping("searchEvent")
	public String searchHome() {
		return "search/searchEvent";
	}
	
	@ResponseBody
	@RequestMapping(value = "searchEvents", produces= "application/json; charset=utf-8")
	public String searchEvent(@RequestParam(value="searchKey", required=false) String searchKey,
								@RequestParam(value="searchValue", required=false) String searchValue,
								@RequestParam(value="currentPage", required=false) Integer currentPage,
								@RequestParam(value="limit", required=false) Integer limit,
								@RequestParam(value="checkEventStatus", required=false) Integer checkEventStatus
								) {
		
		Map<String, Object> map = null;
		if(searchKey != "" || searchValue != "") {
			map = new HashMap<String, Object>();
			if(searchKey != "") {
				map.put("searchKey", searchKey);
			} 
			if(searchValue != "") {
				map.put("searchValue", searchValue);
			}
		}
		
		if(currentPage == null) currentPage = 1;
		//int listCount = searchService.getSearchCount(map);
		
		//PageInfo pInf = Pagination.getPageInfo(limit, pagingBarSize, currentPage, listCount);

		List<Search> sList = searchService.selectSearchList(map, currentPage, limit, checkEventStatus);
		System.out.println(sList);
		
		/*
		System.out.println("크기 : " + sList.size());
		for(int i = 0 ; i<sList.size() ; i++) {
			System.out.print(sList.get(i).getEventNo() + " ");
		}
		System.out.println();
		*/
		
		Gson gson = new GsonBuilder().setDateFormat("yyyyMMddHHmm").create();
		//Gson gson = new GsonBuilder().setDateFormat("yyyy년 MM월 dd일 HH:mm").create();
		//Gson gson = new GsonBuilder().create();
		
		//yyyy년 MM월 dd일 KK:mm
		
		return gson.toJson(sList);
	}
}
