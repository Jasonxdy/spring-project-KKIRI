package com.kh.kkiri.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.kkiri.admin.model.dao.AdminDAO;
import com.kh.kkiri.common.vo.PageInfo;
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
	public int adminMemberCount(Map<String, Object> map) throws Exception {
		return adminDAO.adminMemberCount(map);
	}
	
	/** 회원 정보 조회(관리자) Service
	 * @param map
	 * @param pInf
	 * @return mList
	 */
	@Override
	public List<Member> adminSelectMember(Map<String, Object> map, PageInfo pInf) {
		return adminDAO.adminSelectMember(map, pInf);
	}
	
	
}
