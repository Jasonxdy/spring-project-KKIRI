package com.kh.kkiri.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
}
