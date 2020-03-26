package com.kh.kkiri.ask.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.kkiri.ask.model.service.AskService;
import com.kh.kkiri.ask.model.vo.Ask;

@Controller
@RequestMapping("/ask/*")
@SessionAttributes("msg")
public class AskController {
	
	@Autowired
	private AskService askService;
	
	@RequestMapping("ask")
	public String ask() {
		return "notice/ask";
	}
	
	@RequestMapping("askWrite")
	public String askWrite(Model model, Ask ask) {
		String msg = null;
		try {
			System.out.println("ask: "+ask);
			int result = askService.askWrite(ask);
			if(result>0) {
				msg = "1:1 문의 등록에 성공했습니다.";
			} else {
				msg = "1:1 문의 등록에 실패했습니다.";
			}
			model.addAttribute("msg", msg);
			
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMgs", "로그인 중 오류 발생");
			return "common/errorPage";
		}
		
		
		return "notice/ask";
	}
}
