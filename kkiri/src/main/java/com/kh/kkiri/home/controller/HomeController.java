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
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.kkiri.event.model.vo.Event;
import com.kh.kkiri.home.model.service.HomeService;
import com.kh.kkiri.member.controller.KakaoController;
import com.kh.kkiri.member.controller.NaverController;
import com.kh.kkiri.member.model.vo.Member;

@Controller
@SessionAttributes({ "loginMember"})
public class HomeController {
	
	
	
	@Autowired
	private HomeService homeService;
	
	@Autowired
	private KakaoController kakaoLogin;
	
	@Autowired
	private GoogleOAuth2Template googleOAuth2Template;
	
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;
	
	@Autowired
	private NaverController naverController;
	
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
		    session.setAttribute("google_url", url);
			
		    // kakaoUrl
		    String kakaoUrl = kakaoLogin.getAuthorizationUrl(session);
		    
		    /* 생성한 인증 URL을 View로 전달 */
		    session.setAttribute("kakao_url", kakaoUrl);
		    
		    // naverUrl
		    String naverState = naverController.generateState();
//		    System.out.println("홈컨에서 검증 토큰: "+naverState);
		    session.setAttribute("naverState", naverState);
		    String naverUrl = "https://nid.naver.com/oauth2.0/authorize?client_id=LJUiiR8c6mrgWsanAhFZ&response_type=code&redirect_uri=http://localhost:8080/kkiri/member/naverLogin&state=" + naverState;
		    session.setAttribute("naverUrl", naverUrl);

		    
		    // 이벤트 추천
		    List<Event> eventList = null;
		    Member loginMember = (Member)model.getAttribute("loginMember");
		    if(loginMember==null) {
		    	eventList = homeService.recommandEvent();
		    }else {
		    	String memberLocation = (String)loginMember.getMemberPlace();
		    	String[] array = memberLocation.split("\\s");
		    	String memberPlace = array[0] + " " + array[1];
		    	System.out.println("memberPlace 출력 : " + memberPlace);
		    	eventList = homeService.recommandEventLogin(memberPlace);
		    }
			
			// 1주간 높은 평점을 받은 회원 목록
			int memberCount = homeService.selectMemberCount();
			
			if(memberCount > 5) {
				memberCount = 5;
			}
			
			List<Event> mlist = homeService.selectMemberList(memberCount);
			
			model.addAttribute("mlist", mlist);
			model.addAttribute("eventList",eventList);
			model.addAttribute("rankSize", mlist.size());
			
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "메인 화면 로딩 과정 중 오류 발생");
			return "common/errorPage";
		}
		
		return "home";
	}
	
	
}
