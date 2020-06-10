package com.kh.kkiri.profile.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kh.kkiri.common.Pagination;
import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.event.model.vo.Chat;
import com.kh.kkiri.member.model.vo.Favorite;
import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.profile.model.service.ProfileService;
import com.kh.kkiri.search.model.vo.Search;

@Controller
@RequestMapping("/profile/*")
@SessionAttributes({"msg", "loginMember"})
public class ProfileController {
	
	@Autowired
	private ProfileService profileService;
	
	private int limit = 3;
	private int pagingBarSize = 5;
	
	// 유저 프로필 페이지 조회
	@RequestMapping("user")
	public String userProfile(int no,
								Model model,
								RedirectAttributes rdAttr,
								HttpServletRequest request,
								HttpSession session
								) {
		String beforeUrl = request.getHeader("referer");
		
		try {
			Member member = profileService.selectMember(no);
			
			if(member != null) {
				if(member.getMemberIntroduce() != null) {
					member.setMemberIntroduce(member.getMemberIntroduce().replace("<br>", "\r\n"));
				} else {
					member.setMemberIntroduce("자기소개 미입력");
				}
				member.setMemberGender(member.getMemberGender().replace("M", "남자"));
				member.setMemberGender(member.getMemberGender().replace("F", "여자"));
				
				Member loginMember  = (Member)session.getAttribute("loginMember");
				
				if(loginMember != null) {
					Favorite favorite = new Favorite(loginMember.getMemberNo(), no);
					
					int result = profileService.checkFavorite(favorite);
					model.addAttribute("checkFavorite", result);
				}
				
				model.addAttribute("member", member);
				
				return "member/userProfile";
			} else {
				rdAttr.addFlashAttribute("msg", "프로필 조회 실패");
				return "redirect:"+beforeUrl;
			}
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg","프로필 조회 과정에서 오류 발생");
			return "common/errorPage";
		}
	}
	
	// 이벤트 리스트 조회(ajax)
	@ResponseBody
	@RequestMapping(value = "eventList", produces= "application/json; charset=utf-8")
	public String eventList(@RequestParam(value="memberNo", required=false) Integer memberNo,
								@RequestParam(value="currentPage", required=false) Integer currentPage,
								@RequestParam(value="flag", required=false) Integer flag){
		
		List<Search> eList = profileService.selectEventList(memberNo, currentPage, limit, flag);
		
		int listCount = profileService.listCount(memberNo, flag);
		PageInfo pInf = Pagination.getPageInfo(3, 5, currentPage, listCount);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyyMMddHHmm").create();
	    HashMap<String, Object> map = new HashMap<String, Object>();
	    
	    map.put("eList", eList);
	    map.put("pInf", pInf);
	    
	    return gson.toJson(map);
	}
	
	// 좋아요 기능
	@ResponseBody
	@RequestMapping(value = "theLove", produces = "application/json; charset=utf-8")
	public String theLove(@RequestParam(value="memberNo", required=false) Integer memberNo,
							@RequestParam(value="favoriteNo", required=false) Integer favoriteNo) {
		Favorite favorite = new Favorite(memberNo, favoriteNo);
		
		// 좋아요 등록 1, 삭제 2
		int result = profileService.theLove(favorite);
		
		Gson gson = new GsonBuilder().create();
		
		return gson.toJson(result);
	}
	
}
