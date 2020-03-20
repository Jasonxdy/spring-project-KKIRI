package com.kh.kkiri.myPage.model.service;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.kkiri.common.FileRename;
import com.kh.kkiri.member.model.dao.MemberDAO;
import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.myPage.model.dao.MypageDAO;

@Service
public class MypageServiceimpl implements MypageService{


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
		checkMember = memberDAO.signInMember(loginMember);
		if(checkMember != null) {
			loginMember.setMemberPwd(changePassword);
		result = mypageDAO.updatePassword(loginMember);
		if(result == 0) result=-1; // 변경 실패
		}
		
		return result;
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
			System.out.println(123);
			System.out.println(profile);
			// 파일 넣기
			profile.transferTo(new File(savepath+"/"+changeFileName));
			System.out.println(changeFileName);
			if(!profile.getOriginalFilename().equals("default.png")||!profile.getOriginalFilename().equals("profile-ex.png")) {
				// 중복 파일 제거
				
				// 기존 파일 이름과 변경 파일 이름이 다를 경우 
				if(loginMember.getMemberProfile().equals(changeFileName)) {
					
				File deleteFile = new File(savepath+"/"+profile.getOriginalFilename());
				deleteFile.delete();
				}
			}
		}
		return result;
	}
	
	
}
