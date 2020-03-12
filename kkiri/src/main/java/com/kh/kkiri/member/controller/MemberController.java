package com.kh.kkiri.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.kkiri.member.service.MemberService;


@SessionAttributes({ "loginMember", "msg" })

@Controller

@RequestMapping("/member")    //경로 수정할 수 있음!!!!! (3/12 일)

public class MemberController {

	@Autowired
	private MemberService memberService;
	
	
	
	
}
