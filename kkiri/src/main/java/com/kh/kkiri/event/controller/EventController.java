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
import com.kh.kkiri.common.Pagination;
import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.event.model.service.EventService;
import com.kh.kkiri.event.model.vo.BoardAndImage;
import com.kh.kkiri.event.model.vo.Chat;
import com.kh.kkiri.event.model.vo.Event;
import com.kh.kkiri.event.model.vo.Image;
import com.kh.kkiri.event.model.vo.Party;
import com.kh.kkiri.event.model.vo.Rating;
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
			if (model.getAttribute("loginMember") != null) {
				List<Party> myEventList = eventService
						.selectMyEventList(((Member) model.getAttribute("loginMember")).getMemberNo());
				if (myEventList != null) {
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
			if (model.getAttribute("loginMember") != null) {
				List<Party> myEventList = eventService
						.selectMyEventList(((Member) model.getAttribute("loginMember")).getMemberNo());
				if (myEventList != null) {
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
	@RequestMapping(value = "addPartyList", produces = "application/json; charset=utf-8")
	public String selectPartyList(int count, int limit, int eventNo, Model model, RedirectAttributes rdAttr) {
		List<Member> partyList = eventService.selectAddPartyList(count, limit, eventNo);

		Gson gson = new GsonBuilder().setDateFormat("yyyy년 MM월 dd일").create();
		return gson.toJson(partyList);
	}

	// 이벤트 참가 신청
	@RequestMapping("joinEvent")
	public String joinEvent(Event event, Model model, RedirectAttributes rdAttr, HttpServletRequest request) {
		String msg = null;
		String url = null;
		String detailUrl = request.getHeader("referer");
		model.addAttribute("detailUrl", detailUrl);

		try {
			int result = eventService.joinEvent(event);
			if (result > 0) {
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
	public int cancelWaitEvent(Event event) {

		int result = 0;

		try {
			result = eventService.cancelEvent(event);
		} catch (Exception e) {
			e.printStackTrace();
			result = -1;
		}
		return result;
	}

	// 이벤트 참가 취소
	@RequestMapping("cancelJoinEvent")
	public String cancelJoinEvent(Event event, Model model, RedirectAttributes rdAttr, HttpServletRequest request) {
		String msg = null;
		String url = null;
		String detailUrl = request.getHeader("referer");
		model.addAttribute("detailUrl", detailUrl);

		try {
			int result = eventService.cancelEvent(event);
			if (result > 0) {
				msg = "이벤트 참가가 취소되었습니다";
			} else {
				msg = "이벤트 참가 취소 실패";
			}

			rdAttr.addFlashAttribute("msg", msg);
			return "redirect:" + detailUrl;

		} catch (Exception e) {
			e.printStackTrace();
			msg = "이벤트 참가 취소 과정 중 오류 발생";
			model.addAttribute("msg", msg);
			return "common/errorPage";
		}

	}

	// 이벤트 완료 확인
	@RequestMapping("confirmEventComplete")
	@ResponseBody
	public int confirmEventComplete(Event event) {

		int result = 0;

		try {
			result = eventService.confirmEventComplete(event);
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

		if (report.getReportContent().equals("")) {
			report.setReportContent(" ");
		}
		try {
			int result = eventService.insertReport(report);

			if (result > 0) {
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
	public String createEvent(String startTime, String endTime, Event event, Model model, HttpServletRequest request,
			@RequestParam(value = "thumbnailImg", required = false) MultipartFile thumbnailImg,
			RedirectAttributes rdAttr) {
		Member loginMember = (Member) model.getAttribute("loginMember");
		int eventCreator = loginMember.getMemberNo();

		startTime += ":00.00";
		endTime += ":00.00";

		Timestamp eventStart = (Timestamp.valueOf(startTime.replace("T", " ")));
		Timestamp eventEnd = (Timestamp.valueOf(endTime.replace("T", " ")));

		event.setEventStart(eventStart);
		event.setEventEnd(eventEnd);
		event.setMemberNo(eventCreator);
		event.setEventThumbnail(thumbnailImg.getOriginalFilename());

		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/upEventThumbnail";
		File folder = new File(savePath);

		if (!folder.exists()) {
			folder.mkdir();
		}

		try {
			Image image = null;
			String changeFileName = null;
			if (!thumbnailImg.getOriginalFilename().equals("")) {

				changeFileName = FileRename.rename(thumbnailImg.getOriginalFilename());

				image = new Image(thumbnailImg.getOriginalFilename(), changeFileName);
			}

			event.setEventThumbnail(changeFileName);
			int result = eventService.createEvent(event, image);

			String url = null;
			if (result > 0) { // DB에 게시글 삽입 성공시
				if (image != null) {
					thumbnailImg.transferTo(new File(savePath + "/" + changeFileName));
				}
				model.addAttribute("eventNo", result);
				url = "event/insertEventComplete";
			} else {
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

	// 이벤트 수정페이지로 이동(서진웅)

	@RequestMapping("updateEventGo")
	public String updateEventGo(Model model, HttpServletRequest request, Integer no) {

		try {
			Event event = eventService.selectEvent(no);

			event.setEventContent(event.getEventContent().replace("<br>", "\r\n"));
			model.addAttribute("event", event);

			return "event/eventUpdate";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "이벤트 수정 화면 출력 과정 중 오류발생");
			return "common/errorPage";
		}

	}
	
	// 이벤트 수정(서진웅)
		@RequestMapping("updateEvent")
		public String updateEvent(Integer no,
									Model model,
									RedirectAttributes rdAttr, 
									HttpServletRequest request,
									@RequestParam(value = "thumbnailImg", required = false) MultipartFile thumbnailImg,
									Event event
									) {
			event.setEventNo(no);
			
			String root = request.getSession().getServletContext().getRealPath("resources");
			String savePath = root + "/upEventThumbnail";
			File folder = new File(savePath);
			
			if (!folder.exists()) {
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
				
				int result = eventService.updateEvent(event,image,savePath,thumbnailImg);
				
				String url = null;
				if (result > 0) { // DB에 게시글 삽입 성공시
					if (image != null) {
						thumbnailImg.transferTo(new File(savePath + "/" + changeFileName));
					}
					model.addAttribute("eventNo", result);
					url = "event/updateEventComplete";
				} else {
					String msg = "이벤트 수정 실패";
					rdAttr.addFlashAttribute("msg", msg);
					url = "redirect:/";
				}
				return url;
			}catch(Exception e) {
				e.printStackTrace();
				model.addAttribute("errorMsg", "이벤트 수정 과정 중 오류발생");
				return "common/errorPage";
			}
		}
		
	// 이벤트 후기 페이지 이동
	@RequestMapping("comment")
	public String comment(@RequestParam(value = "no", required = false) Integer no, Model model,
			RedirectAttributes rdAttr, @RequestParam(value = "currentPage", required = false) Integer currentPage) {
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
			if (model.getAttribute("loginMember") != null) {
				List<Party> myEventList = eventService
						.selectMyEventList(((Member) model.getAttribute("loginMember")).getMemberNo());
				if (myEventList != null) {
					model.addAttribute("myEventList", myEventList);
					// + 내가 남긴 후기 있는 경우 그것도 가져오기
					for (Party party : myEventList) {
						if (party.getEventNo() == event.getEventNo() && party.getMemberType().equals("P")) { // 해당 이벤트가
																												// 내가
																												// 참여한
																												// 이벤트인
																												// 경우 후기
																												// 가져옴
							Rating myRating = eventService.selectMyRating(party);
							model.addAttribute("myRating", myRating);
							break;
						}
					}
				}
			}

			// 해당 이벤트 후기 얻어오기
			// 전체 후기 수 조회
			int listCount = eventService.getListCount(eventNo);

			// 현재 페이지 확인
			if (currentPage == null)
				currentPage = 1;

			// 페이지 정보 저장
			PageInfo pInf = Pagination.getPageInfo(5, 5, currentPage, listCount);

			// 후기 목록 조회
			List<Rating> ratingList = eventService.selectRatingList(eventNo, pInf);

			if (event != null) {

				model.addAttribute("event", event);
				model.addAttribute("partyList", partyList);
				model.addAttribute("ratingList", ratingList);
				model.addAttribute("pInf", pInf);
				url = "event/eventAfterComment";

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

	// 후기 등록
	@RequestMapping("insertRating")
	public String insertRating(Rating rating, Model model, RedirectAttributes rdAttr, HttpServletRequest request) {
		String msg;
		String detailUrl = request.getHeader("referer");
		model.addAttribute("detailUrl", detailUrl);

		rating.setRatingContent(rating.getRatingContent().replace("\r\n", "<br>"));
		try {
			int result = eventService.insertRating(rating);

			if (result > 0) {
				msg = "이벤트 후기가 등록되었습니다";
			} else {
				msg = "이벤트 후기 등록 실패";
			}

			rdAttr.addFlashAttribute("msg", msg);
			return "redirect:" + detailUrl;

		} catch (Exception e) {
			e.printStackTrace();
			msg = "이벤트 후기 등록 과정 중 오류 발생";
			model.addAttribute("msg", msg);
			return "common/errorPage";
		}

	}

	// 후기 수정
	@RequestMapping("updateRating")
	public String updateRating(Rating rating, Model model, RedirectAttributes rdAttr, HttpServletRequest request) {
		String msg = null;
		String detailUrl = request.getHeader("referer");
		model.addAttribute("detailUrl", detailUrl);

		rating.setRatingContent(rating.getRatingContent().replace("\r\n", "<br>"));
		try {
			int result = eventService.updateRating(rating);

			if (result > 0) {
				msg = "이벤트 후기가 수정되었습니다";
			} else {
				msg = "이벤트 후기 수정 실패";
			}

			rdAttr.addFlashAttribute("msg", msg);
			return "redirect:" + detailUrl;

		} catch (Exception e) {
			e.printStackTrace();
			msg = "이벤트 후기 수정 과정 중 오류 발생";
			model.addAttribute("msg", msg);
			return "common/errorPage";
		}
	}

	// 후기 삭제
	@RequestMapping("deleteRating")
	public String deleteRating(int ratingNo, Model model, RedirectAttributes rdAttr, HttpServletRequest request) {
		String msg;
		String detailUrl = request.getHeader("referer");

		try {
			int result = eventService.deleteRating(ratingNo);

			if (result > 0) {
				msg = "이벤트 후기가 삭제되었습니다";
			} else {
				msg = "이벤트 후기 삭제 실패";
			}

			rdAttr.addFlashAttribute("msg", msg);
			return "redirect:" + detailUrl;

		} catch (Exception e) {
			e.printStackTrace();
			msg = "이벤트 후기 삭제 과정 중 오류 발생";
			model.addAttribute("msg", msg);
			return "common/errorPage";
		}
	}

	// 사진 등록 페이지 이동
	@RequestMapping("picture")
	public String selectPicture(@RequestParam(value = "no", required = false) Integer no,
			@RequestParam(value = "currentPage", required = false) Integer currentPage, Model model,
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
			if (model.getAttribute("loginMember") != null) {
				List<Party> myEventList = eventService
						.selectMyEventList(((Member) model.getAttribute("loginMember")).getMemberNo());
				if (myEventList != null) {
					model.addAttribute("myEventList", myEventList);
				}
			}

//			------------------------ 사진 기능 -----------------------

			// 해당 이벤트 후기 얻어오기
			// 전체 후기 수 조회
			int listCount = eventService.getImageListCount(eventNo);

			// 현재 페이지 확인
			if (currentPage == null)
				currentPage = 1;

			// 페이지 정보 저장
			PageInfo pInf = Pagination.getPageInfo(9, 5, currentPage, listCount);
			

			// 사진 목록 조회
			List<BoardAndImage> imageList = eventService.selectImageList(eventNo, pInf);

			if (event != null) {

				model.addAttribute("imageList", imageList);
				model.addAttribute("event", event);
				model.addAttribute("partyList", partyList);
				model.addAttribute("pInf", pInf);
				url = "event/eventPicture";

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

	// 사진 수정하기
	@RequestMapping("updatePicture")
	public String updatePicture(BoardAndImage boardAndImage, Model model, RedirectAttributes rdAttr,
			HttpServletRequest request, @RequestParam(value = "image", required = false) MultipartFile image) {

		// 상세조회 화면으로 redirect 하기위함
		String detailUrl = request.getHeader("referer");

		// 결과값을 받을 result
		int result = 0;

		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/upEventPicture";

		// 내용 <br> 바꾸기
		boardAndImage.setBoardContent(boardAndImage.getBoardContent().replace("\r\n", "<br>"));

		// 저장폴더가 있는지 검사하여 없을 경우 생성하기
		File folder = new File(savePath);
		if (!folder.exists())
			folder.mkdir();

		try {
			// 사진 및 게시글 수정
			result = eventService.updateBoard(boardAndImage, image, savePath);

			String msg = null;
			if (result > 0)
				msg = "사진이 수정되었습니다.";
			else
				msg = "사진 수정 실패";
			rdAttr.addFlashAttribute("msg", msg);

			// 수정 후 상세조회 화면 요청
			return "redirect:" + detailUrl;

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "사진 수정 과정에서 오류 발생");
			return "common/errorPage";
		}
	}
	
	
	// 사진 등록
	@RequestMapping("insertPicture")
	public String insertPicture(BoardAndImage boardAndImage, Model model, RedirectAttributes rdAttr,
			HttpServletRequest request, @RequestParam(value = "image", required = false) MultipartFile image) {

		// 상세조회 화면으로 redirect 하기위함
//		String detailUrl = request.getHeader("referer");

		// 결과값을 받을 result
		int result = 0;

		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/upEventPicture";

		// 내용 <br> 바꾸기
		boardAndImage.setBoardContent(boardAndImage.getBoardContent().replace("\r\n", "<br>"));

		// 저장폴더가 있는지 검사하여 없을 경우 생성하기
		File folder = new File(savePath);
		if (!folder.exists())
			folder.mkdir();

		try {
			// 사진 및 게시글 수정
			result = eventService.insertBoard(boardAndImage, image, savePath);

			String msg = null;
			if (result > 0)
				msg = "사진이 등록되었습니다";
			else
				msg = "사진 등록 실패";
			rdAttr.addFlashAttribute("msg", msg);

			// 등록 후 상세조회 화면 요청
			return "redirect:picture";

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "사진 등록 과정에서 오류 발생");
			return "common/errorPage";
		}
	}
	
	
	// 사진 삭제
	@RequestMapping("deletePicture")
	public String deletePicture (BoardAndImage boardAndImage, Model model, RedirectAttributes rdAttr, HttpServletRequest request) {
		
		int result = 0;
		String msg = null;
		String detailUrl = request.getHeader("referer");
		
		try {
			
			result = eventService.deletePicture(boardAndImage);
			
			if (result > 0)
				msg = "사진이 삭제되었습니다";
			else
				msg = "사진 삭제 실패";
			rdAttr.addFlashAttribute("msg", msg);

			// 등록 후 상세조회 화면 요청
			return "redirect:" + detailUrl;
			
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", "사진 삭제 과정에서 오류 발생");
			return "common/errorPage";
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value="insertChat", produces = "application/json; charset=utf-8")
	public int insertChat(@RequestParam(value="eventNo", required=false) int eventNo,
								@RequestParam(value="chatContent", required=false) String chatContent) {
		Chat chat = new Chat(eventNo, chatContent);
		
		int result = eventService.insertChat(chat);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="selectChat", produces = "application/json; charset=utf-8")
	public String selectChat(@RequestParam(value="eventNo", required=false) int eventNo) {
		
		List<Chat> chatList = eventService.selectChat(eventNo);
		
		return new Gson().toJson(chatList);
	}
	
	@ResponseBody
	@RequestMapping(value="deleteChat", produces = "application/json; charset=utf-8")
	public int deleteChat(@RequestParam(value="chatNo", required=false) int chatNo) {
		
		int result = eventService.deleteChat(chatNo);
		
		return result;
	}
	
}
