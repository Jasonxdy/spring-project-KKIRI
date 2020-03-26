package com.kh.kkiri.notice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {
	@RequestMapping("notice")
	public String notice() {
		return "notice/notice";
	}
	
	
	
	
	
	
	
}
