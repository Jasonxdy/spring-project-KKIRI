package com.kh.kkiri.admin.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.kkiri.admin.model.service.AdminService;
import com.kh.kkiri.ask.model.service.AskService;
import com.kh.kkiri.ask.model.vo.Ask;
import com.kh.kkiri.common.FileRename;
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
			@RequestParam(value="delSort", required=false) String delSort,
			HttpSession session, RedirectAttributes rdAttr
			) {
		Enumeration<String> names = session.getAttributeNames();
		boolean flag = false;
		while(names.hasMoreElements()) {
			if(names.nextElement().toString().equals("loginMember")) {
				flag = true;
			}
		}
		if(flag) {
			Member loginMember = (Member)session.getAttribute("loginMember");
			if(!loginMember.getMemberGrade().equals("A")) {
				rdAttr.addFlashAttribute("msg", "관리자만 접근할 수 있습니다.");
				return "redirect:/";
			}
		}else {
			rdAttr.addFlashAttribute("msg", "로그인이 필요한 페이지 입니다.");
			return "redirect:/";
		}
				
		try {
			Map<String, Object> map = null;
			map = new HashMap<String, Object>();
			if(searchKey != null && searchValue != null) {
				map.put("searchKey",searchKey);
				map.put("searchValue",searchValue);
			}
			if(delSort != null) {
				map.put("delSort", delSort);
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
			model.addAttribute("errorMgs", "로그인 중 오류 발생");
			return "common/errorPage";
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
			model.addAttribute("errorMgs", "로그인 중 오류 발생");
			return "common/errorPage";
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
						@RequestParam(value="reportC", required=false) String reportC,
						HttpSession session, RedirectAttributes rdAttr
						) {
		Enumeration<String> names = session.getAttributeNames();
		boolean flag = false;
		while(names.hasMoreElements()) {
			if(names.nextElement().toString().equals("loginMember")) {
				flag = true;
			}
		}
		if(flag) {
			Member loginMember = (Member)session.getAttribute("loginMember");
			if(!loginMember.getMemberGrade().equals("A")) {
				rdAttr.addFlashAttribute("msg", "관리자만 접근할 수 있습니다.");
				return "redirect:/";
			}
		}else {
			rdAttr.addFlashAttribute("msg", "로그인이 필요한 페이지 입니다.");
			return "redirect:/";
		}
		try {
			Map<String, String> map = null;
			map = new HashMap<String, String>();
			if(searchKey != null && searchValue != null) {
				map.put("searchKey",searchKey);
				map.put("searchValue",searchValue);
			}
			if(reportC != null) {
				map.put("reportC", reportC);
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
			model.addAttribute("errorMgs", "로그인 중 오류 발생");
			return "common/errorPage";
		}
		
		return "admin/admin_report";
	}
	
	@RequestMapping("ask")
	public String adminAsk(Model model,
						@RequestParam(value="currentPage", required=false) Integer currentPage,
						@RequestParam(value="searchKey", required=false) String searchKey,
						@RequestParam(value="searchValue", required=false) String searchValue,
						@RequestParam(value="ansSort", required=false) String ansSort,
						HttpSession session, RedirectAttributes rdAttr
						) {
		Enumeration<String> names = session.getAttributeNames();
		boolean flag = false;
		while(names.hasMoreElements()) {
			if(names.nextElement().toString().equals("loginMember")) {
				flag = true;
			}
		}
		if(flag) {
			Member loginMember = (Member)session.getAttribute("loginMember");
			if(!loginMember.getMemberGrade().equals("A")) {
				rdAttr.addFlashAttribute("msg", "관리자만 접근할 수 있습니다.");
				return "redirect:/";
			}
		}else {
			rdAttr.addFlashAttribute("msg", "로그인이 필요한 페이지 입니다.");
			return "redirect:/";
		}
		try {
			Map<String, String> map = null;
			map = new HashMap<String, String>();
			if(searchKey != null && searchValue != null) {
				map.put("searchKey",searchKey);
				map.put("searchValue",searchValue);
			}
			if(ansSort != null) {
				map.put("ansSort", ansSort);
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
			model.addAttribute("errorMgs", "로그인 중 오류 발생");
			return "common/errorPage";
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
            model.addAttribute("errorMgs", "로그인 중 오류 발생");
			return "common/errorPage";
	     }
	}
	
	@RequestMapping("event")
	public String adminEvent(Model model,
						@RequestParam(value="currentPage", required=false) Integer currentPage,
						@RequestParam(value="searchKey", required=false) String searchKey,
						@RequestParam(value="searchValue", required=false) String searchValue,
						@RequestParam(value="eventStatus", required=false) String eventStatus,
						HttpSession session, RedirectAttributes rdAttr
						) {
		Enumeration<String> names = session.getAttributeNames();
		boolean flag = false;
		while(names.hasMoreElements()) {
			if(names.nextElement().toString().equals("loginMember")) {
				flag = true;
			}
		}
		if(flag) {
			Member loginMember = (Member)session.getAttribute("loginMember");
			if(!loginMember.getMemberGrade().equals("A")) {
				rdAttr.addFlashAttribute("msg", "관리자만 접근할 수 있습니다.");
				return "redirect:/";
			}
		}else {
			rdAttr.addFlashAttribute("msg", "로그인이 필요한 페이지 입니다.");
			return "redirect:/";
		}
		try {
			Map<String, String> map = null;
			map = new HashMap<String, String>();
			if(searchKey != null && searchValue != null) {
				map.put("searchKey",searchKey);
				map.put("searchValue",searchValue);
			}
			if(eventStatus != null) {
				map.put("eventStatus",eventStatus);
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
			model.addAttribute("errorMgs", "로그인 중 오류 발생");
			return "common/errorPage";
		}
		return "admin/admin_event";
	}
	
	@RequestMapping("management")
	public String adminManagement(Model model,HttpSession session,
			RedirectAttributes rdAttr, HttpServletRequest request) {
		Enumeration<String> names = session.getAttributeNames();
		boolean flag = false;
		while(names.hasMoreElements()) {
			if(names.nextElement().toString().equals("loginMember")) {
				flag = true;
			}
		}
		if(flag) {
			Member loginMember = (Member)session.getAttribute("loginMember");
			if(!loginMember.getMemberGrade().equals("A")) {
				rdAttr.addFlashAttribute("msg", "관리자만 접근할 수 있습니다.");
				return "redirect:/";
			}
		}else {
			rdAttr.addFlashAttribute("msg", "로그인이 필요한 페이지 입니다.");
			return "redirect:/";
		}
		
		try {
			String root = request.getSession().getServletContext().getRealPath("resources"); // c:로 시작하는 경로
			
			String savePath = root + "/uploadVideo";
			
			File path = new File(savePath);
			
			File[] fileList = path.listFiles();
			
			List<String> vList = new ArrayList<String>();
			
			if(fileList.length>0) {
				for(int i=0; i < fileList.length; i++) {
					vList.add(fileList[i].getName());
				}
			}
			model.addAttribute("vList", vList);
			
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "영상 조회 과정에서 오류 발생");
			return "common/errorPage";
		}
		return "admin/admin_management";
	}
	
	@RequestMapping("adminUploadVideo")
	public String adminUploadVideo(Model model, HttpServletRequest request,
			RedirectAttributes rdAttr,
			@RequestParam(value="inputVideo", required=false) MultipartFile inputVideo) {
		
		String root = request.getSession().getServletContext().getRealPath("resources"); // c:로 시작하는 경로
		
		String savePath = root + "/uploadVideo";
		
		File path = new File(savePath);
		
		
		if(!path.exists()) path.mkdir();
		
		String msg = null;
		
		int result = 0;
		try {
			String videoName = FileRename.rename(inputVideo.getOriginalFilename());
			
			inputVideo.transferTo(new File(savePath + "/" + videoName));
			
			File[] fileList = path.listFiles();
			if(fileList.length>0) {
				for(int i=0; i < fileList.length; i++) {
					if(fileList[i].getName().equals(videoName)) {
						result = 1;
					}
				}
			}
			if(result>0) msg = "영상 업로드 성공";
			else msg = "영상 업로드 실패";
			model.addAttribute("msg", msg);
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "영상 업로드 과정에서 오류 발생");
			return "common/errorPage";
		}
		return "redirect:/admin/management";
	}
	
	@RequestMapping("adminChangeVideo")
	public String adminChangeVideo(Model model, String changeVideo,
			HttpServletRequest request) {
		System.out.println(changeVideo);
		String root = request.getSession().getServletContext().getRealPath("resources"); // c:로 시작하는 경로
		String savePath = root + "/uploadVideo";
		File path = new File(savePath);
		boolean successRename = false;
		String msg = null;
		
		File[] fileList = path.listFiles();
		File mainVideo = new File(savePath + "/" + "mainVideo.mp4");
		File newVideo = new File(savePath + "/" + FileRename.rename("aaa.mp4"));
		if(fileList.length>0) {
			for(int i=0; i < fileList.length; i++) {
				if(fileList[i].getName().equals("mainVideo.mp4")) {
					successRename = fileList[i].renameTo(newVideo);
				} 
				if(fileList[i].getName().equals(changeVideo)) {
					successRename = fileList[i].renameTo(mainVideo);
				} 
			}
		}
		
		if(successRename) msg = "변경이 완료되었습니다.";
		else msg = "변경에 실패했습니다.";
		
		model.addAttribute("msg", msg);
		
		return "redirect:/";
	}
	
}














