package com.kh.kkiri.search.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	private int pagingBarSize=10;
	
	// 홈페이지에서 키워드 클릭으로 이동한 경우
	@RequestMapping("searchEvent")
	public String searchHome(Model model,
			@RequestParam(value="searchKey", required=false) String searchKey) {
		if(searchKey!=null) {
			model.addAttribute("findKeyword",searchKey);
		}
		return "search/searchEvent";
	}
	
	// 탐색 페이지
	@ResponseBody
	@RequestMapping(value = "searchEvents", produces= "application/json; charset=utf-8")
	public String searchEvent(@RequestParam(value="searchKey", required=false) String searchKey,
								@RequestParam(value="searchValue", required=false) String searchValue,
								@RequestParam(value="currentPage", required=false) Integer currentPage,
								@RequestParam(value="limit", required=false) Integer limit,
								@RequestParam(value="checkEventStatus", required=false) Integer checkEventStatus
								) {
		
		// 카테고리, 제목의 키워드 입력을 확인하여 map에 저장
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

		List<Search> sList = searchService.selectSearchList(map, currentPage, limit, checkEventStatus);
		
		// date 타입의 형식 변환을 위해 gsonBuilder 사용
		Gson gson = new GsonBuilder().setDateFormat("yyyyMMddHHmm").create();
		
		return gson.toJson(sList);
	}
}
