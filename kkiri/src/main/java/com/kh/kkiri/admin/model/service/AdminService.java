package com.kh.kkiri.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.member.model.vo.Member;

public interface AdminService {

	/** 회원 정보 조회(관리자) Service
	 * @param map
	 * @param pInf
	 * @return mList
	 */
	List<Member> adminSelectMember(Map<String, Object> map, PageInfo pInf);

	/** 회원 수 조회 Service
	 * @param map 
	 * @return memberCount
	 * @throws Exception
	 */
	int adminMemberCount(Map<String, Object> map) throws Exception;


}
