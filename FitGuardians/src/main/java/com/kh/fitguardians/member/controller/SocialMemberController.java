package com.kh.fitguardians.member.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.kh.fitguardians.common.model.vo.QrInfo;
import com.kh.fitguardians.member.model.service.MemberServiceImpl;
import com.kh.fitguardians.member.model.vo.BodyInfo;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.member.model.vo.MemberInfo;

import static com.kh.fitguardians.common.template.APIPropertiesSelecter.*;

@Controller
public class SocialMemberController {
	
	@Autowired
	private MemberServiceImpl mService = new MemberServiceImpl();

	@ResponseBody
	@RequestMapping(value = "socialLogin.me", produces = "text/plain; charset=UTF-8")
	public String loginMember(String social) throws IOException {
		
		if(social.equals("kakao")) {
			return kakaoLoginMember();
		}else if(social.equals("naver")){
			return naverLoginMember();
		}else if(social.equals("google")){
			return googleLoginMember();
		}else {
			return "";
		}
		
	}
	
	// 카카오 요청 URL
	public String kakaoLoginMember() throws IOException {
		
		Properties prop = properties();
		
		String kakaoRestApi = prop.getProperty("kakaoRestApi");
		String redirectUri = prop.getProperty("kakaoRedirectUri");
		String encodedRedirectUri = URLEncoder.encode(redirectUri, "UTF-8");
		
		if(kakaoRestApi == null || redirectUri == null) {
			throw new IllegalArgumentException("Property 파일이 존재하지만, 카카오 클라이언트 설정 값들을 확인할 수 없습니다.");
	    }
		
		String reqUrl = "https://kauth.kakao.com/oauth/authorize"
					  + "?client_id=" + kakaoRestApi
					  + "&redirect_uri=" + encodedRedirectUri
					  + "&response_type=" + "code";
		
		return reqUrl;
	}
	
	// 카카오 콜백 URI == 
	@RequestMapping("/kakaoLoginCallback")
	public String kakaoCallback(String code, HttpSession session, HttpServletRequest request) throws IOException {
		
		Properties prop = properties();
		
		String kakaoRestApi = prop.getProperty("kakaoRestApi");
		String redirectUri = prop.getProperty("kakaoRedirectUri");
		
		String tokenUrl = "https://kauth.kakao.com/oauth/token";
		
		String postParams = "grant_type=" + "authorization_code"
						  + "&client_id=" + kakaoRestApi
				          + "&redirect_uri=" + URLEncoder.encode(redirectUri, "UTF-8")
				          + "&code=" + code
						  // + "&client_secret" + "보안코드(이 프로젝트엔 발급하지 않는관계로 미설정, 즉 필수가 아님)"
		;
		
		// 파라미터 설정(POST임)
		URL url = new URL(tokenUrl);
	    HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
	    urlConn.setRequestMethod("POST");
	    urlConn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
	    urlConn.setDoOutput(true); // POST 형식으로 보내겠다는 뜻
	    
	    OutputStream os = urlConn.getOutputStream();
	    os.write(postParams.getBytes());
	    os.flush();
	    os.close();
	    
	    int responseCode = urlConn.getResponseCode();
	    if(responseCode == HttpURLConnection.HTTP_OK) {
	    	BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
	    	String line;
	    	StringBuilder response = new StringBuilder();
	    	
	    	while ((line = br.readLine()) != null) {
	            response.append(line);
	        }
	    	br.close();
	    	
	    	JsonObject jsonRes = new Gson().fromJson(response.toString(), JsonObject.class);
	    	String accessToken = jsonRes.get("access_token").getAsString();
	    	session.setAttribute("accessToken", accessToken);
	    	// 사용자 정보 추출 및 리다이렉트 
	    	String redirect = getKakaoUserProfile(accessToken, session, request);
	    	
	    	// 추가정보 확인하기
	    	int userNo = ((Member)session.getAttribute("loginUser")).getUserNo();
	    	boolean hasAdditionalInfo = mService.checkAdditionalInfo(userNo);
	    	
	    	// bodyInfo 유무 확인
	    	String userId = ((Member)session.getAttribute("loginUser")).getUserId();
	    	boolean hasBodyInfo = mService.checkBodyInfo(userId);
	    	
	    	// 추가정보가 있다면 적용
	    	if(hasAdditionalInfo) {
	    		MemberInfo mi = mService.getMemberInfo(userNo);
    			session.setAttribute("mi", mi);
	    	}
	    	
	    	// bodyinfo 있다면 적용
	    	if(hasBodyInfo) {
	    		BodyInfo bi = mService.getBodyInfo(userId);
	    		session.setAttribute("bi", bi);		
	    	}
	    	
	    	// 세션에 추가 정보 입력 후 저장
	    	session.setAttribute("hasAdditionalInfo", hasAdditionalInfo);
	    	session.setAttribute("hasBodyInfo", hasBodyInfo);
	    	
	    	return redirect;
	    }else {
	    	throw new IOException("토큰에 접근하는데에 실패하였습니다, 응답 코드 : " + responseCode);
	    }
	}
	
