package com.kh.kkiri.common;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.kkiri.admin.model.dao.AdminDAO;

public class VisitSessionListener implements HttpSessionListener{
	
	@Autowired
	private AdminDAO adminDAO;
	
	@Override
	public void sessionCreated(HttpSessionEvent sessionEvent) {
		
		if(sessionEvent.getSession().isNew()) {
			execute(sessionEvent);
		}
		
	}
	
	private void execute(HttpSessionEvent sessionEvent) {
		try{
			//adminDAO.
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void sessionDestroyed(HttpSessionEvent arg0) {
		
	}
}
