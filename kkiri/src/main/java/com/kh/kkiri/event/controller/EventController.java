package com.kh.kkiri.event.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.kkiri.event.model.service.EventService;

@Controller
@SessionAttributes({"loginMember", "msg"})
@RequestMapping("/event/*")
public class EventController {
	
	@Autowired
	private EventService eventService;
	
	
	// 이벤트 상세 페이지 이동
	@RequestMapping("detail")
	public String eventDetail(@RequestParam(value = "no", required = false) Integer no) {
		
		try {
			
			// 이벤트 얻어오기
			
			
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return "event/eventDetail"; 
		
	}
	
	
	
}
