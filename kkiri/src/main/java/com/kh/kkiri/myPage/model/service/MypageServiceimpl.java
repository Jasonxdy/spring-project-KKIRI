package com.kh.kkiri.myPage.model.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.kkiri.common.FileRename;
import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.event.model.vo.Event;
import com.kh.kkiri.member.model.dao.MemberDAO;
import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.myPage.model.dao.MypageDAO;
import com.kh.kkiri.myPage.model.vo.Ticket;
import com.kh.kkiri.payment.model.dao.PaymentDAO;

@Service
public class MypageServiceimpl implements MypageService{

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@Autowired
	private MypageDAO mypageDAO;

	@Autowired
	private PaymentDAO paymentDAO;
	
	@Autowired
	private MemberDAO memberDAO;
	
	/** 계좌정보 변경을 위한 Service
	 * @param account
	 * @return result
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int updateAccount(Member account) throws Exception {

		return mypageDAO.updateAccount(account);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int updatePassword(Member loginMember, String changePassword) throws Exception {

		int result = 0; //아이디와 비밀번호가 일치하지 않음
		Member checkMember = null;

		// 비밀번호 암호화 작업 시작
		checkMember = memberDAO.signInMember(loginMember);


		// checkMember가 null이 아니고 비밀번호가 일치하다면
		if(checkMember != null && bcryptPasswordEncoder.matches(loginMember.getMemberPwd(), checkMember.getMemberPwd())) {

			loginMember.setMemberPwd(bcryptPasswordEncoder.encode(changePassword));
			result = mypageDAO.updatePassword(loginMember);
			if(result == 0) result=-1; // 변경 실패
		}

		return result;
	}

	@Override
	public int getListCount(Ticket ticket) throws Exception {
		return mypageDAO.getListCount(ticket);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int deleteMember(Member loginMember) throws Exception {

		int result = 0;
		Member checkMember = null;
		checkMember = memberDAO.signInMember(loginMember);
		if(checkMember != null) {
			result = mypageDAO.deleteMember(loginMember);
			if(result == 0) result=-1;
		}

		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int updateMember(Member loginMember, Member member, MultipartFile profile, String savepath) throws Exception {
		int result = 0;
		member.setMemberNo(loginMember.getMemberNo());
		String changeFileName ;
		if(!profile.getOriginalFilename().equals("")) {



			changeFileName = FileRename.rename(profile.getOriginalFilename());
			member.setMemberProfile(changeFileName);
		}else changeFileName = loginMember.getMemberProfile();

		member.setMemberIntroduce(member.getMemberIntroduce().replace("\r\n", "<br>"));
		result = memberDAO.updateMember(member);


		if(result>0) {
			// 파일 넣기
			if(!profile.getOriginalFilename().equals("default.png")&&!profile.getOriginalFilename().equals("profile-ex.png")&&!profile.getOriginalFilename().equals("")) {
				// 중복 파일 제거
				// 기존 파일 이름과 변경 파일 이름이 다를 경우 
				profile.transferTo(new File(savepath+"/"+changeFileName));
				if(loginMember.getMemberProfile().equals(changeFileName)) {
					File deleteFile = new File(savepath+"/"+profile.getOriginalFilename());
					deleteFile.delete();
				}
			}
		}
		return result;
	}

	@Override
	public List<Ticket> ticketLog(Ticket ticket, PageInfo Pinf) throws Exception {
		List<Ticket> ticketLog = mypageDAO.ticketLog(ticket,Pinf);

		return ticketLog;
	}

	/** 환조씨가 작업중
	 *
	 */
	@Override
	public List<Event> moveEvent(int memberNo,PageInfo pInf) throws Exception {

		return mypageDAO.moveEvent(memberNo,pInf);
	}

	
	@Override
	public List<Event> moveEvent2(int memberNo,PageInfo pInf) throws Exception {
		
		// 1. 내가 참가한 이벤트들의 eventNo 얻어오기
		List<Event> ejList = new ArrayList<Event>();
		List<Integer> eveNo = mypageDAO.countEveNo(memberNo,pInf);
		Event event = new Event();
		if(eveNo != null &&!eveNo.isEmpty()) {
			for(int i = 0; i<eveNo.size();i++) {
				event.setEventNo(eveNo.get(i));
				Event ev = mypageDAO.moveEvent2(event);
				// 이벤트 객체 갈아 엎기용 dao
				event.setMemberNo(memberNo);
				ev.setPermission(mypageDAO.remakeEvent(event).getPermission()); 
				
				ejList.add(ev);
			}
		}
		 
		
		// 검색 하는 거
		
		return ejList; 
	}

	
	
