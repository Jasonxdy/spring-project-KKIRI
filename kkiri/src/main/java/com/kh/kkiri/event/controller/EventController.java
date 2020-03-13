package com.kh.kkiri.event.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.kkiri.event.model.service.EventService;
import com.kh.kkiri.event.model.vo.Event;

@Controller
@SessionAttributes({"loginMember", "msg"})
@RequestMapping("/event/*")
public class EventController {
	
	@Autowired
	private EventService eventService;
	
	
	// 이벤트 상세 페이지 이동
	@RequestMapping("detail")
	public String eventDetail(@RequestParam(value = "no", required = false) Integer no
							,Model model) {
		
		int eventNo = 0;
		
		if(no != null) {
			eventNo = no;
		} else {
			eventNo = 1;
		}
		
		
		try {
			
			// 이벤트 얻어오기
//			Event event = eventService.selectEvent(eventNo);
			
			
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "이벤트 상세 페이지 조회 과정 중 오류 발생");
			return "common/errorPage.jsp";
		}
		
		return "event/eventDetail"; 
		
	}
	
	
	
}
