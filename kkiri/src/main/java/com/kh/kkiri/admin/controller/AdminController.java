package com.kh.kkiri.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.kkiri.admin.model.service.AdminService;
import com.kh.kkiri.ask.model.service.AskService;
import com.kh.kkiri.ask.model.vo.Ask;
import com.kh.kkiri.common.Pagination;
import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.report.model.service.ReportService;

@Controller
@RequestMapping("/admin/*")
@SessionAttributes("msg")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private ReportService reportService;
	
	@Autowired
	private AskService askService;
	
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
	
	@RequestMapping("refund")
	public String refundTicket(Model model, Integer thisMemberNo, 
			Integer canceledTicket, HttpServletRequest request) {
		try {
			// 티켓 취소
			String beforeUrl = request.getHeader("referer"); // 이전 페이지 주소를 얻어옴.
			canceledTicket = -(canceledTicket);
			Map<String, Object> map = null;
			map = new HashMap<String, Object>();
			map.put("memberNo", thisMemberNo);
			map.put("ticket", canceledTicket);
			map.put("paymentType", "B");
			System.out.println("취소 티켓:" + canceledTicket);
			int result = adminService.refundTicket(map);
			if(result>0) {
				model.addAttribute("msg", "환불 성공");
			}else {
				model.addAttribute("msg", "환불 실패");
			}
			
			return "redirect:"+beforeUrl;
			
		}catch (Exception e) {
			e.printStackTrace();
			return "redirect:/";
		}
	}
	
	@ResponseBody
	@RequestMapping("delete")
	public String adminDelete(Integer memberNo, Model model) {
		try {
			return adminService.delete(memberNo) == 1 ? true + "" : false + "";
		}catch (Exception e) {
			e.printStackTrace();
			return "admin/admin_member";
		}
	}
	
	@ResponseBody
	@RequestMapping("recover")
	public String adminRecover(Integer memberNo, Model model) {
		try {
			return adminService.recover(memberNo) == 1 ? true + "" : false + "";
		}catch (Exception e) {
			e.printStackTrace();
			return "admin/admin_member";
		}
	}
	
	@RequestMapping("report")
	public String adminReport(Model model,
						@RequestParam(value="currentPage", required=false) Integer currentPage,
						@RequestParam(value="searchKey", required=false) String searchKey,
						@RequestParam(value="searchValue", required=false) String searchValue
						) {
		try {
			Map<String, String> map = null;
			if(searchKey != null && searchValue != null) {
				map = new HashMap<String, String>();
				map.put("searchKey",searchKey);
				map.put("searchValue",searchValue);
			}
			int memberCount = reportService.adminReportCount(map);
			//System.out.println("회원 수: " + memberCount);
			if(currentPage == null) currentPage = 1;
			
			PageInfo pInf = Pagination.getPageInfo(10, 10, currentPage, memberCount);
			
			List<Member> rList = reportService.adminSelectReport(map, pInf);
			
			model.addAttribute("pInf", pInf);
			model.addAttribute("rList", rList);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "admin/admin_report";
	}
	
	@RequestMapping("ask")
	public String adminAsk(Model model,
						@RequestParam(value="currentPage", required=false) Integer currentPage,
						@RequestParam(value="searchKey", required=false) String searchKey,
						@RequestParam(value="searchValue", required=false) String searchValue
						) {
		try {
			Map<String, String> map = null;
			if(searchKey != null && searchValue != null) {
				map = new HashMap<String, String>();
				map.put("searchKey",searchKey);
				map.put("searchValue",searchValue);
			}
			int askCount = askService.adminAskCount(map);
			//System.out.println("회원 수: " + memberCount);
			if(currentPage == null) currentPage = 1;
			
			PageInfo pInf = Pagination.getPageInfo(10, 10, currentPage, askCount);
			
			List<Member> aList = askService.adminSelectAsk(map, pInf);
			
			model.addAttribute("pInf", pInf);
			model.addAttribute("aList", aList);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "admin/admin_ask";
	}
	/*
	 try {
			System.out.println("send메일 시작");
			Properties props = System.getProperties();
			props.put("mail.smtp.auth"           , "true");
			props.put("mail.smtp.ssl.enable"     , "true");
			props.put("mail.smtp.ssl.trust"      , "smtp.gmail.com");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.host"           , "smtp.gmail.com");
			props.put("mail.smtp.port"           , 465);
			
			Session session = Session.getInstance(props, new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication("missingpetkh@gmail.com", "ehdgus12");
					//return new PasswordAuthentication("발신gmail계정주소", "앱비밀번호");
				}
			});
			
			InternetAddress from = new InternetAddress("missingpetkh@gmail.com");
			//InternetAddress from = new InternetAddress("발신gmail계정주소", "표시할발신자명");
			
			Message message = new MimeMessage(session);
			message.setFrom(from);
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
			//message.setRecipients(Message.RecipientType.TO, InternetAddress.parse("수신메일계정주소"));
			
			message.setSubject(boardTitle + " 글이 등록되었습니다.");
			message.setText("메일본문내용");
			
			Transport.send(message);
		} finally {
			
		}
	 */
	@RequestMapping("sendAnswer")
	public String adminSendAnswer(Model model, Ask ask, String answerContent) {
		try {
            
            // (1) Setting..
            Properties property = new Properties();
            property.put("mail.smtp.host", "smtp.gmail.com");
            property.put("mail.smtp.auth", "true");
            property.put("mail.smtp.starttls.enable", "true");
            property.put("mail.smtp.host", "smtp.gmail.com");
            property.put("mail.smtp.port", "587");
            property.put("mail.smtp.debug", "true");

            // (2) gmail 계정과 패스워드 입력
            Session session = Session.getInstance(property, new javax.mail.Authenticator() {
                   protected PasswordAuthentication getPasswordAuthentication() {
                         return new PasswordAuthentication("kkirimail@gmail.com", "baskin31kh");
                   }
            });


            MimeMessage mimeMessage = new MimeMessage(session);

            // (3) 보네는 사람 ( 이메일 Address, 보네는이 이름 )
            InternetAddress fromAddress = new InternetAddress("kkirimail@gmail.com", "KKIRI");
            mimeMessage.setFrom(fromAddress);

            // (4) 받는 사람 ( 이메일 Address, 받는사람 이름 )
            InternetAddress toAddress = new InternetAddress("kkndbabo@naver.com", ask.getMemberId());
            mimeMessage.setRecipient(Message.RecipientType.TO, toAddress);
           
            // (5) 이메일의 타이틀 입력
            mimeMessage.setSubject("1:1 문의 답변입니다.", "UTF-8");

            // (6) 이메일의 본문내용 입력
            mimeMessage.setText(answerContent, "UTF-8");

            // (7) 메일 전송
            Transport.send(mimeMessage);
            
            
            System.out.println("Success");
            return "admin/admin_ask";
	     } catch (Exception e) {
            e.printStackTrace();
            return "common/errorPage.jsp";
	     }
		
		
	}
	
}














