package com.kh.kkiri.search.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.kkiri.search.model.service.SearchService;

@Controller
@RequestMapping("/search/*")
@SessionAttributes({"msg"})
public class SearchController {
	
	//@Autowired
	//SearchService searchService;
	
	@RequestMapping("searchEvent")
	public String searchEvent() {
		return "search/searchEvent";
	}
}
