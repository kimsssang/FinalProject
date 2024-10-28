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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
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
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

@Controller
public class MessageController {

	private static final String KAKAO_API_URL = "https://kapi.kakao.com/v2/api/talk/memo/default/send";

	@Autowired
	private TrainerServiceImpl tService;

	@RequestMapping("sendQr.me")
	public String kakaoSendQr(HttpServletRequest request) throws IOException {
		String userId = ((Member) request.getSession().getAttribute("loginUser")) != null
				? ((Member) request.getSession().getAttribute("loginUser")).getUserId()
				: null;
		String accessToken = (String) request.getSession().getAttribute("accessToken");
		String qrUrl = ((Member) request.getSession().getAttribute("loginUser")).getQr();
		// 카카오 로그인이 되어 있지 않다면 로그인 먼저
		if (userId == null || !userId.startsWith("K-")) {
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
		String userId = ((Member) request.getSession().getAttribute("loginUser")) != null
				? ((Member) request.getSession().getAttribute("loginUser")).getUserId()
				: null;
		String accessToken = (String) request.getSession().getAttribute("accessToken");

		// 카카오 로그인이 되어 있지 않다면 로그인 먼저
		if (userId == null || !userId.startsWith("K-")) {
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
		ResponseEntity<String> response = restTemplate.exchange(calendarApiUrl, HttpMethod.GET,
				new HttpEntity<>(headers), String.class);

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
				eventsApiUrl + "?calendar_id=" + calendarId + "&preset=THIS_MONTH&limit=100", HttpMethod.GET,
				new HttpEntity<>(headers), String.class);

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

			JsonObject time = event.getAsJsonObject("time");
			if (time != null) {
				ZonedDateTime start = ZonedDateTime.parse(time.get("start_at").getAsString());
				ZonedDateTime startDateTime = start.withZoneSameInstant(ZoneId.systemDefault());
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SS");
				eventBrief.setStartDate(startDateTime.format(formatter));

				// all_day 속성 체크
				if (time.has("all_day") && !time.get("all_day").isJsonNull()) {
					// 종일 일정 일때 종료일자 null
					boolean isAllday = time.get("all_day").getAsBoolean();
					if (isAllday) {
						eventBrief.setStartDate(time.get("start_at").getAsString());
						eventBrief.setEndDate(time.get("start_at").getAsString());
					} else {
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

		return events;
	}

	@ResponseBody
	@RequestMapping("addCalendar.tr")
	public String addTrainerCalendar(@RequestBody ArrayList<Schedule> schedules, HttpServletRequest request)
			throws IOException {
		Member loginUser = (Member) request.getSession().getAttribute("loginUser");
		boolean flag = true;
		int count = 0;
		// 일정 저장시 db에 저장, 톡캘린더 저장
		// 톡캘린더 저장 메소드 호출
		String accessToken = (String) request.getSession().getAttribute("accessToken");
		// 카카오 로그인이 되어 있지 않다면 로그인 먼저
		String userId = loginUser.getUserId();
		if (userId == null || !userId.startsWith("K-")) {
			// 카카오 로그인 url 생성
			return redirectToKakaoLogin();

		}

		String calendarId = getKakaoCalendarId(accessToken);

		for (Schedule schedule : schedules) {
			
			String description = schedule.getScheduleDes();

			if (description == null) {
				schedule.setScheduleDes("상세 정보가 없습니다.");
			}
			String title = schedule.getScheduleTitle().trim();
			schedule.setScheduleTitle(title);
			String des = schedule.getScheduleDes().trim();
			schedule.setScheduleDes(des);
			
			schedule.setUserNo(loginUser.getUserNo()+"");
			
			if (schedule.getAllDay().equals("true")) {
				ZonedDateTime start = ZonedDateTime.parse(schedule.getStartDate());
				ZonedDateTime startDateTime = start.withZoneSameInstant(ZoneId.systemDefault());

				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SS'Z'");
				schedule.setStartDate(startDateTime.format(formatter));
			}
			if (tService.isDuplicateSchedule(schedule)) {
	            flag = true; // 중복된 일정 발견
	            continue; // 중복 일정인 경우, 다음 일정으로 넘어감
	        }
			
			
			String result = createCalendar(accessToken, schedule);
			if (result != null) {
				// 톡캘린더 저장 성공시 DB 저장
				schedule.setKakaoCalendarId(result);
				
				if (schedule.getAllDay().equals("true")) {
					schedule.setEndDate(null);
				}
				int result2 = tService.insertTrainerCalendar(schedule);
				if (result2 > 0) {
					count++;
				}
			}
			

		}
		if (flag) {
			return count > 0 ? "YYYC" : "DDDC";
		} else {
			return "NNNC";
		}

	}

	// 카카오톡 캘린더 생성 호출 메소드
	private String createCalendar(String accessToken, Schedule s) throws IOException, JsonProcessingException {
		String createEventsApiUrl = "https://kapi.kakao.com/v2/api/calendar/create/event";

		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "Bearer " + accessToken);
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED); // x-www-form-urlencoded로 설정

		// 요청 파라미터 설정
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("calendar_id", "primary");

		// 종일 일정 일때 enddate를 다음 날짜로 변경
		if (s.getAllDay().equals("true")) {
			OffsetDateTime startDateTime = OffsetDateTime.parse(s.getStartDate());
			OffsetDateTime endDateTime = startDateTime.plusDays(1).withHour(0).withMinute(0).withSecond(0).withNano(0);
			s.setEndDate(endDateTime.format(DateTimeFormatter.ISO_OFFSET_DATE_TIME));
		}

		// 이벤트 객체 추가 (JSON 문자열을 직접 추가)
		String eventJson = "{" + "\"title\": \"" + s.getScheduleTitle() + "\"," + "\"time\": {" + "\"start_at\": \""
				+ s.getStartDate() + "\"," + "\"end_at\": \"" + s.getEndDate() + "\","
				+ "\"time_zone\": \"Asia/Seoul\"," + "\"all_day\": " + s.getAllDay() + "," + "\"lunar\": false" + "},"
				+ "\"description\": \"" + s.getScheduleDes() + "\"," + "\"color\": \"" + s.getBackColor() + "\"" + "}";

		params.add("event", eventJson); // 이벤트 객체 추가

		ResponseEntity<String> response = restTemplate.postForEntity(createEventsApiUrl,
				new HttpEntity<>(params, headers), String.class);

		if (response.getStatusCode() == HttpStatus.OK) {
			System.out.println("Event created successfully: " + response.getBody());
			String json = response.getBody();
			ObjectMapper objectMapper = new ObjectMapper();
			
			JsonNode jsonNode = objectMapper.readTree(json);
			return jsonNode.get("event_id").asText();
		} else {
			System.out.println("Failed to create event: " + response.getStatusCode());
			return response.getStatusCode() + "";
		}
	}

	//로그인 요청 메소드
	private String redirectToKakaoLogin() throws IOException {
		Properties prop = properties();
		String kakaoRestApi = prop.getProperty("kakaoRestApi");
		String redirectUrl = prop.getProperty("kakaoRedirectUri");
		String encUrl = URLEncoder.encode(redirectUrl, "UTF-8");

		String kakaoLoginUrl = "https://kauth.kakao.com/oauth/authorize" + "?client_id=" + kakaoRestApi
				+ "&redirect_uri=" + encUrl + "&response_type=code";

		return "redirect:" + kakaoLoginUrl;
	}
	
	// qr메세지 보내는 메소드 
	private boolean sendkakaoMessgae(String accessToken, String message, String qrUrl) {
		try {

			RestTemplate restTemplate = new RestTemplate();
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
			headers.set("Authorization", "Bearer " + accessToken);

			String serverUrl = "https://kimsssang.github.io/FinalProject/FitGuardians/src/main/webapp/resources/qrCodes/"; // 실제
																															// 서버
																															// 수정
			String fileName = qrUrl.substring(qrUrl.lastIndexOf("/") + 1);

			String templateObject = String.format(
					"{\"object_type\":\"feed\"," + "\"content\":{\"title\":\"%s\"," + "\"image_url\":\"%s\","
							+ "\"link\":{\"web_url\":\"%s%s\",\"mobile_web_url\":\"%s%s\"}}}",
					message, serverUrl + fileName, serverUrl, fileName, serverUrl, fileName);

			String params = "template_object=" + URLEncoder.encode(templateObject, "UTF-8");

			HttpEntity<String> requestEntity = new HttpEntity<>(params, headers);
			ResponseEntity<String> response = restTemplate.postForEntity(KAKAO_API_URL, requestEntity, String.class);

			return response.getStatusCode() == HttpStatus.OK;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@ResponseBody
	@RequestMapping("addCalendar.kt")
	public String addTraineePtCalendar(@RequestBody ArrayList<Schedule> schedules, HttpServletRequest request)
			throws IOException {
		Member loginUser = (Member) request.getSession().getAttribute("loginUser");
		int count = 0;
		// 일정 저장시 db에 저장, 톡캘린더 저장
		// 톡캘린더 저장 메소드 호출
		String accessToken = (String) request.getSession().getAttribute("accessToken");
		// 카카오 로그인이 되어 있지 않다면 로그인 먼저
		String userId = loginUser.getUserId();
		if (userId == null || !userId.startsWith("K-")) {
			// 카카오 로그인 url 생성
			return redirectToKakaoLogin();

		}

		String calendarId = getKakaoCalendarId(accessToken);

		for (Schedule schedule : schedules) {
			ZonedDateTime starts = ZonedDateTime.parse(schedule.getStartDate());
			ZonedDateTime startDateTimes = starts.withZoneSameInstant(ZoneId.systemDefault());

			DateTimeFormatter formatters = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SS");
			schedule.setStartDate(startDateTimes.format(formatters));
			
			ZonedDateTime end = ZonedDateTime.parse(schedule.getEndDate());
			ZonedDateTime endDateTime = end.withZoneSameInstant(ZoneId.systemDefault());
			schedule.setEndDate(endDateTime.format(formatters));
			
			boolean isDupl = isDuplicateKt(schedule, accessToken); 
			if(isDupl) {
				continue;
				
			}
			
			String description = schedule.getScheduleDes();

			if (description == null) {
				schedule.setScheduleDes("상세 정보가 없습니다.");
			}
			String title = schedule.getScheduleTitle().trim();
			schedule.setScheduleTitle(title);
			String des = schedule.getScheduleDes().trim();
			schedule.setScheduleDes(des);
			
			schedule.setUserNo(loginUser.getUserNo()+"");
			
			
			String result = createCalendar(accessToken, schedule);
			if(result != null) {
				count++;
			}
		

		}
			return count > 0 ? "YYYC" : "DDDC";

	}

	private boolean isDuplicateKt(Schedule schedule, String accessToken) {
		ArrayList<Events> event = getKakaoCalendarEvents(accessToken, "primary");
		
		for(Events e : event) {
			// 조회된 카톡이벤트와 저장하려는 스케줄의 이름과 시작 날짜가 같으면 false
			if(e.getStartDate().equals(schedule.getStartDate()) && e.getTitle().equals(schedule.getScheduleTitle())) {
				return true;
			}
			
		}
		
		return false;
	}
	
}
