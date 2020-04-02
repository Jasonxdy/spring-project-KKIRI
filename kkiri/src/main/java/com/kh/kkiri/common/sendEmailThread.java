package com.kh.kkiri.common;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;

public class sendEmailThread extends Thread{
	private String receiveAddress;
	private String receiveName;
	private String sendTitle;
	private String sendContent;
	
	public sendEmailThread() {
		// TODO Auto-generated constructor stub
	}
	
	public sendEmailThread(String receiveAddress, String receiveName, String sendTitle,
			String sendContent) {
		super();
		this.receiveAddress = receiveAddress;
		this.receiveName = receiveName;
		this.sendTitle = sendTitle;
		this.sendContent = sendContent;
	}



	@Override
	public void run() {
		try {
            // (1) Setting..
            Properties property = new Properties();
            property.put("mail.smtp.host", "smtp.gmail.com");
            property.put("mail.smtp.auth", "true");
            property.put("mail.smtp.starttls.enable", "true");
            property.put("mail.smtp.host", "smtp.gmail.com");
            property.put("mail.smtp.port", "587");
            property.put("mail.smtp.debug", "true");

            // (2) gmail 계정과 패스워드 입력
            Session session = Session.getInstance(property, new javax.mail.Authenticator() {
                   protected PasswordAuthentication getPasswordAuthentication() {
                         return new PasswordAuthentication("kkirimail@gmail.com", "baskin31kh");
                   }
            });

            MimeMessage mimeMessage = new MimeMessage(session);

            // (3) 보네는 사람 ( 이메일 Address, 보네는이 이름 )
            InternetAddress fromAddress = new InternetAddress("kkirimail@gmail.com", "KKIRI");
            mimeMessage.setFrom(fromAddress);

            // (4) 받는 사람 ( 이메일 Address, 받는사람 이름 )
            InternetAddress toAddress = new InternetAddress(receiveAddress, receiveName);
            mimeMessage.setRecipient(Message.RecipientType.TO, toAddress);
           
            // (5) 이메일의 타이틀 입력
            mimeMessage.setSubject(sendTitle, "UTF-8");

            // (6) 이메일의 본문내용 입력
            mimeMessage.setText(sendContent, "UTF-8");

            // (7) 메일 전송
            Transport.send(mimeMessage);
            
	     } catch (Exception e) {
            e.printStackTrace();
	     }
	}
	
}