	// 카카오 사용자 데이터 활용
	public String getKakaoUserProfile(String accessToken, HttpSession session, HttpServletRequest request) throws IOException {
		String userInfoUrl = "https://kapi.kakao.com/v2/user/me";
		
		URL url = new URL(userInfoUrl);
		HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
		urlConn.setRequestMethod("GET");
		urlConn.setRequestProperty("Authorization", "Bearer " + accessToken);
		
		int responseCode = urlConn.getResponseCode();
		if(responseCode == HttpURLConnection.HTTP_OK) {
			BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
			String line;
			StringBuilder response = new StringBuilder();
			
			while((line = br.readLine()) != null) {
				response.append(line);
			}
			br.close();
			
			// 사용자 정보 JSON 추출
	        JsonObject userProfile = new Gson().fromJson(response.toString(), JsonObject.class);
	        
	        // 식별 글자 추가한 상태로 랜덤 ID 생성 준비
	        String kakaoRandomId = "K-" + generateRandomId();
	        // 랜덤 PWD 생성 준비
	        String randomPwd = generateRandomPassword();
	        
	        // 추가데이터 추출 준비
			JsonObject kakaoAccount = userProfile.get("kakao_account").getAsJsonObject();
			
			// 이름
			String name = kakaoAccount.has("name")
	                ? kakaoAccount
	                		.get("name")
	                		.getAsString()
	                : null; // 저장할 때는 빈 문자열로 넘겨줘도 오라클에서 null로 받아옴
	        // 이메일
			String email = kakaoAccount.has("email")
			                ? kakaoAccount
			                		.get("email")
			                		.getAsString()
			                : null;
			// 성별 (기본적으로 male/female 받음, 통일화함)
	        String gender = kakaoAccount.has("gender")
	                ? kakaoAccount.get("gender").getAsString()
	                : null;
	        String normGender = normalizeGender(gender);
	        
	        // 휴대폰 번호 (기본 형식 : +82 10-0000-0000)(수정된 형식 : 01000000000)
			String phoneNumber = kakaoAccount.has("phone_number")
			                ? kakaoAccount.get("phone_number")
			                		.getAsString()
			                : null;
			if(phoneNumber != null && phoneNumber.startsWith("+82")) {
				phoneNumber = phoneNumber.replace("+82 ", "0") // '+82 '를 0으로 변환(외국인이 회원가입하려고하면 어떡하지)
							.replaceAll("-", ""); 			   // '-'를 제거
			}
			
			// 출생연도(나이로 만들기)
    		String birthYear = kakaoAccount.has("birthyear")
                    ? kakaoAccount.get("birthyear").getAsString()
                    : null;
            String age = calculateAge(birthYear) != null ? calculateAge(birthYear) : null;
            
            // 카카오 고유 ID(DB의 API속성에 넣을 것임)
            String api = userProfile.get("id").getAsString();
            
            // 프로필 사진 (경로가 나오는데, 링크타고 들어가면 이미지가 출력)
            String profileImage = userProfile.get("properties").getAsJsonObject().has("profile_image")
                    ? userProfile.get("properties").getAsJsonObject().get("profile_image").getAsString()
                    : null;
            
            
            
            if(name == null || email == null || api == null) {
            	// 이름, 이메일 = NOT NULL / api키 = 소셜로그인에 있어서 반드시 필요함
    	    	request.setAttribute("socialLoginError", "이름과 이메일 등 필수 정보가 필요합니다!");
            	return "forward:loginform.me";
            }
            
            // 사용자가 DB에 있는지 확인(API로 식별)
            Member existingUser = mService.selectMemberBySocialIdKey(api);
            if(existingUser == null) {
            	// 사용자 정보가 없으면 DB에 등록
            	Member newUser = new Member();
            	newUser.setUserId(kakaoRandomId);
            	newUser.setUserPwd(randomPwd);
            	newUser.setUserName(name);
            	newUser.setEmail(email);
            	newUser.setGender(normGender);
            	newUser.setPhone(phoneNumber);
            	newUser.setAge(age);
            	newUser.setApi(api);
            	
            	// 프로필 사진 (중복 방지용 로직 포함)
            	String savedProfileImage = null;
                if (profileImage != null) {
                	savedProfileImage = downloadAndRenamePic(profileImage);  // 이미지 다운로드 및 파일명 수정
                }else {
                	if(normGender.equals("F")) {
                		savedProfileImage = "resources/profilePic/gymW.png";
                	}else {
                		savedProfileImage = "resources/profilePic/gymM.png";
                	}
                }
            	newUser.setProfilePic(savedProfileImage);
            	
            	String qrPath = qrCreater(newUser);
            	newUser.setQr(qrPath);
            	
            	// DB에 새로운 사용자 저장하기
            	int result = mService.insertSocialMember(newUser);
            	
            	if(result > 0) {
            		// 등록되고난 후에 해당 사용자의 모든 데이터 가져오고 기본 추가정보 적용
            		Member m = mService.selectMemberByUserId(kakaoRandomId);
            		MemberInfo mi = defaultMemberInfoInsert(m.getUserNo());
            		BodyInfo bi = defaultBodyInfoInsert(m.getUserId());
            		
            		// 등록된 사용자 정보 세션에 저장
            		session.setAttribute("loginUser", m);
            		session.setAttribute("mi", mi);
            		session.setAttribute("bi", bi);
            		
            		// MemberController로부터 사용
            		return "redirect:dashboard.me";
            	}else {
            		// 등록 실패, 기존 로그인 창으로 리다이랙트
            		session.setAttribute("errorMsg", "로그인 실패");
            		return "redirect:loginform.me";
            	}
            	
            }else {
            	// 기존 사용자 정보가 있을 경우 세션에 저장
            	session.setAttribute("loginUser", existingUser);
            	// 회원 추가정보 가져오기
				MemberInfo mi = mService.getMemberInfo(existingUser.getUserNo());
				
				// 회원 신체정보 가져오기
				BodyInfo bi = mService.getBodyInfo(existingUser.getUserId());
				
				// 회원 최근 6개 신체정보 가져오기
		    	ArrayList<BodyInfo> recentBi = mService.getRecentInfo(existingUser.getUserId());
				
		    	// 트레이너 정보 알아오기
		    	String trainerId = existingUser.getPt();
				Member trainer = mService.getTrainerInfo(trainerId);
		    	
				// 회원
				session.setAttribute("trainer", trainer);
				session.setAttribute("mi", mi);
				session.setAttribute("bi", bi);
				session.setAttribute("recentBi", recentBi);
				
            	
				return "redirect:dashboard.me";
            }
		}else {
			session.setAttribute("errorMsg", "사용자 정보 데이터를 가져올 수 없습니다.");
			return "redirect:loginform.me";
		}
	}
	
