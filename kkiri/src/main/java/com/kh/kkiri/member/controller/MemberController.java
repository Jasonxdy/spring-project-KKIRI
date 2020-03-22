package com.kh.kkiri.member.controller;

import java.sql.Date;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.social.google.connect.GoogleOAuth2Template;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.kkiri.member.model.service.MemberService;
import com.kh.kkiri.member.model.vo.AuthInfo;
import com.kh.kkiri.member.model.vo.Member;


@SessionAttributes({ "loginMember", "msg" })

@Controller

@RequestMapping("/member/*")    //경로 수정할 수 있음!!!!! (3/12 일)

public class MemberController {

	
	@Autowired
	private MemberService memberService;
	
	@Inject
	private AuthInfo authInfo;
	
	@Autowired
	private GoogleOAuth2Template googleOAuth2Template;
	
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;
	
	
	// 6번 @세션 어트리뷰트 사용하기
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String signIn(Member member, Model model, HttpServletRequest request) {
		
		String beforeUrl = request.getHeader("referer");
		
		 System.out.println("입력 확인 :"+member.getMemberId()+ 
				 "/ " + member.getMemberPwd());
		
		try {
			
			Member loginMember = memberService.loginMember(member);
			
			System.out.println("로그인 확인 :"+loginMember);
		//	if( !bCryptPasswordEncoder.matches(member.getMemberPwd(), loginMember.getMemberPwd())) {
		//	//	loginMember = null;
		//	}
			
			if(loginMember !=null) {
				model.addAttribute("loginMember", loginMember);
				
			}else {
				
				model.addAttribute("msg", "비밀번호가 잘못되었습니다.");
			}
			
			return "redirect:" + beforeUrl;
			
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMgs","로그인 중 오류 발생" );
			return "common/errorPage";
			
		}
		
	}
	
	// 로그 아웃(태균)
	@RequestMapping("logout")
	public String logOut(SessionStatus status,HttpServletRequest request ) {
		
		String beforeUrl = request.getHeader("referer");
		status.setComplete();
		
		return "redirect:" + beforeUrl;
	}
	
	// 회원가입 이동
	@RequestMapping("signUp")
	public String signUp() {
		return "member/signUp";
	}
	
