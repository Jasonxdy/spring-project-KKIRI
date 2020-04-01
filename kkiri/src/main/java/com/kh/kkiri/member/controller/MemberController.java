package com.kh.kkiri.member.controller;

import java.io.File;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.kkiri.common.FileRename;
import com.kh.kkiri.common.SendEmail;
import com.kh.kkiri.member.model.service.MemberService;
import com.kh.kkiri.member.model.vo.AuthInfo;
import com.kh.kkiri.member.model.vo.Member;

@Controller

@RequestMapping("/member/*") // 경로 수정할 수 있음!!!!! (3/12 일)

@SessionAttributes({ "loginMember", "msg" })
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private KakaoController kakaoLogin;
	
	@Autowired
	private NaverController naverLogin;

	@Inject
	private AuthInfo authInfo;

	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;
	
	@Autowired
	private SendEmail sendEmail;

	// 6번 @세션 어트리뷰트 사용하기
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String signIn(Member member, Model model, 
			HttpServletRequest request, HttpServletResponse response) {

		String memberId = request.getParameter("memberId");  // 쿠키 아이디
		String beforeUrl = request.getHeader("referer");

		System.out.println(member);

		try {

			Member loginMember = memberService.loginMember(member);

			System.out.println("로그인 확인 :" + loginMember);
			// if( !bCryptPasswordEncoder.matches(member.getMemberPwd(),
			// loginMember.getMemberPwd())) {
			// // loginMember = null;
			// }

			// 쿠키
			HttpSession session = request.getSession();
			
			System.out.println("세션 : " + session );
			
			if (loginMember != null) {
				if(!loginMember.getMemberPwd().equals("")) {
					model.addAttribute("msg", "비밀번호가 잘못되었습니다.");
				}else {
				session.setMaxInactiveInterval(300); // 세션 만료 5분
				String save = request.getParameter("memberId");
				Cookie cookie = new Cookie("rememberId", memberId);
					System.out.println("쿠키" + memberId);	
					
					if(save !=null) {
						System.out.println("세이브 확인 : "+ save);
						cookie.setMaxAge(60*60*24); // 하루
					}else {
						cookie.setMaxAge(0);
					}
					cookie.setPath("/");
					response.addCookie(cookie);
					
					model.addAttribute("loginMember", loginMember);
					System.out.println("쿠키2" + cookie);	
				}
			} else {

				model.addAttribute("msg", "아이디가 잘못되었습니다.");
			}

			return "redirect:" + beforeUrl;

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMgs", "로그인 중 오류 발생");
			return "common/errorPage";

		}

	}

	// 로그 아웃(태균)
	@RequestMapping("logout")
	public String logOut(SessionStatus status) {

		status.setComplete();

		return "redirect:/";
	}

	// 회원가입 이동
	@RequestMapping("signUp")
	public String signUp() {
		return "member/signUp";
	}

	// 회원 가입
	@RequestMapping("createId") // 바뀔 쑤 있음 ㅎㅎ
	public String createId(Member member, Model model, String memberLocation, String memberPhone1, String memberPhone2,
			String memberPhone3, @RequestParam(value = "memberInterest") String[] interest, String memberBankName,
			String memberBankNumber, String memberAccountName, HttpServletRequest request, RedirectAttributes rdAttr,
			@RequestParam(value = "uploadProfile", required = true) MultipartFile uploadProfile) {

		String root = request.getSession().getServletContext().getRealPath("resources");

		String savePath = root + "/upProfileImage";
		File folder = new File(savePath);

		if (!folder.exists())
			folder.mkdir();

		System.out.println("0. 확인");
		String memberPhone = memberPhone1 + "-" + memberPhone2 + "-" + memberPhone3;

		String memberCategory = null;
		String memberAcount = memberBankName + "," + memberBankNumber + "," + memberAccountName;
		if (interest != null) {
			memberCategory = String.join(",", interest);

		}

		Member createMember = new Member(member.getMemberId(), member.getMemberNickname(), member.getMemberPwd(),
				member.getMemberEmail(), member.getMemberGender(), memberPhone, member.getMemberBirth(),
				member.getMemberIntroduce(), memberLocation, memberCategory, memberAcount

		);

		System.out.println("1. 로그인:" + createMember);

		try {
			String changeFileName = null;

			if (!uploadProfile.getOriginalFilename().equals("")) {
				// thumbnail이 등록된 경우

				// 파일명 rename
				changeFileName = FileRename.rename(uploadProfile.getOriginalFilename());

				createMember.setMemberProfile(changeFileName);
			}

			int result = memberService.createId(createMember);

			String msg = null;

			// if(result > 0) msg = "가입 성공";
			// else msg = "가입 실패";
			// model.addAttribute("msg", msg);

			if (result > 0) {
				if (createMember.getMemberProfile() != null) {
					uploadProfile.transferTo(new File(savePath + "/" + changeFileName));
				}
				msg = "가입 성공";

			} else {
				msg = "가입 실패";
			}

			rdAttr.addFlashAttribute("msg", msg);
			/* return "redirect:/signUpComplete"; */
			return "member/signUpComplete";

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "회원 가입 중 문제 발생");
			return "common/errorPage";
		}

	}

	// 아이디 중복 검사
	 @ResponseBody
	 @RequestMapping("idUniqueCheck")
	 public String idUniqueCheck(String memberId,Model model ) {
		  
		  try {
			  return memberService.idUniqueCheck(memberId) == 0 ? true+"" : false+"";
			  						// 서비스 인터페이스 -> 임플 -> 
		  }catch(Exception e) {
			  e.printStackTrace();
			  model.addAttribute("errorMsg","아이디 중복 체크 중 오류 발생");
			  return "common/errorPage";
		  }
	  }
	
	@ResponseBody
	@RequestMapping("memberNickUnique")
	public String memberNickUnique(String memberNickname,Model model ) {
		  
		  try {
			  return memberService.memberNickUnique(memberNickname) == 0 ? true+"" : false+"";
			  						// 서비스 인터페이스 -> 임플 -> 
		  }catch(Exception e) {
			  e.printStackTrace();
			  model.addAttribute("errorMsg","닉네임 중복 체크 중 오류 발생");
			  return "common/errorPage";
		  }
	  }

	
	@ResponseBody
	@RequestMapping("memberEmailUnique")
	public String memberEmailUnique(String memberEmail,Model model ) {
		  
		  try {
			  return memberService.memberEmailUnique(memberEmail) == 0 ? true+"" : false+"";
			  						// 서비스 인터페이스 -> 임플 -> 
		  }catch(Exception e) {
			  e.printStackTrace();
			  model.addAttribute("errorMsg","닉네임 중복 체크 중 오류 발생");
			  return "common/errorPage";
		  }
	  }
	
	
	
	
	
	// 회원 가입 페이지
