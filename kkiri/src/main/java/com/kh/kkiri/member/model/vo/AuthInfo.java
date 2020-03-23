package com.kh.kkiri.member.model.vo;

public class AuthInfo {
	private String clientId;
	private String clientSecret;
	
	public AuthInfo() {
		// TODO Auto-generated constructor stub
	}

	public AuthInfo(String clientId, String clientSecret) {
		super();
		this.clientId = clientId;
		this.clientSecret = clientSecret;
	}

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public String getClientSecret() {
		return clientSecret;
	}

	public void setClientSecret(String clientSecret) {
		this.clientSecret = clientSecret;
	}
	
	
}
