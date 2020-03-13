package com.kh.kkiri.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.member.model.vo.Member;

public interface AdminService {

	/** 회원 수 조회 Service
	 * @param map 
	 * @return memberCount
	 * @throws Exception
	 */
	int adminMemberCount(Map<String, Object> map) throws Exception;
	
	/** 회원 정보 조회(관리자) Service
	 * @param map
	 * @param pInf
	 * @return mList
	 */
	List<Member> adminSelectMember(Map<String, Object> map, PageInfo pInf) throws Exception;

	/** 티켓 환불 Service
	 * @param map
	 * @return result
	 * @throws Exception
	 */
	int refundTicket(Map<String, Object> map) throws Exception;

	/** 회원 삭제 Service
	 * @param memberNo
	 * @return result
	 * @throws Exception
	 */
	int delete(Integer memberNo) throws Exception;

	/** 회원 삭제 복구 Service
	 * @param memberNo
	 * @return result
	 * @throws Exception
	 */
	int recover(Integer memberNo) throws Exception;


}