	// 네이버 요청 URL
	public String naverLoginMember() throws IOException {
		
		Properties prop = properties();

	    String clientId = prop.getProperty("naverClientId");
	    String clientSecret = prop.getProperty("naverClientSecret");
	    String redirectUri = prop.getProperty("naverRedirectUri");
	    String encodedRedirectUri = URLEncoder.encode(redirectUri, "UTF-8");

	    if (clientId == null || clientSecret == null || redirectUri == null) {
	        throw new IllegalArgumentException("Property 파일이 존재하지만, 네이버 클라이언트 설정 값들을 확인할 수 없습니다.");
	    }

	    String reqUrl = "https://nid.naver.com/oauth2.0/authorize"
	                    + "?response_type=" + "code"
	                    + "&client_id=" + clientId
	                    + "&redirect_uri=" + encodedRedirectUri
	                    + "&state=" + "naverState";

	    return reqUrl;
	}
	
	// 네이버 콜백 URI
	@RequestMapping("/naverLoginCallback")
	public String naverCallback(String code, HttpSession session, HttpServletRequest request) throws IOException {
		Properties prop = properties();

	    String clientId = prop.getProperty("naverClientId");
	    String clientSecret = prop.getProperty("naverClientSecret");
	    String redirectUri = prop.getProperty("naverRedirectUri");

	    String tokenUrl = "https://nid.naver.com/oauth2.0/token";
	    String postParams = "grant_type=authorization_code"
	                      + "&client_id=" + clientId
	                      + "&client_secret=" + clientSecret
	                      + "&code=" + code
	                      + "&redirect_uri=" + URLEncoder.encode(redirectUri, "UTF-8");

	    URL url = new URL(tokenUrl);
	    HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
	    urlConn.setRequestMethod("POST");
	    urlConn.setDoOutput(true);

	    OutputStream os = urlConn.getOutputStream();
	    os.write(postParams.getBytes());
	    os.flush();
	    os.close();

	    int responseCode = urlConn.getResponseCode();
	    if (responseCode == HttpURLConnection.HTTP_OK) {
	        BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
	        String line;
	        StringBuilder response = new StringBuilder();

	        while ((line = br.readLine()) != null) {
	            response.append(line);
	        }
	        br.close();

	        JsonObject jsonResponse = new Gson().fromJson(response.toString(), JsonObject.class);
	        String accessToken = jsonResponse.get("access_token").getAsString();
	        // 사용자 정보 추출 및 리다이렉트
			String redirect = getNaverUserProfile(accessToken, session, request);
	    	
			// 추가정보 확인하기
	    	int userNo = ((Member)session.getAttribute("loginUser")).getUserNo();
	    	boolean hasAdditionalInfo = mService.checkAdditionalInfo(userNo);
	    	
	    	// BodyInfo 확인
	    	String userId = ((Member)session.getAttribute("loginUser")).getUserId();
	    	boolean hasBodyInfo = mService.checkBodyInfo(userId);
	    	
	    	// 추가정보가 있다면 적용
	    	if(hasAdditionalInfo) {
	    		MemberInfo mi = mService.getMemberInfo(userNo);
    			session.setAttribute("mi", mi);
	    	}
	    	
	    	// bodyinfo 있다면 적용
	    	if(hasBodyInfo) {
	    		BodyInfo bi = mService.getBodyInfo(userId);
	    		session.setAttribute("bi", bi);		
	    	}
	    	
	    	// 세션에 추가 정보 입력 후 저장
	    	session.setAttribute("hasAdditionalInfo", hasAdditionalInfo);
	    	session.setAttribute("hasBodyInfo", hasBodyInfo);
	    	
	    	return redirect; 
	    } else {
	    	throw new IOException("토큰에 접근하는데에 실패하였습니다, 응답 코드 : " + responseCode); 
	    }
	}
	
