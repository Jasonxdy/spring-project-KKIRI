package com.kh.kkiri.profile.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.profile.model.service.ProfileService;

@Controller
@RequestMapping("/profile/*")
@SessionAttributes({"msg", "loginMember"})
public class ProfileController {
	
	@Autowired
	private ProfileService profileService;
	
	@RequestMapping("user")
	public String userProfile(//Integer no,
								Model model,
								HttpServletRequest request
								) {
		String beforeUrl = request.getHeader("referer");
		
		try {
			int no = 1;
			
			Member member = profileService.selectMember(no);
			
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg","유저 프로필 조회 과정에서 오류 발생");
			return "common/errorPage";
		}
		
		return "member/userProfile";
	}
	
}
