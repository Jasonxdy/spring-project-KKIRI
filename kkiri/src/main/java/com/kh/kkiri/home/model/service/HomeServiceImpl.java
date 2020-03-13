package com.kh.kkiri.home.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.kkiri.home.model.dao.HomeDAO;
import com.kh.kkiri.member.model.vo.Member;

@Service
public class HomeServiceImpl implements HomeService {
	
	@Autowired
	private HomeDAO homeDAO;
	
	/**
	 * 메인 화면 한주간 높은 평점 회원 리스트
	 * @return list : List<Member>
	 * @throws Exception
	 */
	@Override
	public List<Member> selectMemberList() throws Exception {
		return homeDAO.selectMemberList();
	}

}
