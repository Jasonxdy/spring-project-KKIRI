package com.kh.kkiri.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.member.service.MemberService;


@SessionAttributes({ "loginMember", "msg" })

@Controller

@RequestMapping("/member")    //경로 수정할 수 있음!!!!! (3/12 일)

public class MemberController {

	
	@Autowired
	private MemberService memberService;
	
	// 6번 @세션 어트리뷰트 사용하기
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String signIn(Member member, Model model ) {
		
		try {
			
			
		}catch (Exception e) {
			e.printStackTrace();
			
			return null;
			
		}
		
		return null;
	}
	
	
	
	
	
	
}
