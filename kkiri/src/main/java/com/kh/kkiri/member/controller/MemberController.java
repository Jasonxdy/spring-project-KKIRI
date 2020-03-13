package com.kh.kkiri.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.kh.kkiri.member.model.service.MemberService;
import com.kh.kkiri.member.model.vo.Member;


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
	public String signIn(Member member, Model model, HttpServletRequest request) {
		
		String beforeUrl = request.getHeader("referer");
		
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
			
			return "redirect:" + beforeUrl;
			
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMgs","로그인 중 오류 발생" );
			return "common/errorPage";
			
		}
		
	}
	
	// 로그 아웃(태균)
	@RequestMapping("logout")
	public String logOut(SessionStatus status,HttpServletRequest request ) {
		
		String beforeUrl = request.getHeader("referer");
		status.setComplete();
		
		return "redirect:" + beforeUrl;
	}
	
	// 회원가입 이동
	@RequestMapping("signUp")
	public String signUp() {
		return "member/signUp";
	}
	
	// 회원 가입
	@RequestMapping("createAccount")
	public String createAccount() {
		
		
		
		
		
		return "redirect:";
	}
	
	
	
	
	
}
