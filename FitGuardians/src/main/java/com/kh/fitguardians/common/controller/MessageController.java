package com.kh.fitguardians.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.kh.fitguardians.member.model.service.TrainerServiceImpl;
import com.kh.fitguardians.member.model.vo.Events;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.member.model.vo.Schedule;

import static com.kh.fitguardians.common.template.APIPropertiesSelecter.*;

import java.io.IOException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class MessageController {

	private static final String KAKAO_API_URL = "https://kapi.kakao.com/v2/api/talk/memo/default/send";
	private static final String KAKAO_CALENDAR_API_URL = "https://kapi.kakao.com/v2/api/calendar/calendars";
	
	@Autowired
	private TrainerServiceImpl tService; 
	
	
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
 		request.setAttribute("schedule", schedule);
 		
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

	    if (response.getStatusCode() != HttpStatus.OK) {
	        // 에러 처리 (예: 로그 기록)
	        return null; // null 반환
	    }

	    Gson gson = new Gson();
	    JsonObject jsonResponse = gson.fromJson(response.getBody(), JsonObject.class);
	    JsonArray jsonCalendars = jsonResponse.getAsJsonArray("calendars");
	    
	    
	    // 첫 번째 캘린더 ID 반환
	    if (jsonCalendars != null && jsonCalendars.size() > 0) {
	        JsonObject firstCalendar = jsonCalendars.get(0).getAsJsonObject();
	        return firstCalendar.get("id").getAsString(); // 첫 번째 캘린더 ID 반환
	    }
	    
	    return null; // 캘린더가 없는 경우 null 반환
	}
	
	// 목록조회 이벤트 값 받아오기
	private ArrayList<Events> getKakaoCalendarEvents(String accessToken, String calendarId) {
	    ArrayList<Events> events = new ArrayList<>();

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
	        eventBrief.setId(event.get("id").getAsString());
	        eventBrief.setTitle(event.get("title").getAsString());
	        eventBrief.setType(event.get("type").getAsString());
	        eventBrief.setCalendarId(event.get("calendar_id").getAsString());
	        eventBrief.setIsRecurEvent(event.get("is_recur_event").getAsBoolean());
	        eventBrief.setIsHost(event.get("is_host").getAsBoolean());
	        eventBrief.setColor(event.get("color").getAsString());
	        
	        System.out.println("event" + i + ": " + event);
	        
	        
	        JsonObject time = event.getAsJsonObject("time");
	        if (time != null) {
	        	ZonedDateTime start = ZonedDateTime.parse(time.get("start_at").getAsString());
	        	ZonedDateTime startDateTime = start.withZoneSameInstant(ZoneId.systemDefault());
	        	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SS");
	            eventBrief.setStartDate(startDateTime.format(formatter));
	            /*
	             *	ZonedDateTime start = ZonedDateTime.parse(schedule.getStartDate());
		 			ZonedDateTime startDateTime = start.withZoneSameInstant(ZoneId.systemDefault());
		 			
		 			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SS'Z'");
		 			schedule.setStartDate(startDateTime.format(formatter)); 
	             */
	            // all_day 속성 체크
	            if (time.has("all_day") && !time.get("all_day").isJsonNull()) {
	            	// 종일 일정 일때 종료일자 null
	            	boolean isAllday = time.get("all_day").getAsBoolean(); 
		            if(isAllday) {
		            	eventBrief.setEndDate("");
		            }else {
		            	ZonedDateTime end = ZonedDateTime.parse(time.get("end_at").getAsString());
			        	ZonedDateTime endDateTime = end.withZoneSameInstant(ZoneId.systemDefault());
			            eventBrief.setEndDate(endDateTime.format(formatter));
		            }
	                eventBrief.setAllDay(time.get("all_day").getAsBoolean());
	            } else {
	                eventBrief.setAllDay(false); // 기본값 설정
	            }
	            
	        }

	        events.add(eventBrief);
	    }

	    System.out.println("events : " + events);
	    return events;
	}
	
	
		// 카카오톡 캘린더 생성 호출 메소드
		private String createCalendar(String accessToken, Schedule s) {
		    String createEventsApiUrl = "https://kapi.kakao.com/v2/api/calendar/create/event";
		    
		    System.out.println("생성 스케줄 : " + s);
		    
		    RestTemplate restTemplate = new RestTemplate();
		    HttpHeaders headers = new HttpHeaders();
		    headers.set("Authorization", "Bearer " + accessToken);
		    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED); // x-www-form-urlencoded로 설정
		    
		    
		    // 요청 파라미터 설정
		    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		    params.add("calendar_id", "primary");
		    
		    // 종일 일정 일때 enddate를 다음 날짜로 변경
		    if(s.getAllday().equals("true")) {
		    	OffsetDateTime startDateTime = OffsetDateTime.parse(s.getStartDate());
		    	OffsetDateTime endDateTime = startDateTime.plusDays(1).withHour(0).withMinute(0).withSecond(0).withNano(0);
		    	s.setEndDate(endDateTime.format(DateTimeFormatter.ISO_OFFSET_DATE_TIME));	
		    }
		    System.out.println("start : " + s.getStartDate());
		    System.out.println("endDate check : " + s.getEndDate());
		    
		    String description = s.getScheduleDes();
		    
		    if(description == null) {
		    	s.setScheduleDes("상세 정보가 없습니다.");
		    }
		    
		    // 이벤트 객체 추가 (JSON 문자열을 직접 추가)
		    String eventJson = "{"
		            + "\"title\": \"" + s.getScheduleTitle() + "\","
		            + "\"time\": {"
		            + "\"start_at\": \"" + s.getStartDate() + "\","
		            + "\"end_at\": \"" + s.getEndDate() + "\","
		            + "\"time_zone\": \"Asia/Seoul\","
		            + "\"all_day\": "+ s.getAllday() +","
		            + "\"lunar\": false"
		            + "},"
		            + "\"description\": \"" + s.getScheduleDes() + "\","
		            + "\"color\": \"" + s.getBackColor()+ "\""
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
		
		@ResponseBody
		@RequestMapping("addCalendar.tr")
		public String addTrainerCalendar(@RequestBody ArrayList<Schedule> schedules, HttpServletRequest request) throws IOException {
			Member loginUser = (Member) request.getSession().getAttribute("loginUser");
			boolean flag = false;
			int count = 0;
			// 일정 저장시 db에 저장, 톡캘린더 저장
			// 톡캘린더 저장 메소드 호출
			String accessToken = (String) request.getSession().getAttribute("accessToken");
			// 카카오 로그인이 되어 있지 않다면 로그인 먼저
			String userId = loginUser.getUserId();
	 		if(userId == null || !userId.startsWith("K-")) {
		 			// 카카오 로그인 url 생성 
		 			return redirectToKakaoLogin();
		     			
	 		}
		 	
	 		
	 		String calendarId = getKakaoCalendarId(accessToken);
	 		
	 		for(Schedule schedule : schedules) {
	 			if(schedule.getAllday().equals("true")) {
	 				ZonedDateTime start = ZonedDateTime.parse(schedule.getStartDate());
		 			ZonedDateTime startDateTime = start.withZoneSameInstant(ZoneId.systemDefault());
		 			
		 			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SS'Z'");
		 			schedule.setStartDate(startDateTime.format(formatter));
	 			}
	 			
	 			if(tService.isDuplicateSchedule(schedule)) {
	 				flag = true;
	 				System.out.println("중복된 일정 : " + schedule);
	 				continue;
	 			}
	 			
 				System.out.println("중복아닌 일정 : " + schedule);
 				String result = createCalendar(accessToken, schedule);
 				if(result != null) { 
 					// 톡캘린더 저장 성공시 DB 저장
 					schedule.setUserNo(loginUser.getUserNo() + "");
 					
 					if(schedule.getAllday().equals("true")) {
 						schedule.setEndDate(null);
 					}
	 				schedule.setKakaoCalendarId(result);
	 				int result2 = tService.insertTrainerCalendar(schedule);
	 				if(result2 > 0) {
	 					count++;
	 				}
				}
	 			
 			}
			if(flag) {
				return "DDDC";
			} else {
				return count > 0 ? "YYYC" : "NNNC";
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
		
		String serverUrl = "https://kimsssang.github.io/FinalProject/FitGuardians/src/main/webapp/resources/qrCodes/";  // 실제 서버 IP 주소나 도메인으로 수정
		String fileName = qrUrl.substring(qrUrl.lastIndexOf("\\") + 1);
		
		String templateObject = String.format(
		    "{\"object_type\":\"feed\"," +
		    "\"content\":{\"title\":\"%s\"," +
		    "\"image_url\":\"%s\"," +
		    "\"link\":{\"web_url\":\"%s%s\",\"mobile_web_url\":\"%s%s\"}}}",
		    message, serverUrl + fileName, serverUrl, fileName, serverUrl, fileName  
		);
		
        String params = "template_object=" + URLEncoder.encode(templateObject, "UTF-8");
        
		HttpEntity<String> requestEntity = new HttpEntity<>(params, headers);
		ResponseEntity<String> response = restTemplate.postForEntity(KAKAO_API_URL, requestEntity, String.class);
		
		return response.getStatusCode() == HttpStatus.OK;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
