package com.kh.kkiri.myPage.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.kkiri.myPage.model.dao.MypageDAO;

@Service
public class MypageServiceimpl implements MypageService{

	@Autowired
	private MypageDAO mypageDAO;
	
}
