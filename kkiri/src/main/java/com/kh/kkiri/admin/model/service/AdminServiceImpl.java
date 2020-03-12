package com.kh.kkiri.admin.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.kkiri.admin.model.dao.AdminDAO;
import com.kh.kkiri.member.model.vo.Member;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminDAO adminDAO;
	
	/** 회원 수 조회 Service
	 * @return memberCount
	 * @throws Exception
	 */
	@Override
	public int adminMemberCount() throws Exception {
		return adminDAO.adminMemberCount();
	}
	
	/** 회원 정보 조회(관리자)
	 * @return mList
	 * @throws Exception
	 */
	@Override
	public List<Member> adminSelectMember() throws Exception {
		return adminDAO.adminSelectMember();
	}
	
	
}
