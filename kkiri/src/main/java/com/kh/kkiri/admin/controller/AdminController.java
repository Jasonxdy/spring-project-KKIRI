package com.kh.kkiri.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.kkiri.admin.model.service.AdminService;
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
			@RequestParam(value="searchKey", required=false) Integer searchKey,
			@RequestParam(value="searchValue", required=false) Integer searchValue
			) {
		try {
			int memberCount = adminService.adminMemberCount();
			
			if(currentPage == null) currentPage = 1;
			
			List<Member> mList = adminService.adminSelectMember();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "admin/admin_member";
	}
}
