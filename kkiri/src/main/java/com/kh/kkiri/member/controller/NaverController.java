package com.kh.kkiri.member.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.stereotype.Controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class NaverController {
	// CSRF 방지를 위한 상태 토큰 생성 코드
	// 상태 토큰은 추후 검증을 위해 세션에 저장되어야 한다.
	
	// 내 애플리케이션에서 제공하는 ClientId
	private final static String N_CLIENT_ID = "LJUiiR8c6mrgWsanAhFZ";
	
	// 내 애플리케이션에서 제공하는 Client Secret
	private final static String N_CLIENT_SECRET = "zl1Qrn1xyf";
	
	// CSRF 방지를 위한 상태 토큰 생성 코드
	// 상태 토큰은 추후 검증을 위해 세션에 저장되어야 한다.
	// HomeController에서 사용
	public String generateState() {
		SecureRandom random = new SecureRandom();
		return new BigInteger(130, random).toString(32);
	}
	
	// 접근 토큰 발급 클래스
	public String getAccessToken(String autorize_code, HttpSession session) {
		
		// session에 올라간 상태 토큰 가져오기
		String naverState = (String) session.getAttribute("naverState");
		
		// 요청 url 기본값
		final String RequestUrl = "https://nid.naver.com/oauth2.0/token";
		
		// RequestUrl에 덧붙일 값 설정
		final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
		postParams.add(new BasicNameValuePair("client_id", N_CLIENT_ID)); //
		postParams.add(new BasicNameValuePair("client_secret", N_CLIENT_SECRET)); //
		postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
		postParams.add(new BasicNameValuePair("state", naverState)); //
		postParams.add(new BasicNameValuePair("code", autorize_code)); // 로그인 과정 중 얻은 code 값
		
		// HttpClient: 다른 서버로 request를 보낼 때 사용
		// maven 의존설 설정 필요 artifactId: httpclient
		final HttpClient client = HttpClientBuilder.create().build();
		// Post 방식으로
		final HttpPost post = new HttpPost(RequestUrl);
		JsonNode returnNode = null;

		try {
			// UrlEncodedFormEntity
			// URL 인코딩 된 쌍의 목록으로 구성된 엔티티
			// 이것은 일반적으로 HTTP POST 요청을 보내는 동안 유용
			post.setEntity(new UrlEncodedFormEntity(postParams));
			// post를 HttpClient를 통해 실행한 결과값을 HttpResponse에 담는다.
			final HttpResponse response = client.execute(post);
			final int responseCode = response.getStatusLine().getStatusCode();

			// JSON 형태 반환값 처리
			// ObjectMapper는 기본 POJO 에서 또는 범용 JSON Tree Model (JsonNode)에서
			// JSON으로 읽고 쓰는 기능과 변환 수행을위한 관련 기능을 제공합니다.
			ObjectMapper mapper = new ObjectMapper();
			
			// JsonNode에 저장
			returnNode = mapper.readTree(response.getEntity().getContent());

		} catch (UnsupportedEncodingException e) {

			e.printStackTrace();

		} catch (ClientProtocolException e) {

			e.printStackTrace();

		} catch (IOException e) {

			e.printStackTrace();

		} finally {
			// clear resources
		}
		// returnNode 중에 "access_token"에 해당하는 부분만 문자열로 변환하여 리턴
		return returnNode.get("access_token").toString();
	}
	
	// 접근 토큰(access_token)을 성공적으로 발급 받았을 경우 
	public JsonNode getNaverUserInfo(String autorize_code, HttpSession session) {
		// 사용자 프로필 정보 조회 요청 URL
		final String RequestUrl = "https://openapi.naver.com/v1/nid/me";
		
		// 서버와 서버간 request
		final HttpClient client = HttpClientBuilder.create().build();
		final HttpPost post = new HttpPost(RequestUrl);
		String accessToken = getAccessToken(autorize_code, session);
		// add header
		// Authorization: {토큰 타입] {접근 토큰] 형식으로 전달
		post.addHeader("Authorization", "Bearer " + accessToken);

		JsonNode returnNode = null;

		try {

			final HttpResponse response = client.execute(post);
			final int responseCode = response.getStatusLine().getStatusCode();
//	        System.out.println("\nSending 'POST' request to URL : " + RequestUrl);
//	        System.out.println("Response Code : " + responseCode);

			// JSON 형태 반환값 처리
			ObjectMapper mapper = new ObjectMapper();
			returnNode = mapper.readTree(response.getEntity().getContent());
		} catch (UnsupportedEncodingException e) {

			e.printStackTrace();
		} catch (ClientProtocolException e) {

			e.printStackTrace();
		} catch (IOException e) {

			e.printStackTrace();
		} finally {

			// clear resources
		}
		return returnNode;
	}

}
