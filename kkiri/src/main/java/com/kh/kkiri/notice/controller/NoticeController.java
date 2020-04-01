package com.kh.kkiri.notice.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.kkiri.common.Pagination;
import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.notice.model.service.NoticeService;
import com.kh.kkiri.notice.model.vo.Notice;

@Controller
@RequestMapping("/notice/*")
@SessionAttributes({"loginMember","detailUrl","msg"})
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping("noticeList")
	public ModelAndView noticeList(ModelAndView mv,
			@RequestParam(value = "searchKey", required = false) String searchKey,
			@RequestParam(value = "searchValue", required = false) String searchValue,
			@RequestParam(value = "currentPage", required = false) Integer currentPage) {
	
		
		try {
			
			Map<String, String> map = null;
			if (searchKey != null && searchValue != null) {
				map = new HashMap<String, String>();
				// 맵 생성
				map.put("searchKey", searchKey);
				map.put("searchValue", searchValue);
			}
			
			int listCount = noticeService.getListCount(map);

			// 현재 페이지 계산
			if (currentPage == null)
				currentPage = 1;

			PageInfo pInf = Pagination.getPageInfo(10, 5, currentPage, listCount);
			
			List<Notice> list = noticeService.selectList(map, pInf);

			mv.addObject("list", list);
			mv.addObject("pInf", pInf);
			mv.setViewName("notice/noticeList");
			
			
			
			
		}catch (Exception e) {
			e.printStackTrace();
			mv.addObject("errorMsg", "공지사항 목록 조회중 오류 발생");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}
		
	
	
	// 공지사항 등록 이동
	@RequestMapping("insertForm")
	public String MoveToNotice(Model model) {
		
		return "notice/noticeInsert";
	}
	
	// 공지사항 등록
	@RequestMapping("insert")
	public String insertNotice(Notice notice, Model model, RedirectAttributes rdAttr) {
	
		Member loginMember = (Member)model.getAttribute("loginMember");
		
		//notice.setNoticeWriter(loginMember.getMemberId());
		
		try {
			// 공지사항 등록 서비스 호출
			int result = noticeService.insertNotice(notice);
			
			String msg = null;
			String url = null;
			
			System.out.println("결과"+ result);
			
			if(result > 0) { 
				msg = "공지사항 등록 성공";
			//	url = "detail?no="+result;
				url = "noticeList";
			}
			else {
				msg = "공지사항 등록 실패";
				//url = "list";
				url="notice";
			}
			rdAttr.addFlashAttribute("msg", msg);
			 return "redirect:" + url;
			// return "redirect:/";
			
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "공지사항 등록 과정에서 오류 발생");
			return "common/errorPage";
		}
	}
	 
	
	
	// 공지사항 상세보기
	@RequestMapping(value="detail", method = RequestMethod.GET)
	public String noticeDetail(Model model, Integer no, RedirectAttributes rdAttr ) {
		
		try {
			// 공지사항 상세 조회 서비스 호출
			Notice notice = noticeService.selectNotice(no);
			
			if(notice != null) { // DB 조회 결과가 있을 경우
				
				model.addAttribute("notice", notice);
				return "notice/noticeDetail";
			}else {
				rdAttr.addFlashAttribute("msg", "공지사항 상세조회 실패");
				return "redirect:list";
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "공지사항 상세 조회 과정에서 오류 발생");
			return "common/errorPage";
		}
	}
	
	
	
	
	
	
	
	// 공지사항 수정 화면 이동
	@RequestMapping("updateForm")
	public String updateForm(Integer no, HttpServletRequest request, Model model, RedirectAttributes rdAttr) {
		
		// 이전 페이지의 주소를 detailUrl에 저장
		String detailUrl = request.getHeader("referer");
		System.out.println("detailUrl : " + detailUrl);
		
		
		try {
			// 수정 화면에 보여질 게시글 내용 조회 서비스 호출
			Notice notice = noticeService.updateView(no);
			
			if(notice != null) {
				
				// @SessionAttributes에 "detailUrl" 등록하여 Session scope로 사용
				// --> update 화면에 출력될 이전 글 내용 조회 실패
				 //    또는 update 후  상세조회 화면으로 돌아올 때 사용할 수 있음.
				model.addAttribute("detailUrl", detailUrl);
				
				model.addAttribute("notice", notice);
				return "notice/noticeUpdate";
			}else {
				rdAttr.addFlashAttribute("msg", "공지사항 내용 조회 실패");
				
				return "redirect:"+detailUrl;
			}
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "공지사항 수정 화면으로 전환하는 과정에서 오류 발생");
			return "common/errorPage";
		}
		
	}
	
	
	
	// 공지사항 수정
		@RequestMapping("update")
		public String updateNotice(Integer no, Notice notice, Model model, RedirectAttributes rdAttr, HttpServletRequest request) {
			
			// session scope에서 detailUrl을 얻어옴
			String detailUrl = (String)model.getAttribute("detailUrl");
			notice.setNoticeNo(no);
			
			try {
				// 공지사항 수정용 Service 호출
				int result = noticeService.updatetNotice(notice);
				
				String msg = null;
				if(result > 0) 	msg = "공지사항이 수정되었습니다.";
				else 			msg = "공지사항 수정 실패";
				
				model.addAttribute("msg", msg);
				
				// 수정 후 상세조회 화면 요청
				return "redirect:"+detailUrl;
				
			}catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("errorMsg", "공지사항 수정 과정에서 오류 발생");
				return "common/errorPage";
			}
		}
		
		
		// 공지사항 삭제
		@RequestMapping("delete")
		public String deleteNotice(Integer no, Model model, HttpServletRequest request, RedirectAttributes rdAttr) {
			try {
				// 공지사항 삭제 서비스 호출
				int result = noticeService.deletetNotice(no);
				
				String msg = null;
				String url = null;
				if(result > 0) {
					msg = "공지사항이 삭제되었습니다.";
					url = "redirect:noticeList";
				}
				else {
					msg = "공지사항 수정 실패";
					
					// 이전페이지(상세조회 페이지) 주소 저장
					String oldUrl = request.getHeader("referer");
					url = "redirect:"+oldUrl;
				}
				
				rdAttr.addFlashAttribute("msg", msg);
				return url;
				
				
			}catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("errorMsg", "공지사항 삭제 과정에서 오류 발생");
				return "common/errorPage";
			}
		}
	
	
}
