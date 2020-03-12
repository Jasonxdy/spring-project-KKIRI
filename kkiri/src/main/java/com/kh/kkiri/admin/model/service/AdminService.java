package com.kh.kkiri.admin.model.service;

import java.util.List;

import com.kh.kkiri.member.model.vo.Member;

public interface AdminService {

	/** 회원 정보 조회(관리자) Service
	 * @return mList
	 * @throws Exception
	 */
	List<Member> adminSelectMember() throws Exception;

	/** 회원 수 조회 Service
	 * @return memberCount
	 * @throws Exception
	 */
	int adminMemberCount() throws Exception;

}
