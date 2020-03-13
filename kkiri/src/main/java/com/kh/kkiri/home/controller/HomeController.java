package com.kh.kkiri.home.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.kkiri.home.model.service.HomeService;
import com.kh.kkiri.member.model.vo.Member;

@Controller
public class HomeController {
	
	
	@Autowired
	private HomeService homeService;
	
	/**
	 * 메인 화면 로딩용 Controller
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		try {
			
			// 이벤트 추천
			
			
			
			// 1주간 높은 평점을 받은 회원 목록
			int memberCount = homeService.selectMemberCount();
			
			if(memberCount > 5) {
				memberCount = 5;
			}
			
			List<Member> mlist = homeService.selectMemberList(memberCount);
			
			model.addAttribute("mlist", mlist);
			
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "메인 화면 로딩 과정 중 오류 발생");
			return "common/errorPage";
		}
		
		return "home";
	}
	
}
