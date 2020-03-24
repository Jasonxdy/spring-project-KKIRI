package com.kh.kkiri.myPage.model.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.kkiri.common.FileRename;
import com.kh.kkiri.member.model.dao.MemberDAO;
import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.myPage.model.dao.MypageDAO;
import com.kh.kkiri.myPage.model.vo.Ticket;
import com.kh.kkiri.payment.model.vo.Payment;

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

		if(ticket.getPaymentType().equals("ALL")) {
			ticket.setPaymentType("*");
		}
		
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
	public List<Ticket> ticketLog(Ticket ticket) throws Exception {

		if(ticket.getPaymentType().equals("all")||ticket.getPaymentType()==null) {
			ticket.setPaymentType("*");
		}
		
		List<Ticket> ticketLog = mypageDAO.ticketLog(ticket);
		
		return ticketLog;
	}
	
	
	
}
