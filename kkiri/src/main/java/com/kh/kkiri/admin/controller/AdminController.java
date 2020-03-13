package com.kh.kkiri.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.kkiri.admin.model.service.AdminService;
import com.kh.kkiri.common.Pagination;
import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.member.model.vo.Member;

@Controller
@RequestMapping("/admin/*")
@SessionAttributes({"loginMember", "msg"})
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@RequestMapping("member")
	public String adminMain(Model model,
			@RequestParam(value="currentPage", required=false) Integer currentPage,
			@RequestParam(value="searchKey", required=false) String searchKey,
			@RequestParam(value="searchValue", required=false) String searchValue
			) {
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
	public String refundTicket(Model model, Integer memberNo, 
			Integer canceledTicket, HttpServletRequest request) {
		try {
			// 티켓 취소
			String beforeUrl = request.getHeader("referer"); // 이전 페이지 주소를 얻어옴.
			
			Map<String, Object> map = null;
			map = new HashMap<String, Object>();
			map.put("memberNo", memberNo);
			map.put("ticket", canceledTicket);
			map.put("paymentType", "B");
			System.out.println("취소 티켓:" + canceledTicket);
			int result = adminService.refundTicket(map);
			if(result>0) {
				model.addAttribute("msg", "환불 성공");
			}else {
				model.addAttribute("msg", "환불 실패");
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
	public String adminReport(Model model) {
		
		return "admin/admin_report";
	}
	
	
	
}














