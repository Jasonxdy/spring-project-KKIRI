package com.kh.kkiri.ask.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@RequestMapping("/ask/*")
@SessionAttributes("msg")
public class AskController {
	
	@RequestMapping("askWrite")
	public String askWrite() {
		return "notice/ask";
	}
}
