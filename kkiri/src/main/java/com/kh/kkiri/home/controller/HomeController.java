package com.kh.kkiri.home.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.kkiri.home.model.service.HomeService;

@Controller
public class HomeController {
	
	
	@Autowired
	private HomeService homeService;
	
	/**
	 * 메인 화면 로딩용 Controller
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		
		
		
		return "home";
	}
	
}
