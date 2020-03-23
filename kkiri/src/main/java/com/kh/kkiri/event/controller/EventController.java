package com.kh.kkiri.event.controller;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kh.kkiri.event.model.service.EventService;
import com.kh.kkiri.event.model.vo.Event;
import com.kh.kkiri.event.model.vo.Party;
import com.kh.kkiri.member.model.vo.Member;

@Controller
@SessionAttributes({ "loginMember", "msg" })
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

			if (event != null) {

				model.addAttribute("event", event);

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

}
