package com.kh.kkiri.home.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.connect.GoogleOAuth2Template;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.kh.kkiri.event.model.vo.Event;

import com.kh.kkiri.home.model.service.HomeService;
import com.kh.kkiri.member.controller.KakaoController;
import com.kh.kkiri.member.model.vo.Member;

@Controller
public class HomeController {
	
	
	@Autowired
	private HomeService homeService;
	
	@Autowired
	private KakaoController kakaoLogin;
	
	@Autowired
	private GoogleOAuth2Template googleOAuth2Template;
	
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;
	
	/**
	 * 메인 화면 로딩용 Controller
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpServletResponse response,
			HttpSession session) {
		
		try {
			
			// google_url 가져오는 로직
			String url = googleOAuth2Template.buildAuthenticateUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		    model.addAttribute("google_url", url);
			
		    // kakaoUrl
		    String kakaoUrl = kakaoLogin.getAuthorizationUrl(session);

		    /* 생성한 인증 URL을 View로 전달 */
		    model.addAttribute("kakao_url", kakaoUrl);
		    
		    // 이벤트 추천
		    List<Event> eventList = null;
			eventList = homeService.recommandEvent();
			int i = 0;
			for(Event ex : eventList) {
				System.out.println("eventList" + i++ + " : " + ex);
			}
			
			
			// 1주간 높은 평점을 받은 회원 목록
			int memberCount = homeService.selectMemberCount();
			
			if(memberCount > 5) {
				memberCount = 5;
			}
			
			List<Member> mlist = homeService.selectMemberList(memberCount);
			
			model.addAttribute("mlist", mlist);
			model.addAttribute("eventList",eventList);
			
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "메인 화면 로딩 과정 중 오류 발생");
			return "common/errorPage";
		}
		
		return "home";
	}
	
	
}