	// 네이버 사용자 데이터 활용
	public String getNaverUserProfile(String accessToken, HttpSession session, HttpServletRequest request) throws IOException {
		String userInfoUrl = "https://openapi.naver.com/v1/nid/me";
		
		URL url = new URL(userInfoUrl);
		HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
		urlConn.setRequestMethod("GET");
		urlConn.setRequestProperty("Authorization", "Bearer " + accessToken);
		
		int responseCode = urlConn.getResponseCode();
	    if(responseCode == HttpURLConnection.HTTP_OK) {
	    	BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
	        String line;
	        StringBuilder response = new StringBuilder();

	        while ((line = br.readLine()) != null) {
	            response.append(line);
	        }
	        br.close();
	        
	        JsonObject userProfile = new Gson().fromJson(response.toString(), JsonObject.class);
	        JsonObject responseObj = userProfile.getAsJsonObject("response");
	        
	        // 식별 글자 추가한 상태로 랜덤 ID 생성 준비
	        String naverRandomId = "N-" + generateRandomId();
	        String randomPwd = generateRandomPassword();
	        
	        // 이메일
	        String email = responseObj.has("email") 
	        		? responseObj.get("email").getAsString() 
	        		: null;
	        		
	        // 이름
	        String name = responseObj.has("name") 
	        		? responseObj.get("name").getAsString() 
	        		: null;
	        		
	        // 프로필 사진(경로)
	        String profileImage = responseObj.has("profile_image") 
	        		? responseObj.get("profile_image").getAsString() 
	        		: null;
	        
	        // 출생연도(나이로 만들기)
	        String birthYear = responseObj.has("birthyear") 
	        		? responseObj.get("birthyear").getAsString() 
	        		: null;
	        String age = calculateAge(birthYear) != null ? calculateAge(birthYear) : null;
	        
	        // 성별(M/F 받으므로 따로 통일화 X)
	        String gender = responseObj.has("gender") 
	        		? responseObj.get("gender").getAsString() 
	        		: null;
	        		
	        // 휴대폰 번호(형식 : 010-0000-0000)(수정된 형식 : 01000000000)
	        String mobile = responseObj.has("mobile") 
	        		? responseObj.get("mobile").getAsString() 
	        		: null;
    		mobile = mobile != null ? mobile.replaceAll("-", "") : null; 	// '-'를 제거
	        
	        // 네이버 고유 ID(DB의 API속성에 넣을 것임)
	        String api = responseObj.get("id").getAsString();
            
            if(name == null || email == null || api == null) {
            	// 이름, 이메일 = NOT NULL / api키 = 소셜로그인에 있어서 반드시 필요함
    	    	request.setAttribute("socialLoginError", "이름과 이메일 등 필수 정보가 필요합니다!");
            	return "forward:loginform.me";
            }
            
            // 사용자 DB 존재 확인(API로 식별)
            Member existingUser = mService.selectMemberBySocialIdKey(api);
            if(existingUser == null) {
            	Member newUser = new Member();
            	newUser.setUserId(naverRandomId);
            	newUser.setUserPwd(randomPwd);
            	newUser.setEmail(email);
            	newUser.setUserName(name);
            	newUser.setAge(age);
            	newUser.setGender(gender);
            	newUser.setPhone(mobile);
            	newUser.setApi(api);
            	
            	// 프로필 사진 (중복 방지용 로직 포함)
            	String savedProfileImage = null;
                if (profileImage != null) {
                	savedProfileImage = downloadAndRenamePic(profileImage);  // 이미지 다운로드 및 파일명 수정
                }else {
                	if(gender.equals("F")) {
                		savedProfileImage = "resources/profilePic/gymW.png";
                	}else {
                		savedProfileImage = "resources/profilePic/gymM.png";
                	}
                }
            	newUser.setProfilePic(savedProfileImage);
            	
            	String qrPath = qrCreater(newUser);
            	newUser.setQr(qrPath);
            	
            	int result = mService.insertSocialMember(newUser);
            	if(result > 0) {
            		// 등록되고난 후에 해당 사용자의 모든 데이터 가져오고 기본 추가정보 적용
            		Member m = mService.selectMemberByUserId(naverRandomId);
            		MemberInfo mi = defaultMemberInfoInsert(m.getUserNo());
            		BodyInfo bi = defaultBodyInfoInsert(m.getUserId());
            		
            		// 등록된 사용자 정보 세션에 저장
            		session.setAttribute("loginUser", m);
            		session.setAttribute("mi", mi);
            		session.setAttribute("bi", bi);
            		
            		return "redirect:dashboard.me";
            	}else {
            		// 등록 실패, 기존 로그인 창으로 리다이랙트
            		session.setAttribute("errorMsg", "로그인 실패");
            		return "redirect:loginform.me";
            	}
            }else{
            	// 기존 사용자 정보가 있을 경우 세션에 저장
            	session.setAttribute("loginUser", existingUser);
            	// 회원 추가정보 가져오기
            	MemberInfo mi = mService.getMemberInfo(existingUser.getUserNo());
            	
            	// 회원 신체정보 가져오기
            	BodyInfo bi = mService.getBodyInfo(existingUser.getUserId());
            	
            	// 회원 최근 6개 신체정보 가져오기
            	ArrayList<BodyInfo> recentBi = mService.getRecentInfo(existingUser.getUserId());
            	
            	// 트레이너 정보 알아오기
            	String trainerId = existingUser.getPt();
            	Member trainer = mService.getTrainerInfo(trainerId);
            	
            	// 회원
            	session.setAttribute("trainer", trainer);
            	session.setAttribute("mi", mi);
            	session.setAttribute("bi", bi);
            	session.setAttribute("recentBi", recentBi);
            	
            	
            	return "redirect:dashboard.me";
            }
	    }else {
	    	session.setAttribute("errorMsg", "사용자 정보 데이터를 가져올 수 없습니다.");
			return "redirect:loginform.me";
	    }
	}
	
