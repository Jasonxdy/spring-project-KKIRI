package com.kh.kkiri.myPage.model.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

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

@Service
public class MypageServiceimpl implements MypageService{

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@Autowired
	private MypageDAO mypageDAO;

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
		if(eveNo != null ||!eveNo.isEmpty()) {
			for(int i = 0; i<eveNo.size();i++) {
				Event ev = mypageDAO.moveEvent2(eveNo.get(i));
				ejList.add(ev);
			}
		}
		 
		
		// 검색 하는 거
		
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



}
