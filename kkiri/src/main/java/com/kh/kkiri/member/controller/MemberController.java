package com.kh.kkiri.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.member.service.MemberService;


@SessionAttributes({ "loginMember", "msg" })

@Controller

@RequestMapping("/member/*")    //경로 수정할 수 있음!!!!! (3/12 일)

public class MemberController {

	
	@Autowired
	private MemberService memberService;
	
	@Autowired 
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	// 암호화 준비
	
	
	// 6번 @세션 어트리뷰트 사용하기
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String signIn(Member member, Model model ) {
		
		 System.out.println("입력 확인 :"+member.getMemberId()+ 
				 "/ " + member.getMemberPwd());
		
		try {
			
			Member loginMember = memberService.loginMember(member);
			
			System.out.println("로그인 확인 :"+loginMember);
		//	if( !bCryptPasswordEncoder.matches(member.getMemberPwd(), loginMember.getMemberPwd())) {
		//	//	loginMember = null;
		//	}
			
			if(loginMember !=null) {
				model.addAttribute("loginMember", loginMember);
				
				
			}else {
				
				model.addAttribute("msg", "비밀번호가 잘못되었습니다.");
			}
			

			return "redirect:/";
			
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMgs","로그인 중 오류 발생" );
			return "common/errorPage";
			
		}
		
		
	}
	
	
	
	
	
	
}
