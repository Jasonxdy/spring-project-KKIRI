package com.kh.kkiri.myPage.model.service;

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
		String changeFileName = FileRename.rename(profile.getOriginalFilename());
		member.setMemberProfile(changeFileName);
		result = memberDAO.updateMember(member);
		
			
		
		return 0;
	}
	
	
}
