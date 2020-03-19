package com.kh.kkiri.myPage.controller;

import java.io.File;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
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
		return "redirect:/mypage/in";
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "계좌정보 수정중 오류가 발생하였습니다.");
			return "common/errorPage";
		}
	}
	@RequestMapping("updatePassword")
	public String updatePassword (Model model, String originPassword, String changePassword, RedirectAttributes rdAttr) {
		
		Member loginMember = (Member)model.getAttribute("loginMember");
		
		loginMember.setMemberPwd(originPassword);
		String msg = "";
		// 비밀번호 확인 작업
		try {
			
		int result = mypageService.updatePassword(loginMember ,changePassword);
		
		if(result==0)  msg="기존 비밀번호가 틀렸습니다.";
		else if(result ==1) msg="비밀번호 변경에 성공하였습니다.";
		else msg="비밀번호 변경에 실패하였습니다.";
		 rdAttr.addFlashAttribute("msg", msg);
		
		}catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "비밀번호 변경 과정중 오류가 발생했습니다.");
			return "common/errorPage";
		}
		
		
		return "redirect:/mypage/in";
	}
	@RequestMapping("movedeleteMember")
	public String movedeleteMember() {
		return "myPage/deleteMember";
	}
	
	@RequestMapping("deleteMember")
	public String deleteMember (Model model , String password, SessionStatus status , RedirectAttributes arAttr) {
		
		Member loginMember = (Member)model.getAttribute("loginMember");
		int result =0;
		loginMember.setMemberPwd(password);
		String msg = "";
		try {
			
			result = mypageService.deleteMember(loginMember);
			
			if(result ==-1) {
				msg="회원탈퇴에 실패하였습니다.";
				arAttr.addFlashAttribute("msg", msg);
				return "redirect:/mypage/movedeleteMember";
			}
			else if(result==0) {
				msg="비밀번호가 틀렸습니다.";
				arAttr.addFlashAttribute("msg", msg);
				return "redirect:/mypage/movedeleteMember"; // 삭제페이지로 이동
			}else {
				// session 만료 
				 status.setComplete();
				msg="회원탈퇴에 성공하였습니다.";
				System.out.println("회원탈퇴 진행합니다");
				return "redirect:/";
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "회원탈퇴 과정에서 오류가 발생했습니다.");
			return "common/errorPage";
		}
		
	}
	@RequestMapping("main")
	public String main () {
	return "redirect:/";	
	}
	
	@RequestMapping("updateMyPage")
	public String updateMyPage () {
		return "myPage/update_profile";
	}
	@RequestMapping("updateMember")
	public String updateMember (Member member, Model model, RedirectAttributes rdAttr, MultipartFile profile, HttpServletRequest request , String birthDay) {
		System.out.println("updateController 입장");
		
		Member loginMember = (Member)model.getAttribute("loginMember");
		
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "upProfileImage";
		
		File folder = new File(savePath);
		
		if(!folder.exists()) {
			folder.mkdir();
		}
		int result = 0;
		String msg = "";
		
		try {
			String from = birthDay;
			System.out.println(birthDay);
			from = from.replace("년", "-");
			from = from.replace("월", "-"); 
			System.out.println(from);
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");

			Date to = Date.valueOf(from);
			
			System.out.println(to);
			member.setMemberBirth(to);
			result = mypageService.updateMember(loginMember, member, profile,savePath);
			
			if(result >0) {
				// 업데이트 성공
				msg="회원정보 수정에 성공했습니다.";
				
			}else if(result ==0) {
				// 업데이트 실패
				msg = "회원정보 수정에 실패했습니다.";
				rdAttr.addFlashAttribute("msg", msg);
			
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "회원정보 수정 과정에서 오류가 발생했습니다.");
			return "common/errorPage";
		}
		
		return "redirect:/in";
	}
	
}
