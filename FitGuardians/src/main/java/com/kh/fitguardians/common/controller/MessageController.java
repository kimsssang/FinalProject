package com.kh.fitguardians.common.controller;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.kh.fitguardians.member.model.vo.Events;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.member.model.vo.Schedule;

import static com.kh.fitguardians.common.template.APIPropertiesSelecter.*;

import java.io.IOException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

@Controller
public class MessageController {

	private static final String KAKAO_API_URL = "https://kapi.kakao.com/v2/api/talk/memo/default/send";
	private static final String KAKAO_CALENDAR_API_URL = "https://kapi.kakao.com/v2/api/calendar/calendars";
	
	
	
	
	@RequestMapping("sendQr.me")
	public String kakaoSendQr(HttpServletRequest request) throws IOException {
		String userId = ((Member)request.getSession().getAttribute("loginUser")) != null ? 
                ((Member)request.getSession().getAttribute("loginUser")).getUserId() : null;
        String accessToken = (String) request.getSession().getAttribute("accessToken");
		String qrUrl = ((Member)request.getSession().getAttribute("loginUser")).getQr();
		// 카카오 로그인이 되어 있지 않다면 로그인 먼저
		if(userId == null || !userId.startsWith("K-")) {
			// 카카오 로그인 url 생성 
			return redirectToKakaoLogin();
			
		}
		
		String message = "출석체크용 QR코드 입니다!";
		boolean sent = sendkakaoMessgae(accessToken, message, qrUrl);
		
		if (sent) {
			request.getSession().setAttribute("alertMsg", "성공적으로 Qr전송이 되었습니다!");
	        return "Trainee/traineeDashboard";
	    } else {
	    	request.getSession().setAttribute("errorMsg", "Qr전송 실패");
	        return "Trainee/traineeDashboard";
	    }
	}
	
	// 캘린더 아이디 조회, 목록조회
	@RequestMapping("calendar.kt")
	public String kakaoCalendar(HttpServletRequest request) throws IOException {
		String userId = ((Member)request.getSession().getAttribute("loginUser")) != null ? 
                ((Member)request.getSession().getAttribute("loginUser")).getUserId() : null;
        String accessToken = (String) request.getSession().getAttribute("accessToken");
        
        // 카카오 로그인이 되어 있지 않다면 로그인 먼저
 		if(userId == null || !userId.startsWith("K-")) {
 			// 카카오 로그인 url 생성 
 			return redirectToKakaoLogin();
     			
 		}
 		
 		String calendarId = getKakaoCalendarId(accessToken);
 		ArrayList<Events> schedule = getKakaoCalendarEvents(accessToken, calendarId);
 		request.setAttribute("kakaoEvents", schedule);
 		
 		System.out.println(schedule);
 		
		return "Trainee/calendarTest";
	}
	
	
	private String getKakaoCalendarId(String accessToken) {
	    if (accessToken == null) {
	        // Access Token이 없으면 null 반환
	        System.out.println("Access token is null");
	        return null;
	    }

	    RestTemplate restTemplate = new RestTemplate();
	    HttpHeaders headers = new HttpHeaders();
	    headers.set("Authorization", "Bearer " + accessToken);
	    
	    // 카카오 캘린더 API URL
	    String calendarApiUrl = "https://kapi.kakao.com/v2/api/calendar/calendars";
	    ResponseEntity<String> response = restTemplate.exchange(
	        calendarApiUrl, 
	        HttpMethod.GET, 
	        new HttpEntity<>(headers),
	        String.class
	    );

	    System.out.println("response : " + response);
	    if (response.getStatusCode() != HttpStatus.OK) {
	        // 에러 처리 (예: 로그 기록)
	        return null; // null 반환
	    }

	    Gson gson = new Gson();
	    JsonObject jsonResponse = gson.fromJson(response.getBody(), JsonObject.class);
	    JsonArray jsonCalendars = jsonResponse.getAsJsonArray("calendars");
	    
	    System.out.println("jsonresponse : " + jsonResponse);
	    System.out.println("jsoncalendars : " + jsonCalendars);
	    
	    // 첫 번째 캘린더 ID 반환
	    if (jsonCalendars != null && jsonCalendars.size() > 0) {
	        JsonObject firstCalendar = jsonCalendars.get(0).getAsJsonObject();
	        return firstCalendar.get("id").getAsString(); // 첫 번째 캘린더 ID 반환
	    }
	    
	    return null; // 캘린더가 없는 경우 null 반환
	}
	
