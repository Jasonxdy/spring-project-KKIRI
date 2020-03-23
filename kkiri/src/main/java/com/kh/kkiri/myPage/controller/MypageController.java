package com.kh.kkiri.myPage.controller;

import java.io.File;
import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.kkiri.member.model.service.MemberService;
import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.myPage.model.service.MypageService;
import com.kh.kkiri.payment.model.vo.Payment;

@RequestMapping("/mypage/*")
@Controller
@SessionAttributes({"loginMember", "msg"})
public class MypageController {

	@Autowired
	private MypageService mypageService;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("in")
	public String mypageIn(Model model, HttpSession session, 
			RedirectAttributes rdAttr) {
		Member loginMember  = (Member)session.getAttribute("loginMember");
		if(loginMember.getMemberCategory().equals("설정해주세요") || 
				loginMember.getMemberPlace().equals("설정해주세요")) {
				String msg = "관심 지역과 관심 카테고리를 수정해주세요";
				session.setAttribute("msg", msg);
		}
		
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
	public String updateMember (Member member,String [] interest ,  Model model, RedirectAttributes rdAttr,@RequestParam(value = "profile" , required = false) MultipartFile profile, HttpServletRequest request , String birthDay) {
		System.out.println("updateController 입장");
		
		Member loginMember = (Member)model.getAttribute("loginMember");
		String memberInterest = "";
		for(int i =0 ; i<interest.length; i++) {
			memberInterest+=interest[i];
			if(i!=interest.length-1) {
				
			memberInterest += ",";
			}
		}
		member.setMemberCategory(memberInterest);
		
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/upProfileImage";
		
		File folder = new File(savePath);
		
		if(!folder.exists()) {
			folder.mkdir();
		}
		int result = 0;
		String msg = "";
		
		try {
			String from = birthDay;
			from = from.replace("년", "-");
			from = from.replace("월", "-"); 
			from = from.replace("일", ""); 
			Date to = Date.valueOf(from);
			
			member.setMemberBirth(to);
			
			result = mypageService.updateMember(loginMember, member, profile,savePath);
			
			
			System.out.println(member);
			if(result >0) {
				// 업데이트 성공
				msg="회원정보 수정에 성공했습니다.";
				rdAttr.addFlashAttribute("msg", msg);
				member.setMemberId(loginMember.getMemberId());
				if(member.getMemberProfile()==null) {
					member.setMemberProfile(loginMember.getMemberProfile());
				}
				loginMember = member;
				model.addAttribute("loginMember", loginMember);
				
				
			}else if(result ==0) {
				// 업데이트 실패
				msg = "회원정보 수정에 실패했습니다.";
				rdAttr.addFlashAttribute("msg", msg);
			member.setMemberId(loginMember.getMemberId());
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "회원정보 수정 과정에서 오류가 발생했습니다.");
			return "common/errorPage";
		}
		
		return "redirect:/mypage/in";
	}
	@RequestMapping("ticketLog")
	public String ticketLog(Model model) {
		int memberNo = ((Member)model.getAttribute("loginMember")).getMemberNo();
		try {
		List<Payment> ticketList = mypageService.ticketLog(memberNo);
		model.addAttribute("ticketList", ticketList);
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "회원정보 수정 과정에서 오류가 발생했습니다.");
			return "common/errorPage";
		}
		return "myPage/ticket_history";
	}
	
}