	// 구글 요청 URL
	public String googleLoginMember() throws IOException {
		
		Properties prop = properties();
		
		String clientId = prop.getProperty("googleClientId");
		String redirectUri = prop.getProperty("googleRedirectUri");
		String encodedRedirectUri = URLEncoder.encode(redirectUri, "UTF-8");
		
		if (clientId == null || redirectUri == null) {
	        throw new IllegalArgumentException("Property 파일이 존재하지만, 구글 클라이언트 설정 값들을 확인할 수 없습니다.");
	    }
		
		String reqUrl = "https://accounts.google.com/o/oauth2/v2/auth"
					  + "?response_type=" + "code"
					  + "&client_id=" + clientId
					  + "&redirect_uri=" + encodedRedirectUri
					  + "&scope=" + "email profile"
					  			  + " " + "https://www.googleapis.com/auth/user.birthday.read"
					  			  + " " + "https://www.googleapis.com/auth/user.gender.read"
					  			  + " " + "https://www.googleapis.com/auth/user.phonenumbers.read"
					  			  // 위 스코프에서 공백은 상당히 중요한 역할을 함
					  + "&state=" + "googleState";
		
		return reqUrl;
	}
	
	// 구글 콜백 URI
	@RequestMapping("/googleLoginCallback")
	public String googleCallback(String error, String code, HttpSession session, HttpServletRequest request) throws IOException {
		
		// 구글 전용 에러 파라미터로 취소버튼을 눌렀는지 확인
	    if (error != null && error.equals("access_denied")) {
	        // 사용자가 로그인 취소를 눌렀을 때 리다이랙트
	    	request.setAttribute("socialLoginError", "구글 로그인이 취소 되었습니다. 다시 선택해주세요");
	        return "forward:loginform.me";  
	    }
	    
		Properties prop = properties();
		
		String clientId = prop.getProperty("googleClientId");
	    String clientSecret = prop.getProperty("googleClientSecret");
	    String redirectUri = prop.getProperty("googleRedirectUri");
			
	    String tokenUrl = "https://oauth2.googleapis.com/token";
	    
	    // 구글 토큰 요청
	    URL url = new URL(tokenUrl);
	    HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
		
	    // 파라미터 설정(POST임)
	    String postParams = "code=" + code
	    				  + "&client_id=" + clientId
	    				  + "&client_secret=" + clientSecret
	    				  + "&redirect_uri=" + URLEncoder.encode(redirectUri, "UTF-8")
	    				  + "&grant_type=authorization_code";
	    
	    urlConn.setDoOutput(true); // POST 형식으로 보내겠다는 뜻
	    OutputStream os = urlConn.getOutputStream();
	    os.write(postParams.getBytes());
	    os.flush();
	    os.close();
	    
	    int responseCode = urlConn.getResponseCode();
	    if(responseCode == HttpURLConnection.HTTP_OK) {
	    	BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
	    	String line;
	    	StringBuilder response = new StringBuilder();	    	
	    	
	    	while((line = br.readLine()) != null) {
	    		response.append(line);
	    	}
	    	br.close();
	    	
	    	
	    	JsonObject jsonRes = new Gson().fromJson(response.toString(), JsonObject.class);
	    	String accessToken = jsonRes.get("access_token").getAsString();
	    	// 사용자 정보 추출 및 리다이렉트 
	    	String redirect = getGoogleUserProfile(accessToken, session, request);
	    	
	    	// 추가정보 확인하기
	    	int userNo = ((Member)session.getAttribute("loginUser")).getUserNo();
	    	boolean hasAdditionalInfo = mService.checkAdditionalInfo(userNo);
	    	
	    	// bodyInfo 유무 확인
	    	String userId = ((Member)session.getAttribute("loginUser")).getUserId();
	    	boolean hasBodyInfo = mService.checkBodyInfo(userId);
	    	
	    	// 추가정보가 있다면 적용
	    	if(hasAdditionalInfo) {
	    		MemberInfo mi = mService.getMemberInfo(userNo);
    			session.setAttribute("mi", mi);
	    	}
	    	
	    	if(hasBodyInfo) {
	    		BodyInfo bi = mService.getBodyInfo(userId);
	    		session.setAttribute("bi", bi);
	    	}
	    	
	    	// 세션에 추가 정보 입력 후 저장
	    	session.setAttribute("hasAdditionalInfo", hasAdditionalInfo);
	    	session.setAttribute("hasBodyInfo", hasBodyInfo);
	    	
	    	return redirect; 
	    }else {
	    	throw new IOException("토큰에 접근하는데에 실패하였습니다, 응답 코드 : " + responseCode);
	    }
	}
	
