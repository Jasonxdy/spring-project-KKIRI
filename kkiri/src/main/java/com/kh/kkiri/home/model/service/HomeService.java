package com.kh.kkiri.home.model.service;

import java.util.List;

import com.kh.kkiri.member.model.vo.Member;

public interface HomeService {

	/**
	 * 메인 화면 한주간 높은 평점 회원 리스트
	 * @return list : List<Member>
	 * @throws Exception
	 */
	List<Member> selectMemberList() throws Exception;

}
