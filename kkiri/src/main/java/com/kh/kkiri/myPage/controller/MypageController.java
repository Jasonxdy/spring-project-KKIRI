package com.kh.kkiri.myPage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.myPage.model.service.MypageService;

@RequestMapping("/mypage/*")
@Controller
@SessionAttributes({"loginMember", "msg"})
public class MypageController {

	@Autowired
	private MypageService mypageService;
	
	@RequestMapping("in")
	public String mypageIn(Model model ) {
		
		return "myPage/my_profile";
	}

	
	@RequestMapping("updateAccount")
	public String updateAccount(Model model,String bankName, String bankOrner, String bankNumber , RedirectAttributes rdAttr ) {
		
		Member loginMember = (Member)model.getAttribute("loginMember");
		String Account = bankName+","+bankNumber+","+bankOrner;
		loginMember.setMemberAccount(Account);
		String msg = null;
		try {
			
		int result = mypageService.updateAccount(loginMember);
		
		if(result>0) {
			msg = "회원정보 수정 완료";
			rdAttr.addFlashAttribute("msg", msg);
		}
		return "redirect:/myPage/in";
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "계좌정보 수정중 오류가 발생하였습니다.");
			return "common/errorPage";
		}
	}
}
