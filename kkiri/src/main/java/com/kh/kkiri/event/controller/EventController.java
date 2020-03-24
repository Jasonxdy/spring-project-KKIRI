package com.kh.kkiri.event.controller;

import java.io.File;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kh.kkiri.common.FileRename;
import com.kh.kkiri.event.model.service.EventService;
import com.kh.kkiri.event.model.vo.Event;
import com.kh.kkiri.event.model.vo.Image;
import com.kh.kkiri.event.model.vo.Party;
import com.kh.kkiri.event.model.vo.Report;
import com.kh.kkiri.member.model.vo.Member;

@Controller
@SessionAttributes({ "loginMember", "msg", "myEventList", "detailUrl" })
@RequestMapping("/event/*")
public class EventController {

	@Autowired
	private EventService eventService;

	// 이벤트 상세 페이지 이동
	@RequestMapping("detail")
	public String eventDetail(@RequestParam(value = "no", required = false) Integer no, Model model,
			RedirectAttributes rdAttr) {
		
		int eventNo = 0;

//		테스트용으로 삭제 예정
		if (no != null) {
			eventNo = no;
		} else {
			eventNo = 99;
		}

		String msg = null;
		String url = null;

		try {

			// 이벤트 + 주최자 정보 얻어오기
			Event event = eventService.selectEvent(eventNo);

			// 이벤트 참석자 정보 얻어오기
			List<Member> partyList = eventService.selectPartyList(eventNo);
			
			// 로그인된 경우 해당 회원이 참석한 이벤트 목록 가져오기
			if(model.getAttribute("loginMember") != null) {
				List<Party> myEventList = eventService.selectMyEventList(((Member)model.getAttribute("loginMember")).getMemberNo());
				if(myEventList != null) {
					model.addAttribute("myEventList", myEventList);
				}
			}
			
			if (event != null) {

				model.addAttribute("event", event);
				model.addAttribute("partyList", partyList);
				url = "event/eventDetail";


			} else {
				msg = "이벤트 상세 페이지 조회 실패";
				rdAttr.addFlashAttribute("msg", msg);
				url = "redirect:/";
			}

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "이벤트 상세 페이지 조회 과정 중 오류 발생");
			return "common/errorPage.jsp";
		}
		return url;
	}

	
	// 회원 목록 이동
	@RequestMapping("selectParticipant")
	public String selectParticipant(@RequestParam(value = "no", required = false) Integer no, Model model,
			RedirectAttributes rdAttr) {

		int eventNo = 0;

//		테스트용으로 삭제 예정
		if (no != null) {
			eventNo = no;
		} else {
			eventNo = 99;
		}

		String msg = null;
		String url = null;

		try {

			// 이벤트 + 주최자 정보 얻어오기
			Event event = eventService.selectEvent(eventNo);

			// 이벤트 참석자 정보 얻어오기
			List<Member> partyList = eventService.selectInitPartyList(eventNo);
			
			// 로그인된 경우 해당 회원이 참석한 이벤트 목록 가져오기
			if(model.getAttribute("loginMember") != null) {
				List<Party> myEventList = eventService.selectMyEventList(((Member)model.getAttribute("loginMember")).getMemberNo());
				if(myEventList != null) {
					model.addAttribute("myEventList", myEventList);
				}
			}

			if (event != null) {

				model.addAttribute("event", event);
				model.addAttribute("partyList", partyList);
				url = "event/eventParticipant";


			} else {
				msg = "이벤트 상세 페이지 조회 실패";
				rdAttr.addFlashAttribute("msg", msg);
				url = "redirect:/";
			}

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "이벤트 상세 페이지 조회 과정 중 오류 발생");
			return "common/errorPage.jsp";
		}
		return url;
	}

	// 참가 회원 목록 추가 조회 (ajax)
	@ResponseBody
	@RequestMapping(value = "addPartyList",
    produces = "application/json; charset=utf-8")
	public String selectPartyList(int count, int limit, int eventNo, Model model, RedirectAttributes rdAttr) {
		List<Member> partyList = eventService.selectAddPartyList(count, limit, eventNo);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy년 MM월 dd일").create();
		return gson.toJson(partyList);
	}
	
	
	
	
	// 이벤트 참가 신청
	@RequestMapping("joinEvent")
	public String joinEvent (Party party, Model model, RedirectAttributes rdAttr, HttpServletRequest request) {
		String msg = null;
		String url = null;
		String detailUrl = request.getHeader("referer");
		model.addAttribute("detailUrl", detailUrl);
		
		try {
			int result = eventService.joinEvent(party);
			if(result > 0) {
				msg = "이벤트에 참가 신청되었습니다.";
//				url = "redirect:detail?no=" + party.getEventNo();
			} else {
				msg = "이벤트 참가 실패";
			}
			
			rdAttr.addFlashAttribute("msg", msg);
			return "redirect:" + detailUrl;
			
		} catch (Exception e) {
			e.printStackTrace();
			msg = "이벤트 참가 과정 중 오류 발생";
			model.addAttribute("msg", msg);
			return "common/errorPage";
		}
	}
	
	
	// 이벤트 승인 대기 취소
	@RequestMapping("cancelWaitEvent")
	@ResponseBody
	public int cancelWaitEvent(Party party) {
		
		int result =0;
		
		try {
			result = eventService.cancelWaitEvent(party);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			result = -1;
		}
		return result;
	}
	
	
	
	// 신고 등록
	@RequestMapping("insertReport")
	public String insertReport(Report report, Model model, RedirectAttributes rdAttr, HttpServletRequest request) {
		String msg;
		String detailUrl = request.getHeader("referer");
		model.addAttribute("detailUrl", detailUrl);
		
		if(report.getReportContent().equals("")) {
			report.setReportContent(" ");
		}
		try {
			int result = eventService.insertReport(report);
			
			if(result > 0) {
				msg = "이벤트가 신고되었습니다";
			} else {
				msg = "이벤트 신고 등록 실패";
			}
			
			rdAttr.addFlashAttribute("msg", msg);
			return "redirect:" + detailUrl;
			
		} catch (Exception e) {
			e.printStackTrace();
			msg = "이벤트 신고 과정 중 오류 발생";
			model.addAttribute("msg", msg);
			return "common/errorPage";
		}
	}
	
	
	// 이벤트 생성페이지로 이동(서진웅)
	@RequestMapping("goEventCreate")
	public String goEventCreate() {
		return "event/eventCreate";
	}
	
	// 이벤트 생성(서진웅)
	@RequestMapping("createEvent")
	public String createEvent(String startTime, String endTime,
			Event event, Model model, HttpServletRequest request,
			@RequestParam(value="thumbnailImg", required=false) MultipartFile thumbnailImg,
			RedirectAttributes rdAttr) {
		Member loginMember = (Member)model.getAttribute("loginMember");
		int eventCreator = loginMember.getMemberNo();
		
		startTime += ":00.00";
		endTime += ":00.00";
		
		Timestamp eventStart = (Timestamp.valueOf(startTime.replace("T"," ")));
		Timestamp eventEnd = (Timestamp.valueOf(endTime.replace("T"," ")));
		
		event.setEventStart(eventStart);
		event.setEventEnd(eventEnd);
		event.setMemberNo(eventCreator);
		event.setEventThumbnail(thumbnailImg.getOriginalFilename());
		
		String root = request.getSession().getServletContext().getRealPath("resources"); 
		String savePath = root + "/upEventThumbnail";
		File folder = new File(savePath);
		
		if(!folder.exists()) {
			folder.mkdir();
		}

		try {
			Image image = null;
			String changeFileName = null;
			if(!thumbnailImg.getOriginalFilename().equals("")) {
				
				changeFileName = FileRename.rename(thumbnailImg.getOriginalFilename());
				
				image = new Image(thumbnailImg.getOriginalFilename(), changeFileName);
			}
			
			event.setEventThumbnail(changeFileName);
			int result = eventService.createEvent(event,image);
			
			String url = null;
			if(result>0) { // DB에 게시글 삽입 성공시
				if(image!=null) {
					thumbnailImg.transferTo(new File(savePath + "/" + changeFileName));
				}
				model.addAttribute("eventNo",result);
				url = "event/insertEventComplete";
			}else {
				String msg = "이벤트 등록 실패";
				rdAttr.addFlashAttribute("msg", msg);
				url = "redirect:/";
			}
			return url;
			
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "이벤트 생성 과정 중 오류발생");
			return "common/errorPage";
		}
		
	}


}