	// 회원 가입
	@RequestMapping("createId")  //바뀔 쑤 있음 ㅎㅎ 
	public String createId(Member member, Model model,
							String memberLocation,
							String memberPhone1, String memberPhone2, String memberPhone3,
							@RequestParam(value="memberInterest")
							String[] interest,
							String memberBankName, String memberBankNumber, String memberAccountName
											) {
		System.out.println("0. 확인");
		String memberPhone = memberPhone1 + "-"+  memberPhone2 + "-" + memberPhone3;
		
		String memberCategory = null;
		String memberAcount = memberBankName + "," + memberBankNumber + "," + memberAccountName;
		if(interest != null) {
			memberCategory = String.join(",",interest);	
		}
		
		
		
		
		Member createMember = new Member(
										member.getMemberId(),
										member.getMemberNickname(),
										member.getMemberPwd(),
										member.getMemberEmail(),
										member.getMemberGender(),
										memberPhone,
										member.getMemberBirth(),
										member.getMemberIntroduce(),
										memberLocation,
										memberCategory,
										memberAcount
										
				);
		System.out.println("1. 로그인:" + createMember);
		try {
			
			int result = memberService.createId(createMember);
			
			String msg = null;
			if(result > 0) msg = "가입 성공";
			else           msg = "가입 실패";
			
			model.addAttribute("msg", msg);
			
			return "redirect:/";
			
		}catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg","회원 가입 중 문제 발생");
			return "common/errorPage";
		}
		
		
		
		
		
	}
	
	// 회원 가입 페이지
    @RequestMapping(value = "googleSignUp", method = { RequestMethod.GET, RequestMethod.POST })
    public String join(HttpServletResponse response, Model model) {
 
        //URL을 생성한다.
        String url = googleOAuth2Template.buildAuthenticateUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
        System.out.println("/googleLogin, url : " + url);
        model.addAttribute("google_url", url);
 
        return "member/googleLogin";
    }
	
    @RequestMapping(value = "/googleLogin")
    public String doSessionAssignActionPage(HttpServletRequest request, Model model) throws Exception {
 
        String code = request.getParameter("code");
        System.out.println(code);
        
        //RestTemplate을 사용하여 Access Token 및 profile을 요청한다.
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
        parameters.add("code", code);
        parameters.add("client_id", authInfo.getClientId());
        parameters.add("client_secret", authInfo.getClientSecret());
        parameters.add("redirect_uri", googleOAuth2Parameters.getRedirectUri());
        parameters.add("grant_type", "authorization_code");
 
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String, String>>(parameters, headers);
        ResponseEntity<Map> responseEntity = restTemplate.exchange("https://www.googleapis.com/oauth2/v4/token", HttpMethod.POST, requestEntity, Map.class);
        Map<String, Object> responseMap = responseEntity.getBody();
 
        // id_token 라는 키에 사용자가 정보가 존재한다.
        // 받아온 결과는 JWT (Json Web Token) 형식으로 받아온다. 콤마 단위로 끊어서 첫 번째는 현 토큰에 대한 메타 정보, 두 번째는 우리가 필요한 내용이 존재한다.
        // 세번째 부분에는 위변조를 방지하기 위한 특정 알고리즘으로 암호화되어 사이닝에 사용한다.
        //Base 64로 인코딩 되어 있으므로 디코딩한다.
 
        String[] tokens = ((String)responseMap.get("id_token")).split("\\.");
        Base64 base64 = new Base64(true);
        String body = new String(base64.decode(tokens[1]));
        
        String googleInform = new String(Base64.decodeBase64(tokens[1]), "utf-8");
        
        System.out.println(tokens.length);
        System.out.println(new String(Base64.decodeBase64(tokens[0]), "utf-8"));
        System.out.println(googleInform);
 
        //Jackson을 사용한 JSON을 자바 Map 형식으로 변환
        ObjectMapper mapper = new ObjectMapper();
        Map<String, String> result = mapper.readValue(body, Map.class);
        System.out.println(result.get(""));
        
        String[] signUpInform = googleInform.split(",");
        
        for(int i=0; i<signUpInform.length; i++) {
        	System.out.println(i +"번째 정보: " + signUpInform[i]);
        }
        
        String memberId = signUpInform[3].substring(7, signUpInform[3].length()-1);
        String memberNickname = "KKIRI의 별명"; // 뒷부분은 DB에서 sequence로 처리
        String memberPwd = signUpInform[6];
        String memberEmail = signUpInform[4].substring(9, signUpInform[4].length()-1);
        String memberGender = "M"; // 일단 남성. DB에서 null 가능으로 변경 필요.
        String memberPhone = "010-0000-0000"; // DB에서 default값 혹은 null 가능으로 변경
        String memberPlace = "설정해주세요";
        String memberCategory = "설정해주세요";
        
        System.out.println("비밀번호 값: "+memberPwd);
        System.out.println("email값: "+memberEmail);
        
//        int memberNo;			MEM_SEQ.NEXTVAL
//    	String memberId;		sub: 모든 Google 계정에서 고유하며 재사용되지 않은 사용자의 식별자
//    	String memberNickname;	중복되지 않는 임의의 값
//    	String memberPwd;		특정 임의의 값
//    	String memberEmail;		Google제공 email
//    	String memberGender;	일단 남자
//    	String memberPhone;		임의의 값
//    	Date memberBirth;		임의의 값(SYSDATE)
//    	String memberIntroduce;	null
//    	String memberPlace;		특정 값
//    	String memberCategory;	특정 값
//    	String memberProfile;	default
//    	Date memberSignupDate;	default
//    	String memberGrade;		default
//    	int memberTicket;		default
//    	String memberAccount;	null
//    	String memberIdSort;	G
//    	String memberStatus;	default
//    	double memberRating;	
        Member googleMember = new Member(memberId, memberNickname, memberPwd, 
        		memberEmail, memberGender, memberPhone, memberPlace, memberCategory);
        
        
        try {
        	Member signUpCheck = memberService.checkGoogleId(memberId); // 이미 가입된 계정인지 체크
        	
        	if(signUpCheck != null) {
        		model.addAttribute("loginMember", signUpCheck);
        	}else {
        		int signUpResult = memberService.googleSignUp(googleMember);
        		if(signUpResult>0) {
        			Member loginMember = memberService.checkGoogleId(memberId);
        			model.addAttribute("loginMember", loginMember);
        		} else {
        			model.addAttribute("msg", "회원 가입 실패");
        		}
        	}
        	
        } catch(Exception e) {
        	e.printStackTrace();
        }
        
        return "redirect:/";
 
    }
	
	
	
	
}
