	@Override
	public List<Event> moveEvent3(int memberNo, PageInfo pInf2) throws Exception {
		
		List<Event> ejList = new ArrayList<Event>();
		List<Integer> eveNo = mypageDAO.countEveNo2(memberNo, pInf2);
		Event event = new Event();
		if(eveNo != null &&!eveNo.isEmpty()) {
			for(int i = 0; i<eveNo.size();i++) {
				event.setEventNo(eveNo.get(i));
				Event ev = mypageDAO.moveEvent2(event);
				// 이벤트 객체 갈아 엎기용 dao
				event.setMemberNo(memberNo);
				ev.setPermission(mypageDAO.remakeEvent(event).getPermission()); 
				
				ejList.add(ev);
			}
		}
		
		return ejList;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int costTicket(Ticket ticket,Member loginMember) throws Exception{

		Member memberChecker = null;

		memberChecker = memberDAO.signInMember(loginMember);



		int result = 0;

		// 비밀번호 일치 확인 작업 작업
		if(memberChecker != null && bcryptPasswordEncoder.matches(loginMember.getMemberPwd(), memberChecker.getMemberPwd())) {

			result = 2;
			// insert 작업
			result= mypageDAO.costTicket(ticket);

			if(result>0) {
				// update 작업
				result = mypageDAO.updateTicket(ticket);
				if(result >0) result = -1;
			}

			if(result>0) {
				// payment만 입력 되었을 시 강제로 오류 발생
				throw new Exception();
			}
		}
		return result; 
	}

	@Override
	public int listEventCount(int memberNo) throws Exception {
		
		return mypageDAO.listEventCount(memberNo);
	}

	@Override
	public int listEventCount2(int memberNo, Integer flag) throws Exception {
		// map 으로 매개변수를 바꾸자
		
		Map<String,Integer> countMap = new HashMap<String, Integer>(); 
		countMap.put("memberNo", memberNo);
		
		countMap.put("flag", flag);
		
		
		
		return mypageDAO.listEventCount2(countMap);
	}
	
	
	/** 즐겨찾기 수 조회
	 * @param memberNo
	 * @return count
	 * @throws Exception
	 */
	@Override
	public int getFavoriteCount(int memberNo) throws Exception {
		return mypageDAO.getFavoriteCount(memberNo);
	}
	
	/** 즐겨찾기 목록 조회
	 * @param memberNo
	 * @param pInf 
	 * @return fList
	 * @throws Exception
	 */
	@Override
	public List<Member> moveFavorite(int memberNo, PageInfo pInf) throws Exception {
		List<Member> fList = mypageDAO.moveFavorite(memberNo, pInf);
		
		for(Member member : fList) {
			if(member.getMemberIntroduce() != null) {
				member.setMemberIntroduce(member.getMemberIntroduce().replace("<br>", "\n"));
			}
		}
		return fList;
	}
	
	/** 즐겨찾기 메모 변경
	 * @param member
	 * @return result
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int changeMemo(Member member) throws Exception {
		member.setMemberIntroduce(member.getMemberIntroduce().replace("\n", "<br>"));
		return mypageDAO.changeMemo(member);
	}
	
	/** 즐겨찾기 삭제
	 * @param member
	 * @return result
	 * @throws Exception
	 */
	@Override
	public int deleteFavorite(Member member) throws Exception {
		return mypageDAO.deleteFavorite(member);
	}

	/** 티켓 충전
	 *
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int ticketRecharge(Ticket ticket) throws Exception {
		int result = 0;
		// 1. insert 작업
		
		// DAO 재활용을 위한 map에 넣는 작업
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("memberNo", ticket.getMemberNo());
		map.put("paymentType", ticket.getPaymentType());
		map.put("ticket", ticket.getPaymentTicket());
		map.put("merchantUid", ticket.geteventName());
		System.out.println("충전의 map"+map);
		result = paymentDAO.insertPayment(map);
		
		System.out.println(result);
		/*
		if(result >0) {
			// member의 ticket수 업데이트
			result = memberDAO.ticketRecharge(map);
			if(result >0) {
				result = 2;
			}
		}*/
		
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int successRecharge(Member loginMember, Integer recharge) throws Exception{
		// 1. 티켓 수량 업데이트 하기
		Map<String, Object> map = new HashMap<String, Object>();
		int result = 0;
		map.put("memberNo", loginMember.getMemberNo());
		map.put("ticket",recharge);
		System.out.println("member ticket 업데이트용 "+map);
		
		result = memberDAO.ticketRecharge(map);
		
		return result;
	}
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteTicket(String merchant_uid) throws Exception {
		int result = 0;
		
		result = paymentDAO.deleteTicket(merchant_uid);
		
		System.out.println("취소 확인용"+result);
		
		return result;
	}

	@Override
	public Member loginAgain(int memberNo) throws Exception {
		// TODO Auto-generated method stub
		return mypageDAO.loginAgain(memberNo);
	}
	
	
	
}
