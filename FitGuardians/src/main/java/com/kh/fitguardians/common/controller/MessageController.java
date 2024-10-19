package com.kh.fitguardians.common.controller;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import com.kh.fitguardians.member.model.vo.Member;

import static com.kh.fitguardians.common.template.APIPropertiesSelecter.*;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

@Controller
public class MessageController {

	private static final String KAKAO_API_URL = "https://kapi.kakao.com/v2/api/talk/memo/default/send";
	
	
	
	
	
	@RequestMapping("sendQr.me")
	public ResponseEntity<String> kakaoSendQr(HttpServletRequest request) throws IOException {
		String userId = ((Member)request.getSession().getAttribute("loginUser")) != null ? 
                ((Member)request.getSession().getAttribute("loginUser")).getUserId() : null;
        String accessToken = (String) request.getSession().getAttribute("accessToken");
		String qrUrl = ((Member)request.getSession().getAttribute("loginUser")).getQr();
		// 카카오 로그인이 되어 있지 않다면 로그인 먼저
		if(userId == null || !userId.startsWith("K-")) {
			// 카카오 로그인 url 생성 
			return redirectToKakaoLogin();
			
		}
		
		String message = "테스트중";
		boolean sent = sendkakaoMessgae(accessToken, message, qrUrl);
		
		if (sent) {
	        return ResponseEntity.ok("메시지가 성공적으로 전송되었습니다.");
	    } else {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("메시지 전송에 실패했습니다.");
	    }
	}

	

	private ResponseEntity<String> redirectToKakaoLogin() throws IOException {
		Properties prop = properties();
		String kakaoRestApi = prop.getProperty("kakaoRestApi");
		String redirectUrl = prop.getProperty("kakaoRedirectUri");
		String encUrl = URLEncoder.encode(redirectUrl, "UTF-8");
		
		String kakaoLoginUrl = "https://kauth.kakao.com/oauth/authorize" +
                				"?client_id=" + kakaoRestApi +
                				"&redirect_uri=" + encUrl +
                				"&response_type=code";
		
		return ResponseEntity.status(HttpStatus.FOUND).header("Location", kakaoLoginUrl).build();
	}
	
	private boolean sendkakaoMessgae(String accessToken, String message, String qrUrl) {
		try {
			
		
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
		headers.set("Authorization", "Bearer " + accessToken);
		
		String serverUrl = "http://192.168.50.181:8282";  // 실제 서버 IP 주소나 도메인으로 수정
		String templateObject = String.format(
		    "{\"object_type\":\"feed\"," +
		    "\"content\":{\"title\":\"%s\"," +
		    "\"image_url\":\"%s\"," +
		    "\"link\":{\"web_url\":\"%s/resources/qrCodes/%s\",\"mobile_web_url\":\"%s/resources/qrCodes/%s\"}}}",
		    message, qrUrl, serverUrl, "K-ufNR7uBqncHZIytC1R2S.png", serverUrl, "K-ufNR7uBqncHZIytC1R2S.png"  // qrFileName을 적절히 정의하세요
		);
		
        String params = "template_object=" + URLEncoder.encode(templateObject, "UTF-8");
        
        System.out.println("parmas: " + templateObject);
		HttpEntity<String> requestEntity = new HttpEntity<>(params, headers);
		ResponseEntity<String> response = restTemplate.postForEntity(KAKAO_API_URL, requestEntity, String.class);
		
		return response.getStatusCode() == HttpStatus.OK;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