	// 목록조회, 생성하기 후 이벤트의 다른 값도 받아오기
	private ArrayList<Events> getKakaoCalendarEvents(String accessToken, String calendarId) {
	    ArrayList<Events> events = new ArrayList<>();

	    if (accessToken == null || calendarId == null) {
	        System.out.println("Access token or calendar ID is null");
	        return events; // 빈 리스트 반환
	    }

	    RestTemplate restTemplate = new RestTemplate();
	    HttpHeaders headers = new HttpHeaders();
	    headers.set("Authorization", "Bearer " + accessToken);
	    
	    // 카카오 캘린더 이벤트 API URL
	    String eventsApiUrl = "https://kapi.kakao.com/v2/api/calendar/events";

	    // GET 요청
	    ResponseEntity<String> response = restTemplate.exchange(
	    	    eventsApiUrl + "?calendar_id=" + calendarId + "&preset=THIS_MONTH&limit=100",
	    	    HttpMethod.GET,
	    	    new HttpEntity<>(headers),
	    	    String.class
	    	);

	    System.out.println(response);
	    
	    if (response.getStatusCode() != HttpStatus.OK) {
	        System.out.println("Failed to fetch events: " + response.getStatusCode());
	        return events; // 빈 리스트 반환
	    }

	    Gson gson = new Gson();
	    JsonObject jsonResponse = gson.fromJson(response.getBody(), JsonObject.class);
	    JsonArray jsonEvents = jsonResponse.getAsJsonArray("events");

	    for (int i = 0; i < jsonEvents.size(); i++) {
	        JsonObject event = jsonEvents.get(i).getAsJsonObject();
	        Events eventBrief = new Events();
	        
	        // time 객체에서 필요한 정보만 가져오기
	        JsonObject time = event.getAsJsonObject("time");
	        if (time != null) {
	            eventBrief.setStartDate(time.get("start_at").getAsString());
	            eventBrief.setEndDate(time.get("end_at").getAsString());
	            eventBrief.setAllDay(time.get("all_day").getAsBoolean());
	        }

	        events.add(eventBrief);
	    }

	    System.out.println("events : " + events);
	    return events;
	}
	
	// 캘린더 생성하기 urlmapping 
		@RequestMapping("createCalendar.kt")
		public String kakaoCreateCalendar(HttpServletRequest request, Schedule s) throws IOException {
			String userId = ((Member)request.getSession().getAttribute("loginUser")) != null ? 
	                ((Member)request.getSession().getAttribute("loginUser")).getUserId() : null;
	        String accessToken = (String) request.getSession().getAttribute("accessToken");
	        
	        // 카카오 로그인이 되어 있지 않다면 로그인 먼저
	 		if(userId == null || !userId.startsWith("K-")) {
	 			// 카카오 로그인 url 생성 
	 			return redirectToKakaoLogin();
	     			
	 		}
	 		
	 		String calendarId = getKakaoCalendarId(accessToken);
	 		
	 		s.setScheduleTitle("test");
	 		s.setStartDate("2024-10-27T00:00:00Z");
	 		s.setEndDate("2024-10-27T00:00:00Z");
	 		
	 		String result = createCalendar(accessToken, s);
	 		
	 		
	 		System.out.println(result);
	 		
			return "Trainee/calendarTest";
		}
	
		private String createCalendar(String accessToken, Schedule s) {
		    String createEventsApiUrl = "https://kapi.kakao.com/v2/api/calendar/create/event";
		    
		    RestTemplate restTemplate = new RestTemplate();
		    HttpHeaders headers = new HttpHeaders();
		    headers.set("Authorization", "Bearer " + accessToken);
		    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED); // x-www-form-urlencoded로 설정

		    // 요청 파라미터 설정
		    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		    params.add("calendar_id", "primary");
		    
		    // 이벤트 객체 추가 (JSON 문자열을 직접 추가)
		    String eventJson = "{"
		            + "\"title\": \"" + s.getScheduleTitle() + "\","
		            + "\"time\": {"
		            + "\"start_at\": \"" + "2024-10-27T00:00:00Z" + "\","
		            + "\"end_at\": \"" + "2024-10-28T00:00:00Z" + "\","
		            + "\"time_zone\": \"Asia/Seoul\","
		            + "\"all_day\": true,"
		            + "\"lunar\": false"
		            + "},"
		            + "\"description\": \"일정 설명\","
		            + "\"color\": \"RED\""
		            + "}";
		    
		    params.add("event", eventJson); // 이벤트 객체 추가
		    
		    ResponseEntity<String> response = restTemplate.postForEntity(
		            createEventsApiUrl,
		            new HttpEntity<>(params, headers),
		            String.class
		    );

		    if (response.getStatusCode() == HttpStatus.OK) {
		        System.out.println("Event created successfully: " + response.getBody());
		        return response.getBody();
		    } else {
		        System.out.println("Failed to create event: " + response.getStatusCode());
		        return response.getStatusCode() + "";
		    }
		}
	
	
	
	
	private String redirectToKakaoLogin() throws IOException {
		Properties prop = properties();
		String kakaoRestApi = prop.getProperty("kakaoRestApi");
		String redirectUrl = prop.getProperty("kakaoRedirectUri");
		String encUrl = URLEncoder.encode(redirectUrl, "UTF-8");
		
		String kakaoLoginUrl = "https://kauth.kakao.com/oauth/authorize" +
                				"?client_id=" + kakaoRestApi +
                				"&redirect_uri=" + encUrl +
                				"&response_type=code";
		
		return "redirect:" + kakaoLoginUrl;
	}
	
	private boolean sendkakaoMessgae(String accessToken, String message, String qrUrl) {
		try {
			
		
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
		headers.set("Authorization", "Bearer " + accessToken);
		
		String serverUrl = "https://kimsssang.github.io/FinalProject/FitGuardians/src/main/webapp";  // 실제 서버 IP 주소나 도메인으로 수정
		String fileName = qrUrl.substring(qrUrl.lastIndexOf("/") + 1);
		
		String templateObject = String.format(
		    "{\"object_type\":\"feed\"," +
		    "\"content\":{\"title\":\"%s\"," +
		    "\"image_url\":\"%s\"," +
		    "\"link\":{\"web_url\":\"%s/resources/qrCodes/%s\",\"mobile_web_url\":\"%s/resources/qrCodes/%s\"}}}",
		    message, qrUrl, serverUrl, fileName, serverUrl, fileName  
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
