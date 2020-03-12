package com.kh.kkiri.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
	public String adminMain() {
		try {
			List<Member> mList = adminService.adminSelectMember();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "admin/admin_member";
	}
}
