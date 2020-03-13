package com.kh.kkiri.myPage.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.myPage.model.dao.MypageDAO;

@Service
public class MypageServiceimpl implements MypageService{


	@Autowired
	private MypageDAO mypageDAO;
	
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
}