	// 구글 사용자 데이터 활용
	public String getGoogleUserProfile(String accessToken, HttpSession session, HttpServletRequest request) throws IOException {
		String userInfoUrl = "https://people.googleapis.com/v1/people/me?personFields=names,emailAddresses,genders,birthdays,phoneNumbers,addresses";
	    
		URL url = new URL(userInfoUrl);
		HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
	    urlConn.setRequestMethod("GET");
	    urlConn.setRequestProperty("Authorization", "Bearer " + accessToken);
	    
	    int responseCode = urlConn.getResponseCode();
	    if(responseCode == HttpURLConnection.HTTP_OK) {
	    	BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
	        String line;
	        StringBuilder response = new StringBuilder();

	        while ((line = br.readLine()) != null) {
	            response.append(line);
	        }
	        br.close();
	        
	        // 데이터 추출 준비
	        JsonObject userProfile = new Gson().fromJson(response.toString(), JsonObject.class);
	        
	        // 랜덤 ID와 비밀번호
	        String googleRandomId = "G-" + generateRandomId();
	        String randomPwd = generateRandomPassword();
	        
	        // 이메일
	        String email = userProfile.get("emailAddresses")
	        		.getAsJsonArray()
	        		.get(0)
	        		.getAsJsonObject()
	        		.get("value")
	        		.getAsString();
	        // 이름
	        String name = userProfile.get("names")
	        		.getAsJsonArray()
	        		.get(0)
	        		.getAsJsonObject()
	        		.get("displayName")
	        		.getAsString();
	        // 성별(male/female 받음, 통일화함)
	        String gender = userProfile.has("genders") 
	        		? userProfile.get("genders")
	        				.getAsJsonArray()
	        				.get(0).getAsJsonObject()
	        				.get("value")
	        				.getAsString()
	        		: null;
	        String normGender = normalizeGender(gender);
	        
	        // 생일(나이로 변환함)
	        JsonObject birthdayObject = userProfile.get("birthdays")
	        		.getAsJsonArray()
	        		.get(1)
	        		.getAsJsonObject()
	        		.get("date")
	        		.getAsJsonObject();
	        String birthYear = birthdayObject.has("year") 
	                ? birthdayObject.get("year")
	                		.getAsString()
	                : null;
	        String age = calculateAge(birthYear) != null ? calculateAge(birthYear) : null;
	        
	        // 구글 고유 ID(DB의 API속성에 넣을 것임)
	        String api = userProfile.get("resourceName").getAsString();
	        
	        // 휴대폰 번호 (형식 : 010-0000-0000)(수정된 형식 : 01000000000)
            String phoneNumber = userProfile.has("phoneNumbers") 
            		? userProfile.get("phoneNumbers")
            				.getAsJsonArray()
            				.get(0)
            				.getAsJsonObject()
            				.get("value")
            				.getAsString() 
            		: null;
            phoneNumber = phoneNumber != null ? phoneNumber.replaceAll("-", "") : null;
            // 주소 (사용자가 임의로 문자를 직접 입력하는 양식으로부터 가져오는 데이터라서, 우편번호까지 가져오는 것은 불가능함, 주석처리)
//            String address = userProfile.has("addresses") 
//            		? userProfile.get("addresses")
//            				.getAsJsonArray()
//            				.get(0)
//            				.getAsJsonObject()
//            				.get("formattedValue")
//            				.getAsString() 
//            		: "";
            
            if(name == null || email == null || api == null) {
            	// 이름, 이메일 = NOT NULL / api키 = 소셜로그인에 있어서 반드시 필요함
    	    	request.setAttribute("socialLoginError", "이름과 이메일 등 필수 정보가 필요합니다!");
            	return "forward:loginform.me";
            }
            
			// 사용자 DB 존재 확인
            Member existingUser = mService.selectMemberBySocialIdKey(api);
            if(existingUser == null) {
            	Member newUser = new Member();
            	newUser.setUserId(googleRandomId);
            	newUser.setUserPwd(randomPwd);
            	newUser.setEmail(email);
            	newUser.setUserName(name);
            	newUser.setGender(normGender);
            	newUser.setAge(age);
            	newUser.setPhone(phoneNumber);
            	newUser.setApi(api);
            	
            	String defPic = normGender.equals("F") ? "resources/profilePic/gymW.png" : "resources/profilePic/gymM.png";
            	newUser.setProfilePic(defPic);
            	
            	String qrPath = qrCreater(newUser);
            	newUser.setQr(qrPath);
            	
            	int result = mService.insertSocialMember(newUser);
            	if(result > 0) {
            		// 등록되고난 후에 해당 사용자의 모든 데이터 가져오고 기본 추가정보 적용
            		Member m = mService.selectMemberByUserId(googleRandomId);
            		MemberInfo mi = defaultMemberInfoInsert(m.getUserNo());
            		BodyInfo bi = defaultBodyInfoInsert(m.getUserId());
            		
            		// 등록된 사용자 정보 세션에 저장
            		session.setAttribute("loginUser", m);
            		session.setAttribute("mi", mi);
            		session.setAttribute("bi", bi);
            		
            		return "redirect:dashboard.me";
            	}else {
            		// 등록 실패, 기존 로그인 창으로 리다이랙트
            		session.setAttribute("errorMsg", "로그인 실패");
            		return "redirect:loginform.me";
            	}
            }else{
            	// 기존 사용자 정보가 있을 경우 세션에 저장
            	session.setAttribute("loginUser", existingUser);
            	// 회원 추가정보 가져오기
            	MemberInfo mi = mService.getMemberInfo(existingUser.getUserNo());
            	
            	// 회원 신체정보 가져오기
            	BodyInfo bi = mService.getBodyInfo(existingUser.getUserId());
            	
            	// 회원 최근 6개 신체정보 가져오기
            	ArrayList<BodyInfo> recentBi = mService.getRecentInfo(existingUser.getUserId());
            	
            	// 트레이너 정보 알아오기
            	String trainerId = existingUser.getPt();
            	Member trainer = mService.getTrainerInfo(trainerId);
            	
            	// 회원
            	session.setAttribute("trainer", trainer);
            	session.setAttribute("mi", mi);
            	session.setAttribute("bi", bi);
            	session.setAttribute("recentBi", recentBi);
            	
            	
            	return "redirect:dashboard.me";
            }
	    }else {
	    	session.setAttribute("errorMsg", "사용자 정보 데이터를 가져올 수 없습니다.");
			return "redirect:loginform.me";
	    }
	}
	
