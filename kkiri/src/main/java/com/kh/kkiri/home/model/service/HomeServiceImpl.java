package com.kh.kkiri.home.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.kkiri.home.model.dao.HomeDAO;

@Service
public class HomeServiceImpl implements HomeService {
	
	@Autowired
	private HomeDAO homeDAO;

}
