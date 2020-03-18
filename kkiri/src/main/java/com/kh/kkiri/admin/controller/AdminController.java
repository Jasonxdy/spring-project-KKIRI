package com.kh.kkiri.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.kkiri.admin.model.service.AdminService;
import com.kh.kkiri.ask.model.service.AskService;
import com.kh.kkiri.ask.model.vo.Ask;
import com.kh.kkiri.common.Pagination;
import com.kh.kkiri.common.SendEmail;
import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.event.model.service.EventService;
import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.report.model.service.ReportService;

@Controller
@RequestMapping("/admin/*")
@SessionAttributes("msg")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private ReportService reportService;
	
	@Autowired
	private AskService askService;
	
	@Autowired
	private SendEmail sendEmail;
	
	@Autowired
	private EventService eventService;
	
	@RequestMapping("member")
	public String adminMain(Model model,
			@RequestParam(value="currentPage", required=false) Integer currentPage,
			@RequestParam(value="searchKey", required=false) String searchKey,
			@RequestParam(value="searchValue", required=false) String searchValue,
			HttpSession session, RedirectAttributes rdAttr
			) {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(!loginMember.getMemberGrade().equals("A")) {
			rdAttr.addFlashAttribute("msg", "관리자만 접근할 수 있습니다.");
			return "redirect:/";
		}
				
		try {
			Map<String, Object> map = null;
			if(searchKey != null && searchValue != null) {
				map = new HashMap<String, Object>();
				map.put("searchKey",searchKey);
				map.put("searchValue",searchValue);
			}
			int memberCount = adminService.adminMemberCount(map);
			//System.out.println("회원 수: " + memberCount);
			if(currentPage == null) currentPage = 1;
			
			PageInfo pInf = Pagination.getPageInfo(10, 10, currentPage, memberCount);
			
			List<Member> mList = adminService.adminSelectMember(map, pInf);
			
			model.addAttribute("pInf", pInf);
			model.addAttribute("mList", mList);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "admin/admin_member";
	}
	
	@RequestMapping("refund")
	public String refundTicket(Model model, Integer thisMemberNo, 
			Integer canceledTicket, HttpServletRequest request,
			RedirectAttributes rdAttr) {
		try {
			// 티켓 취소
			String beforeUrl = request.getHeader("referer"); // 이전 페이지 주소를 얻어옴.
			canceledTicket = -(canceledTicket);
			Map<String, Object> map = null;
			map = new HashMap<String, Object>();
			map.put("memberNo", thisMemberNo);
			map.put("ticket", canceledTicket);
			map.put("paymentType", "B");
			System.out.println("취소 티켓:" + canceledTicket);
			int result = adminService.refundTicket(map);
			if(result>0) {
				rdAttr.addFlashAttribute("msg", "환불 성공");
			}else {
				rdAttr.addFlashAttribute("msg", "환불 실패");
			}
			
			return "redirect:"+beforeUrl;
			
		}catch (Exception e) {
			e.printStackTrace();
			return "redirect:/";
		}
	}
	
	@ResponseBody
	@RequestMapping("delete")
	public String adminDelete(Integer memberNo, Model model) {
		try {
			return adminService.delete(memberNo) == 1 ? true + "" : false + "";
		}catch (Exception e) {
			e.printStackTrace();
			return "admin/admin_member";
		}
	}
	
	@ResponseBody
	@RequestMapping("recover")
	public String adminRecover(Integer memberNo, Model model) {
		try {
			return adminService.recover(memberNo) == 1 ? true + "" : false + "";
		}catch (Exception e) {
			e.printStackTrace();
			return "admin/admin_member";
		}
	}
	
	@RequestMapping("report")
	public String adminReport(Model model,
						@RequestParam(value="currentPage", required=false) Integer currentPage,
						@RequestParam(value="searchKey", required=false) String searchKey,
						@RequestParam(value="searchValue", required=false) String searchValue,
						HttpSession session, RedirectAttributes rdAttr
						) {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(!loginMember.getMemberGrade().equals("A")) {
			rdAttr.addFlashAttribute("msg", "관리자만 접근할 수 있습니다.");
			return "redirect:/";
		}
		try {
			Map<String, String> map = null;
			if(searchKey != null && searchValue != null) {
				map = new HashMap<String, String>();
				map.put("searchKey",searchKey);
				map.put("searchValue",searchValue);
			}
			int memberCount = reportService.adminReportCount(map);
			//System.out.println("회원 수: " + memberCount);
			if(currentPage == null) currentPage = 1;
			
			PageInfo pInf = Pagination.getPageInfo(10, 10, currentPage, memberCount);
			
			List<Member> rList = reportService.adminSelectReport(map, pInf);
			
			model.addAttribute("pInf", pInf);
			model.addAttribute("rList", rList);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "admin/admin_report";
	}
	
	@RequestMapping("ask")
	public String adminAsk(Model model,
						@RequestParam(value="currentPage", required=false) Integer currentPage,
						@RequestParam(value="searchKey", required=false) String searchKey,
						@RequestParam(value="searchValue", required=false) String searchValue,
						HttpSession session, RedirectAttributes rdAttr
						) {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(!loginMember.getMemberGrade().equals("A")) {
			rdAttr.addFlashAttribute("msg", "관리자만 접근할 수 있습니다.");
			return "redirect:/";
		}
		try {
			Map<String, String> map = null;
			if(searchKey != null && searchValue != null) {
				map = new HashMap<String, String>();
				map.put("searchKey",searchKey);
				map.put("searchValue",searchValue);
			}
			int askCount = askService.adminAskCount(map);
			//System.out.println("회원 수: " + memberCount);
			if(currentPage == null) currentPage = 1;
			
			PageInfo pInf = Pagination.getPageInfo(10, 10, currentPage, askCount);
			
			List<Member> aList = askService.adminSelectAsk(map, pInf);
			
			model.addAttribute("pInf", pInf);
			model.addAttribute("aList", aList);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "admin/admin_ask";
	}
	
	@RequestMapping("sendAnswer")
	public String adminSendAnswer(Model model, Ask ask, RedirectAttributes rdAttr) {
		try {
			// askNo, askEmail, memberId, askAnswer
            boolean send = sendEmail.send(ask.getAskEmail(), ask.getMemberId(), "1:1문의 답변입니다.", ask.getAskAnswer());
            int result = 0;
            String msg = null;
            if(send) {
            	result = askService.adminSendAnswer(ask);
            	if(result>0) {
            		msg = "답변이 전달되었습니다.";
            	} else msg = "답변 전달 실패";
            }
            rdAttr.addFlashAttribute("msg", msg);
            
            return "redirect:/admin/ask";
	     } catch (Exception e) {
            e.printStackTrace();
            return "common/errorPage.jsp";
	     }
	}
	
	@RequestMapping("event")
	public String adminEvent(Model model,
						@RequestParam(value="currentPage", required=false) Integer currentPage,
						@RequestParam(value="searchKey", required=false) String searchKey,
						@RequestParam(value="searchValue", required=false) String searchValue,
						HttpSession session, RedirectAttributes rdAttr
						) {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(!loginMember.getMemberGrade().equals("A")) {
			rdAttr.addFlashAttribute("msg", "관리자만 접근할 수 있습니다.");
			return "redirect:/";
		}
		try {
			Map<String, String> map = null;
			if(searchKey != null && searchValue != null) {
				map = new HashMap<String, String>();
				map.put("searchKey",searchKey);
				map.put("searchValue",searchValue);
			}
			int eventCount = eventService.adminEventCount(map);
			//System.out.println("회원 수: " + memberCount);
			if(currentPage == null) currentPage = 1;
			
			PageInfo pInf = Pagination.getPageInfo(10, 10, currentPage, eventCount);
			
			List<Member> eList = eventService.adminSelectEvent(map, pInf);
			
			model.addAttribute("pInf", pInf);
			model.addAttribute("eList", eList);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "admin/admin_event";
	}
	
}














