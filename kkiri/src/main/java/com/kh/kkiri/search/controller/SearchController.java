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
	
	@RequestMapping("searchEvent")
	public String searchHome(Model model,
			@RequestParam(value="searchKey", required=false) String searchKey) {
		if(searchKey!=null) {
			model.addAttribute("findKeyword",searchKey);
		}
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

		List<Search> sList = searchService.selectSearchList(map, currentPage, limit, checkEventStatus);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyyMMddHHmm").create();
		
		return gson.toJson(sList);
	}
}