	// 현재 년도를 반영해서 나이 지정하기
	public String calculateAge(String birthYear) {
		int age;
        String ageStr = null;
        if(birthYear != null) {
        	int birthYearInt = Integer.parseInt(birthYear);
        	int currentYear = new Date().getYear() + 1901; // 양력 반영으로 인해서 1901년 추가
        	age = currentYear - birthYearInt;
        	ageStr = Integer.toString(age);
        }
        return ageStr;
	}
	
	// gender값 통일화하기
	public String normalizeGender(String gender) {
		if(gender != null){
			// 무조건 소문자로 변환하게 함
			gender = gender.toLowerCase();
			
			switch (gender) {
			// 남성일 경우
			case "male":
			case "m":
				return "M";
			// 여성일 경우
			case "female":
			case "f":
				return "F";
			// 잘못된 값이 넘어올 경우
			default:
				return null;
			}
		}else {
			return null;
		}
	}
	
	// 소셜 프로필 이미지 관련해서 필요한 작업(@Autowired) + QR도 필요
	@Autowired
	private ServletContext context;
	
	// 소셜에서 이미지 가져오고 이름 지정 후 저장하는 기능
	public String downloadAndRenamePic(String profileImage) throws IOException {
		
		URL url = new URL(profileImage);
		
		// 스트림 열기
		InputStream is = url.openStream();
		
//		String originName = profileImage.substring(profileImage.lastIndexOf("/"));
//		String fileExtens = originName.substring(originName.lastIndexOf("."));
		
		// (현재시간 + 랜덤숫자 5글자)파일명 생성
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		int ranNum = (int)(Math.random() * 90000 + 10000);
		
		// 확장자 추출
		String extens = profileImage.substring(profileImage.lastIndexOf("."));
		
		// 종합해서 파일명 적용
		String fileName = currentTime + ranNum + extens;
		
		// 경로 찾기
		String saveDir = "resources/profilePic/";
		File dir = new File(saveDir);
		if(!dir.exists()) {
			dir.mkdir();
		}
		
		String savePath = saveDir + fileName;
		
		// 파일 저장
		String absoluteSaveDir = context.getRealPath(saveDir);
		Files.copy(is, Paths.get(absoluteSaveDir + fileName));
		
		// 스트림 닫기
		is.close();
		
		return savePath;
	}
	// 랜덤 아이디 생성
	private static final String RAN_ID_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
										 + "abcdefghijklmnopqrstuvwxyz"
										 + "0123456789";
	private static final int RAN_ID_LENGTH = 20;	// 20바이트에 맞춘 아이디 길이(VARCHAR2(30))
	public String generateRandomId() {
		SecureRandom random = new SecureRandom();
		StringBuilder id = new StringBuilder(RAN_ID_LENGTH);
		
		for(int i=0; i<RAN_ID_LENGTH; i++) {
			int randomIndex = random.nextInt(RAN_ID_CHARS.length());
			id.append(RAN_ID_CHARS.charAt(randomIndex));
		}
		
		return id.toString();
	}
	
	
	// 랜덤 비밀번호 생성
	private static final String RAN_PWD_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
										   + "abcdefghijklmnopqrstuvwxyz"
										   + "0123456789"
										   + "$/";
	private static final int RAN_PASSWORD_LENGTH = 90;  // 90바이트에 맞춘 비밀번호 길이(VARCHAR2(100))
	public String generateRandomPassword() {
		SecureRandom random = new SecureRandom();
		StringBuilder password = new StringBuilder(RAN_PASSWORD_LENGTH);
		
		for(int i=0; i<RAN_PASSWORD_LENGTH; i++) {
			int randomIndex = random.nextInt(RAN_PWD_CHARS.length());
			password.append(RAN_PWD_CHARS.charAt(randomIndex));
		}
		return password.toString();
	}
	
	// 모달 창에서 '나중에 하기'를 눌렀을 경우, 임시적으로 모달 창을 비활성화 하게함
	@ResponseBody
	@RequestMapping("delayAdditionalInfo.me")
	public void delayAdditionalInfo(HttpSession session) {
		session.setAttribute("hasAdditionalInfo", true);
		session.setAttribute("hasBodyInfo", true);
	}
	