//    @RequestMapping(value = "googleUrl", method = { RequestMethod.GET, RequestMethod.POST })
//    public String googleLogin(HttpServletResponse response, Model model) {
// 
//        //URL을 생성한다.
//        String url = googleOAuth2Template.buildAuthenticateUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
//        model.addAttribute("google_url", url);
//        System.out.println("/googleLogin, url : " + url);
//        model.addAttribute("googleUrl", "true");
//        
//        return "redirect:/";
//    }

	@RequestMapping(value = "/googleLogin")
	public String doSessionAssignActionPage(HttpServletRequest request, Model model, RedirectAttributes rdAttr) {
		String beforeUrl = request.getHeader("referer");
		try {
			String code = request.getParameter("code");
			String msg = null;
			// System.out.println(code);

			// RestTemplate을 사용하여 Access Token 및 profile을 요청한다.
			RestTemplate restTemplate = new RestTemplate();
			MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
			parameters.add("code", code);
			parameters.add("client_id", authInfo.getClientId());
			parameters.add("client_secret", authInfo.getClientSecret());
			parameters.add("redirect_uri", googleOAuth2Parameters.getRedirectUri());
			parameters.add("grant_type", "authorization_code");

			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
			HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String, String>>(
					parameters, headers);
			ResponseEntity<Map> responseEntity = restTemplate.exchange("https://www.googleapis.com/oauth2/v4/token",
					HttpMethod.POST, requestEntity, Map.class);
			Map<String, Object> responseMap = responseEntity.getBody();

			// id_token 라는 키에 사용자가 정보가 존재한다.
			// 받아온 결과는 JWT (Json Web Token) 형식으로 받아온다. 콤마 단위로 끊어서 첫 번째는 현 토큰에 대한 메타 정보, 두
			// 번째는 우리가 필요한 내용이 존재한다.
			// 세번째 부분에는 위변조를 방지하기 위한 특정 알고리즘으로 암호화되어 사이닝에 사용한다.
			// Base 64로 인코딩 되어 있으므로 디코딩한다.

			String[] tokens = ((String) responseMap.get("id_token")).split("\\.");
			Base64 base64 = new Base64(true);
			String body = new String(base64.decode(tokens[1]));

			String googleInform = new String(Base64.decodeBase64(tokens[1]), "utf-8");

			// System.out.println(tokens.length);
			// System.out.println(new String(Base64.decodeBase64(tokens[0]), "utf-8"));
			// System.out.println(googleInform);

			// Jackson을 사용한 JSON을 자바 Map 형식으로 변환
			ObjectMapper mapper = new ObjectMapper();
			Map<String, String> result = mapper.readValue(body, Map.class);
			// System.out.println(result.get(""));

			String[] signUpInform = googleInform.split(",");

//	        for(int i=0; i<signUpInform.length; i++) {
//	        	System.out.println(i +"번째 정보: " + signUpInform[i]);
//	        }

			String memberId = signUpInform[3].substring(7, signUpInform[3].length() - 1);
			String memberNickname = "KKIRI의 별명"; // 뒷부분은 DB에서 sequence로 처리
			String memberPwd = signUpInform[6];
			String memberEmail = signUpInform[4].substring(9, signUpInform[4].length() - 1);
			String memberGender = "M"; // 일단 남성. DB에서 null 가능으로 변경 필요.
			String memberPhone = "010-0000-0000"; // DB에서 default값 혹은 null 가능으로 변경
			String memberPlace = "설정해 주세요";
			String memberCategory = "설정해 주세요";
			String memberIdSort = "G";

//        System.out.println("비밀번호 값: "+memberPwd);
//        System.out.println("email값: "+memberEmail);

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
			Member socialMember = new Member(memberId, memberNickname, memberPwd, memberEmail, memberGender,
					memberPhone, memberPlace, memberCategory, memberIdSort);

			// email 중복 체크
			Member checkSocailEmail = memberService.checkSocialEmail(memberEmail);
			if (checkSocailEmail != null) {
				if (checkSocailEmail.getMemberStatus().equals("N")) {
					msg = "탈퇴된 회원의 email과 중복됩니다. 1:1문의를 남겨주세요.";
					rdAttr.addFlashAttribute("msg", msg);
					return "redirect:/";
				} else {
					switch (checkSocailEmail.getMemberIdSort()) {
					case "N":
						msg = "KKIRI ID로 가입되어 있는 email입니다";
						rdAttr.addFlashAttribute("msg", msg);
						return "redirect:/";
					case "K":
						msg = "kakao로 가입되어 있는 email입니다.";
						rdAttr.addFlashAttribute("msg", msg);
						return "redirect:/";
					case "V":
						msg = "naver로 가입되어 있는 email입니다.";
						rdAttr.addFlashAttribute("msg", msg);
						return "redirect:/";
					}
				}
			}

			// 아이디 중복 체크 + 로그인 + 회원가입
			Member loginMember = memberService.checkSocialId(memberId); // 이미 가입된 계정인지 체크
			if (loginMember != null) {
				model.addAttribute("loginMember", loginMember);
			} else {
				int signUpResult = memberService.socialSignUp(socialMember);
				if (signUpResult > 0) {
					loginMember = memberService.checkSocialId(memberId);
					model.addAttribute("loginMember", loginMember);
				} else {
					msg = "회원 가입 실패";
					rdAttr.addFlashAttribute("msg", msg);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMgs", "로그인 중 오류 발생");
			return "common/errorPage";
		}
		
		if(beforeUrl != null) return "redirect:" + beforeUrl;
		else return "redirect:/";

	}

	@RequestMapping(value = "/kakaoLogin")
	public String getKakaoSignIn(ModelMap model, @RequestParam("code") String code, HttpSession session,
			RedirectAttributes rdAttr, HttpServletRequest request) {
		try {
			JsonNode userInfo = kakaoLogin.getKakaoUserInfo(code);
			String msg = null;
//			System.out.println(userInfo);
			String memberEmail = null;
			String memberGender = null;
			if(userInfo.findValue("email") != null) {
				memberEmail = userInfo.get("kakao_account").get("email").toString().replaceAll("\"", "");
			}else {
				System.out.println("email: "+userInfo.findValue("email"));
				msg = "Email 제공에 동의해야 합니다. https://accounts.kakao.com/ 에서 연결을 끊고 다시 시도해주세요.";
				rdAttr.addFlashAttribute("msg", msg);
				return "redirect:/";
			}
			String memberId = userInfo.get("id").toString();
			String memberNickname = userInfo.get("properties").get("nickname").toString().replaceAll("\"", "");
			String memberPwd = userInfo.get("connected_at").toString();
			if(userInfo.findValue("gender") != null) {
				memberGender = userInfo.get("kakao_account").get("gender").toString().replaceAll("\"", "");
			}
			if (memberGender.equals("male"))
				memberGender = "M";
			else if (memberGender.equals("female"))
				memberGender = "Y";
			else memberGender = "M";
//			System.out.println("memberId: " + memberId);
//			System.out.println("memberNickname: " + memberNickname);
//			System.out.println("memberEmail: " + memberEmail);
//			System.out.println("memberGender: " + memberGender);
			String memberPhone = "010-0000-0000"; // DB에서 default값 혹은 null 가능으로 변경
			String memberPlace = "설정해 주세요";
			String memberCategory = "설정해 주세요";
			String memberIdSort = "K";
//      String birth = userInfo.get("kakao_account").get("birthday").toString();
//      String image = userInfo.get("properties").get("profile_image").toString();

//      String memberId = signUpInform[3].substring(7, signUpInform[3].length()-1);
//      String memberNickname = "KKIRI의 별명"; // 뒷부분은 DB에서 sequence로 처리
//      String memberPwd = signUpInform[6];
//      String memberEmail = signUpInform[4].substring(9, signUpInform[4].length()-1);
//      String memberGender = "M"; // 일단 남성. DB에서 null 가능으로 변경 필요.
//      String memberPhone = "010-0000-0000"; // DB에서 default값 혹은 null 가능으로 변경
//      String memberPlace = "설정해주세요";
//      String memberCategory = "설정해주세요";
			Member socialMember = new Member(memberId, memberNickname, memberPwd, memberEmail, memberGender,
					memberPhone, memberPlace, memberCategory, memberIdSort);

			// email 중복 체크
			Member checkSocailEmail = memberService.checkSocialEmail(memberEmail);
			if (checkSocailEmail != null) {
				if (checkSocailEmail.getMemberStatus().equals("N")) {
					msg = "탈퇴된 회원의 email과 중복됩니다. 1:1문의를 남겨주세요.";
					rdAttr.addFlashAttribute("msg", msg);
					return "redirect:/";
				} else {
					switch (checkSocailEmail.getMemberIdSort()) {
					case "N":
						msg = "KKIRI ID로 가입되어 있는 email입니다";
						rdAttr.addFlashAttribute("msg", msg);
						return "redirect:/";
					case "G":
						msg = "google로 가입되어 있는 email입니다.";
						rdAttr.addFlashAttribute("msg", msg);
						return "redirect:/";
					case "V":
						msg = "naver로 가입되어 있는 email입니다.";
						rdAttr.addFlashAttribute("msg", msg);
						return "redirect:/";
					}
				}
			}

			// 아이디 중복 체크 + 로그인 + 회원가입
			Member loginMember = memberService.checkSocialId(memberId); // 이미 가입된 계정인지 체크
			if (loginMember != null) {
				model.addAttribute("loginMember", loginMember);
			} else {
				int signUpResult = memberService.socialSignUp(socialMember);
				if (signUpResult > 0) {
					loginMember = memberService.checkSocialId(memberId);
					model.addAttribute("loginMember", loginMember);
				} else {
					msg = "회원 가입 실패";
					rdAttr.addFlashAttribute("msg", msg);
				}
			}
		}

		catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMgs", "로그인 중 오류 발생");
			return "common/errorPage";
		}

		return "redirect:/";
	}
	
	@RequestMapping("naverLogin")
	public String naverLogin(Model model, String state, String code, HttpSession session,
			RedirectAttributes rdAttr, HttpServletRequest request) {
		// session에 올려둔 상태 토큰을 HomeController에 등록한 url에서 요청한 상태 토큰과 검증
		String storedState = (String)session.getAttribute("naverState");
		// 이전 페이지 url 저장
		if(!state.equals(storedState)) { // 검증이 불일치하면 
			session.setAttribute("msg", "검증 토큰 불일치!");
			return "redirect:/";
		} else { // 검증이 일치할 때
			try {
				// JsonNode 형식으로 받은 userInfo
				JsonNode userInfo = naverLogin.getNaverUserInfo(code, session);
				String msg = null;
				System.out.println(userInfo);
				
				// JsonNode에 접근하는 메소드 get을 이용
				// get(키값)은 value를 반환. 다만 ""가 같이 나옴
				// reponse 내부에 id를 찾아서 String으로 변환
				String memberId = userInfo.get("response").get("id").toString();
				String memberNickname = userInfo.get("response").get("nickname").toString().replaceAll("\"", "");
				String memberEmail = userInfo.get("response").get("email").toString().replaceAll("\"", "");
				String memberPwd = userInfo.get("resultcode").toString();
				String memberGender = userInfo.get("response").get("gender").toString().replaceAll("\"", "");
				String memberPhone = "010-0000-0000"; // DB에서 default값 혹은 null 가능으로 변경
				String memberPlace = "설정해 주세요";
				String memberCategory = "설정해 주세요";
				String memberIdSort = "V";
				
				Member socialMember = new Member(memberId, memberNickname, memberPwd, memberEmail, memberGender,
						memberPhone, memberPlace, memberCategory, memberIdSort);

				// email 중복 체크
				Member checkSocailEmail = memberService.checkSocialEmail(memberEmail);
				if (checkSocailEmail != null) {
					if (checkSocailEmail.getMemberStatus().equals("N")) {
						msg = "탈퇴된 회원의 email과 중복됩니다. 1:1문의를 남겨주세요.";
						rdAttr.addFlashAttribute("msg", msg);
						return "redirect:/";
					} else {
						switch (checkSocailEmail.getMemberIdSort()) {
						case "N":
							msg = "KKIRI ID로 가입되어 있는 email입니다";
							rdAttr.addFlashAttribute("msg", msg);
							return "redirect:/";
						case "G":
							msg = "google로 가입되어 있는 email입니다.";
							rdAttr.addFlashAttribute("msg", msg);
							return "redirect:/";
						case "K":
							msg = "kakao로 가입되어 있는 email입니다.";
							rdAttr.addFlashAttribute("msg", msg);
							return "redirect:/";
						}
					}
				}

				// 아이디 중복 체크 + 로그인 + 회원가입
				Member loginMember = memberService.checkSocialId(memberId); // 이미 가입된 계정인지 체크
				if (loginMember != null) {
					model.addAttribute("loginMember", loginMember);
				} else {
					int signUpResult = memberService.socialSignUp(socialMember);
					if (signUpResult > 0) {
						loginMember = memberService.checkSocialId(memberId);
						model.addAttribute("loginMember", loginMember);
					} else {
						msg = "회원 가입 실패";
						rdAttr.addFlashAttribute("msg", msg);
					}
				}
			}
			catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("errorMgs", "로그인 중 오류 발생");
				return "common/errorPage";
			}
			return "redirect:/";
		}
	}
	
	@ResponseBody
	@RequestMapping("emailConfirm")
	public String emailConfirm(HttpSession session, String email) {
		StringBuffer sb = new StringBuffer();
		for(int i=0 ; i<6 ; i++) {
			sb.append((int)(Math.random()*10));
		}
		String confirmNo = sb.toString();
		session.setAttribute("confirmNo", confirmNo);
		boolean result = sendEmail.send(email, "회원님", "KKIRI 이메일 인증", "인증번호: "+confirmNo);
		
		if(result) return confirmNo;
		else return "false";
	}
	
	@RequestMapping("findMember")
	public String findMember () {
		
		return "member/findID";
	}
	
	@RequestMapping("findId")
	public String findId(Model model, String findIdEmail, 
			RedirectAttributes rdAttr, HttpSession session) {
		String msg = null;
		try {
			Member findMember = memberService.findId(findIdEmail);
			if(findMember != null) {
				switch(findMember.getMemberIdSort()) {
				case "N":
					boolean result = sendEmail.send(findIdEmail, "회원님", "KKIRI 아이디 찾기", 
							"회원님의 아이디는 " + findMember.getMemberId() + " 입니다.");
					if(result) msg = findIdEmail + "로 아이디가 발송되었습니다.";
					else msg = "이메일 발송 실패!";
					rdAttr.addFlashAttribute("msg", msg);
					return "redirect:/";
				case "G":
					msg = "google로 가입되어 있는 email입니다.";
					//rdAttr.addFlashAttribute("msg", msg);
					//return "redirect:/";
					break;
				case "K":
					msg = "kakao로 가입되어 있는 email입니다.";
					//rdAttr.addFlashAttribute("msg", msg);
					//return "redirect:/";
					break;
				case "V":
					msg = "naver로 가입되어 있는 email입니다.";
					//rdAttr.addFlashAttribute("msg", msg);
					//return "redirect:/";
					break;
				}
			}else {
				msg = "해당 이메일로 가입되어 있는 아이디가 없습니다.";
				session.setAttribute("msg", msg);
				return "redirect:/member/findMember";
			}
			session.setAttribute("msg", msg);
		}catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMgs", "아이디 찾기 중 오류 발생");
			return "common/errorPage";
		}
		
		return "redirect:/member/findMember";
	}
	
	@RequestMapping("findPwd")
	public String findPwd(Model model, Member member, 
			RedirectAttributes rdAttr, HttpSession session) {
		String msg = null;
		try {
			Member findMember = memberService.findPwd(member);
			if(findMember != null) {
				switch(findMember.getMemberIdSort()) {
				case "N":
					boolean result = sendEmail.send(member.getMemberEmail(),
							member.getMemberId()+"회원님", "KKIRI 비밀번호 찾기", 
							"회원님의 비밀번호는 " + findMember.getMemberPwd() + " 입니다.");
					if(result) msg = member.getMemberEmail() + "로 비밀번호가 발송되었습니다.";
					else msg = "이메일 발송 실패!";
					rdAttr.addFlashAttribute("msg", msg);
					return "redirect:/";
				case "G":
					msg = "google로 가입되어 있는 email입니다.";
					//rdAttr.addFlashAttribute("msg", msg);
					//return "redirect:/";
					break;
				case "K":
					msg = "kakao로 가입되어 있는 email입니다.";
					//rdAttr.addFlashAttribute("msg", msg);
					//return "redirect:/";
					break;
				case "V":
					msg = "naver로 가입되어 있는 email입니다.";
					//rdAttr.addFlashAttribute("msg", msg);
					//return "redirect:/";
					break;
				}
			}else {
				msg = "해당 아이디 또는 이메일로 가입되어 있는 아이디가 없습니다.";
				session.setAttribute("msg", msg);
				return "redirect:/member/findMember";
			}
			session.setAttribute("msg", msg);
		}catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMgs", "비밀번호 찾기 중 오류 발생");
			return "common/errorPage";
		}
		
		return "redirect:/member/findMember";
	}

}