	// 소셜 로그인 사용자를 위한 추가 정보 입력 기능
	@ResponseBody
	@RequestMapping(value = "addAdditionalInfo.me", produces = "text/plain; charset=UTF-8")
	public String addAdditionalInfo(@RequestBody MemberInfo memberInfo, BodyInfo bodyInfo, HttpSession session) {
	    // 사용자 식별 번호를 가져오기 위한 작업
	    Member loginMember = (Member)session.getAttribute("loginUser");

	    // 사용자 번호 설정
	    memberInfo.setUserNo(loginMember.getUserNo());
	    
	    // bodyInfo 정보 생성
	    bodyInfo.setUserId(loginMember.getUserId());
	    // bodyInfo 값 삽입 여부 판단
	    int result1 = 0;
	    
	    // 성별에 따라 계산
	    if(loginMember.getGender().equals("M")) { // 남자라면
	    	double heightInMeters = memberInfo.getHeight() / 100.0;
	    	double mAge = Double.parseDouble(loginMember.getAge());
        	double mBmi = memberInfo.getWeight() / Math.pow(heightInMeters, 2);
        	double mSmm = 0.407 * memberInfo.getWeight() + 0.267 * memberInfo.getHeight() - 19.2;
        	double mFat = 1.20 * mBmi + 0.23 * mAge - 16.2;
        	
        	bodyInfo.setBmi(mBmi);
        	bodyInfo.setSmm(mSmm);
        	bodyInfo.setFat(mFat);
        	
        	result1 = mService.addSocialMemberBodyInfo(bodyInfo);
        	
	    }else { // 여자라면
	    	double heightInMeters = memberInfo.getHeight() / 100.0;
	    	double fAge = Double.parseDouble(loginMember.getAge());
        	double fBmi = memberInfo.getWeight() / Math.pow(heightInMeters, 2);
        	double fSmm = 0.252 * memberInfo.getWeight() + 0.473 * memberInfo.getHeight() - 48.3;
        	double fFat = 1.20 * fBmi + 0.23 * fAge - 5.4;
        	
        	bodyInfo.setBmi(fBmi);
        	bodyInfo.setSmm(fSmm);
        	bodyInfo.setFat(fFat);
        	
        	result1 = mService.addSocialMemberBodyInfo(bodyInfo);
	    }
	    
	    int result2 = mService.addAdditionalSocialMemberInfo(memberInfo);
	    
	    if(result1 > 0 && result2 > 0) {
	    	// 세션에 입력하는 갱신된 추가정보 넣기
	    	MemberInfo mi = mService.getMemberInfo(loginMember.getUserNo());
	    	BodyInfo bi = mService.getBodyInfo(loginMember.getUserId());
	    	session.setAttribute("mi", mi);
	    	session.setAttribute("bi", bi);
	    	
	    	// 추가정보와 신체정보가 반영되었으니, 세션에 반영되었다는 것을 저장(위의 메소드 재활용)
	    	delayAdditionalInfo(session);
	    	
	        return "success";
	    } else {
	        return "error";
	    }
	}
	
	// 기존 회원가입에서 가져와서 사용한 QR추가 기능
	public String qrCreater(Member newUser) throws IOException {
		QrInfo qr = new QrInfo();
		String filePath = "";
		if(newUser.getQr() == null) {
			qr.setId(newUser.getUserId());
			qr.setType("trainee"); // 일반 사용자 전용 소셜로그인
			qr.setCreatedAt(LocalDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME));
			qr.setValidUntil(LocalDateTime.now().plusYears(1).format(DateTimeFormatter.ISO_DATE_TIME));
			ObjectMapper objectMapper = new ObjectMapper();
			
			String qrData = objectMapper.writeValueAsString(qr); 
			String fileName = newUser.getUserId() + ".png"; // 파일명 설정
		    filePath = context.getRealPath("https://kimsssang.github.io/FinalProject/FitGuardians/src/main/webapp/resources/qrCodes/" + fileName); // ServletContext를 이용해 경로 설정
		    // 디렉터리 존재 여부 확인
			File dir = new File(context.getRealPath("/resources/qrCodes/"));
			if (!dir.exists()) {
		        dir.mkdirs(); // 디렉터리가 없으면 생성
			}
		
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			
			try {
				BitMatrix bitMatrix = qrCodeWriter.encode(qrData, BarcodeFormat.QR_CODE, 200, 200);
				Path path = FileSystems.getDefault().getPath(filePath);
				MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);
				// newUser.setQr(filePath);
			} catch (WriterException e) {
				e.printStackTrace();
			}
			
			int result = mService.insertQrInfo(qr);
			if(result <= 0) {
				return null; // 생성에 실패했다면, null 반환하게 함
			}
		}
		return filePath;
	}
	
	// 사용자 추가 정보를 기본값으로 추가하기 위한 메소드
	public MemberInfo defaultMemberInfoInsert(int userNo) {
		MemberInfo mi = new MemberInfo();
		mi.setUserNo(userNo);
		mi.setHeight(0);
		mi.setWeight(0);
		mi.setDisease(null);
		mi.setGoal("");
		
		int result = mService.defaultMemberInfoInsert(mi);
		if(result > 0) {
			return mi;
		}else {
			return null;
		}
	}
	
	// 사용자의 신체 추가정보를 기본값으로 추가하기 위한 메소드
	public BodyInfo defaultBodyInfoInsert(String userId) {
		BodyInfo bi = new BodyInfo();
		bi.setUserId(userId);
		bi.setBmi(0);
		bi.setFat(0);
		bi.setSmm(0);
		
		int result = mService.defaultBodyInfoInsert(bi);
		if(result>0) {
			return bi;
		}else {
			return null;
		}
	}
}
