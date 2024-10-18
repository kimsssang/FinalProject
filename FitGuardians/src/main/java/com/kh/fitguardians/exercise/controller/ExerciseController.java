package com.kh.fitguardians.exercise.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.net.URLDecoder;
import java.net.http.HttpClient;
import java.net.http.HttpHeaders;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.output.ByteArrayOutputStream;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType0Font;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.kh.fitguardians.exercise.model.service.ExerciseServiceImpl;
import com.kh.fitguardians.exercise.model.vo.ExerciseDesc;
import com.kh.fitguardians.exercise.model.vo.ExerciseDetails;
import com.kh.fitguardians.exercise.model.vo.ExerciseInfo;
import com.kh.fitguardians.exercise.model.vo.ExercisePlan;
import com.kh.fitguardians.exercise.model.vo.TnWorkout;
import com.kh.fitguardians.exercise.model.vo.Workout;
import com.kh.fitguardians.member.model.vo.Member;


@Controller
public class ExerciseController {
	
	@Autowired
	private ExerciseServiceImpl eService;

	// trainerExercise로 포워딩 위한 메소드
	@RequestMapping("exercise.bo")
	public ModelAndView showExercisePage(HttpSession session, ModelAndView mv) {
		String userId = ((Member)session.getAttribute("loginUser")).getUserId();
		// 1. 페이지가 로드 되자마자 트레이너의 담당 회원이 조회되야 한다.
		ArrayList<Member> list = eService.getTrainee(userId);
		
		mv.addObject("list", list).setViewName("exercise/trainerExercise");;
		
		return mv;
	} // showExercisePage

	// AI를 통해 운동 계획표 생성(API)
	@ResponseBody
	@RequestMapping(value = "exercisePlan.bo", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
	public String autoExercisePlan(@RequestBody ExercisePlan ex) throws IOException, InterruptedException {

		// 인코딩을 하면 반드시 디코딩도 해야 한다.
		// 값이 안담겼던 이유 : jsp내 name(key값)과 ex의 필드부 이름이 달랐기 때문.
		// 값이 달라도 매핑 되는 방법 : 잭슨 라이브러리 다운받는다.

		String goal = URLDecoder.decode(ex.getExerciseGoal(), "UTF-8");
		String fitnessLevel = URLDecoder.decode(ex.getFitnessLevel(), "UTF-8");
		String exerciseType = URLDecoder.decode(ex.getExerciseType(), "UTF-8");
		String equipment = URLDecoder.decode(ex.getEquipment(), "UTF-8");
		String healthCondition = URLDecoder.decode(ex.getHealthCondition(), "UTF-8");
		int daysPerWeek = ex.getDaysPerWeek();
		int duration = ex.getDuration();
		int planDurationWeek = ex.getPlanDurationWeek();
		
		String plan = "{\"goal\":\""
				    + goal 
				    + " \","
					+ "	\"fitness_level\":\""
					+ fitnessLevel
					+ "\","
					+ "	\"preferences\":"
					+ "	{\"exercise_types\":[\""
					+ exerciseType
					+ "\"],"
					+ "	\"equipment_available\":[\""
					+ equipment 
					+ " \"]},"
					+ " \"health_conditions\":[\""
					+ healthCondition
					+ " \"],"
					+ " \"schedule\":{\"days_per_week\":"
					+ daysPerWeek 
					+ ","
					+ " \"session_duration\":"
					+ duration
					+ "},"
					+ " \"lang\":\"kor\","
					+ " \"plan_duration_weeks\":"
					+ planDurationWeek
					+ "}";
		
		 HttpRequest request = HttpRequest.newBuilder() 
		 .uri(URI.create("https://ai-workout-planner-exercise-fitness-nutrition-guide.p.rapidapi.com/generateWorkoutPlan?noqueue=1"))
		 .header("x-rapidapi-key", "3752bc4fb5mshdd408753dc51259p1f0f59jsn8e0983577c84")
		 .header("x-rapidapi-host", "ai-workout-planner-exercise-fitness-nutrition-guide.p.rapidapi.com")
		 .header("Content-Type", "application/json")
		 .method("POST", HttpRequest.BodyPublishers.ofString(plan)) 
		 .build();
		 
		 HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
		 
		 System.out.println(response.body()); 
		 return response.body();
		 
	} // autoExercisePlan
	
	// PDF API를 위한 메소드
	@RequestMapping(value="exercisePdf.bo", produces="application/json; charset=utf-8")
	public ResponseEntity<byte[]> makePdf(@RequestBody ExerciseInfo exerciseInfo, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// PDF파일 하나 생성
		// PDF문서를 메모리에 할당(doc.close() 종료 메소드 사용할 것)
		PDDocument doc = new PDDocument();
		
		// 신규 PDF페이지 추가
		PDPage page = new PDPage(PDRectangle.A4);
		doc.addPage(page);
		
		// 폰트 설정 - 일반 글씨
		// PDFont의 매개변수로는 글꼴 TTF를 type0글꼴로 로드, 처리할 PDF문서 객체를 보내준다(load(doc,나눔고딕))
		String textPath = request.getServletContext().getRealPath("/resources/font/NanumGothic.ttf");
		InputStream text = new FileInputStream(textPath);
		PDFont textFont = PDType0Font.load(doc, text);
		
		// 굵은 글씨(Bold를 위함)
		String boldPath = request.getServletContext().getRealPath("/resources/font/NanumGothicBold.ttf");
		InputStream bold = new FileInputStream(boldPath);
		PDFont boldFont = PDType0Font.load(doc, bold);
		
		// content를 추가할 PDF문서와 해댕 page를 매개변수로 할당함
		PDPageContentStream contentStream = new PDPageContentStream(doc, page, PDPageContentStream.AppendMode.APPEND, true);
		
		// beginText를 호출해서 text를 입력할 것이라고 알림
		contentStream.beginText();
		
		// 글쓰기
		contentStream.setFont(boldFont, 25);
		// x축 시작 좌표
		int startX = 30;
		// y축 시작 좌표
		int startY = 800;
		contentStream.newLineAtOffset(startX,startY);
		String title = "AI가 만들어준 운동 일정표";
		contentStream.showText(title);
		
		// 안내정보
		contentStream.setFont(textFont, 12);
		contentStream.newLineAtOffset(0, -30);
		contentStream.showText("위 파일은 Rapid API 웹사이트 내 AI Workout Planner API를 이용하여 만든 운동 스케줄표 입니다.");
		contentStream.newLineAtOffset(0, -15);
		contentStream.showText("해당 운동 플래너는 운동용으로 참고하시고 전문적인 플랜은 반드시 전문가와 상담하여 조정하시기 바랍니다.");
		contentStream.newLineAtOffset(0, -15);
		
		// 운동 스케줄 상세
		contentStream.setFont(boldFont, 15);
	    contentStream.newLineAtOffset(0, -15);
		contentStream.showText("운동 스케줄 상세");
		contentStream.newLineAtOffset(0, -15);
		
		ExerciseDesc schedule = exerciseInfo.getExerciseDesc();
		contentStream.setFont(textFont, 10);
		
		contentStream.showText("운동 목표: " + schedule.getGoal());
	    contentStream.newLineAtOffset(0, -15);
		contentStream.showText("주당 운동 일수: " + schedule.getDaysPerWeek());
	    contentStream.newLineAtOffset(0, -15);
	    contentStream.showText("총 주수: " + schedule.getTotalWeek());
	    contentStream.newLineAtOffset(0, -15);
	    contentStream.showText("운동 프로그램 난이도: " + schedule.getFitnessLevel());
	    contentStream.newLineAtOffset(0, -15);
	    contentStream.showText("프로그램 설명: " + schedule.getSeoContent());
	    contentStream.newLineAtOffset(0, -30);
		
	    // 운동 세부정보 출력
	    contentStream.setFont(boldFont, 15);
	    contentStream.showText("운동 세부사항");
	    contentStream.newLineAtOffset(0, -15);

	    ArrayList<ExerciseDetails> exercises = exerciseInfo.getExercise();
	    contentStream.setFont(textFont, 12);
	    
	    // 일자를 기준으로 묶기
	    Map<String, ArrayList<ExerciseDetails>> exercisesByDay = new LinkedHashMap<>();// Hashmap은 기본적으로 순서를 보장 x => 순서를 보장받고 싶으면 LinkedHashMap<>();을 작성해야 한다.

	    // 운동 정보를 일자별로 그룹화
	    for(ExerciseDetails exercise: exercises) {
	    	exercisesByDay.computeIfAbsent(exercise.getDay(), k -> new ArrayList<>()).add(exercise);
	    }

	    
	    // 각 요일에 따른 운동 정보를 출력
	    for (Map.Entry<String, ArrayList<ExerciseDetails>> entry : exercisesByDay.entrySet()) {
	    	
	    	String day = entry.getKey();
	    	ArrayList<ExerciseDetails> dayExercises = entry.getValue();
	    	
	    	contentStream.showText("일자: " + day);
	    	int exerciseNumber = 1;
	    	
	    	for(ExerciseDetails info : dayExercises) {
	    		
	    		contentStream.showText(exerciseNumber + "번째 운동");
	            contentStream.newLineAtOffset(0, -15);
	    		
	    		contentStream.showText("운동명: " + info.getName());
	    		contentStream.newLineAtOffset(0, -15);
	    		contentStream.showText("장비: " + info.getEquipment());
	    		contentStream.newLineAtOffset(0, -15);
	    		contentStream.showText("소요 시간: " + info.getDuration());
	    		contentStream.newLineAtOffset(0, -15);
	    		contentStream.showText("반복 수: " + info.getRepetitions());
	    		contentStream.newLineAtOffset(0, -15);
	    		contentStream.showText("세트 수: " + info.getSets());
	    		contentStream.newLineAtOffset(0, -30); 
	    		exerciseNumber++;
	    	
	    	}
	      
	    }

		// 글쓰기 작성 종료를 알림
		contentStream.endText();
		
		// 반드시 contentStream 닫을것
		contentStream.close();
		
		// 파일 저장
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		doc.save(baos);
		doc.close();
		
		// Return the PDF as byte array with appropriate headers
	    return ResponseEntity.ok()
	            .header("Content-Disposition", "attachment; filename=exercise_plan.pdf")
	            .contentType(MediaType.APPLICATION_PDF)
	            .body(baos.toByteArray());
		
	} // makePdf
	
	@ResponseBody
	@RequestMapping(value="addExercise.bo", produces="application/json; charset=utf-8")
	public Map<String, Object> addExercise(@RequestBody Workout workout) {
		
		int result = eService.addExercise(workout);
		
		// JSON형태로 값을 주고받는 것이 아닐 경우 이렇게 써도 되지만
		// return result > 0 ? "success" : "error";
		
		// 지금은 JSON형태로 값을 주고받고 있으므로 
		// String responseMessage = result > 0 ? "success" : "error";
	    // return ResponseEntity.ok(responseMessage); // JSON 형태로 반환하는 이 형식을 써야 한다
		
		Map<String, Object> response = new HashMap<>();
		response.put("result", result > 0 ? "success" : "error");
		return response;
		
	} //addExercise
	
	@ResponseBody
	@RequestMapping(value="selectWorkout.ex", produces = "application/json; charset=utf-8")
	public String selectWorkout(@RequestParam String userId) {
		// System.out.println("userId가 없나 : " + userId);
		
		ArrayList<Workout> list = eService.selectWorkoutList(userId);
		// 이런식으로 HashMap을 사용해도 되지만, Gson을 사용해보자
		
		//HashMap<String, Object> response = new HashMap<>();
		//response.put("workouts", list);
		
		// 삼항 연산자로 문자열 반환도 가능하지만 JSON응답을 요구하는 경우 적절한 형태로 변환해야 한다.
		// JSON형태 없이 일반적으로 한다면 ?
		//  String responseMessage = result > 0 ? "success" : "error";
		
		// -> Gson을 사용해 값을 String형으로 반환해보기
		return new Gson().toJson(list);
		// 아주 잘됨을 확인!
		
	}//selectWorkout

	@ResponseBody
	@RequestMapping("deleteExercise.ex")
	public String deleteExercise(int exerciseNo) {
		//System.out.println(exerciseNo);
		int result = eService.deleteExercise(exerciseNo);
		
		return result>0?"success":"error";
		
	}// deleteExercise
	
	
	// 운동 목록리스트 조회 (Ninja API)
	@ResponseBody
	@RequestMapping(value="searchEx.ex", method = RequestMethod.GET)
	public ArrayList<Map<String, Object>> searchExercise(String type, 
							   String muscle, 
							   String difficulty) throws IOException, InterruptedException {
		
		// url생성
		String requestUrl = "https://api.api-ninjas.com/v1/exercises";
		requestUrl += "?type=" + type;
		requestUrl += "&muscle=" + muscle;
		requestUrl += "&difficulty=" + difficulty;
		
		System.out.println(" type : " +  type);
		System.out.println(" muscle : " +  muscle);
		System.out.println(" difficulty : " +  difficulty);
		
		// 헤더 (api에게 요청하기)
		URL url = new URL(requestUrl);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.setRequestProperty("accept", "application/json");
		connection.setRequestProperty("X-Api-Key", "ljeQSKuX7wMOTquATCEBKA==yBuEhHgyJG8KGiyq");
		
		// 응답을 요청받기
		InputStream responseStream = connection.getInputStream();
		// ObjectMapper : json을 읽기, 쓰기, 변환 기능을 제공하는 객체
		ObjectMapper mapper = new ObjectMapper();
		// Jackson라이브러리 : Json을 Java Object로 변환하거나 Java Object를 Json으로 변환하게 해주는 Java 라이브러리
		// JsonNode : 잭슨 라이브러리에서 제공하는 객체
		// 자바에서 json데이터를 파싱해서 jsonNode 객체려 변환하고 있다.
		// readTree : 주어진 InputStream에서 JSON데이터를 읽어들이고, 이를 JSON트리 구조로 나타내준다(= json데이터를 동적으로 다룸)
		JsonNode root = mapper.readTree(responseStream);
		
		// root = JsonNode객체, 그걸 toString()으로 문자열화 한것.
		System.out.println(root.toString());
		
		// jsp에서 JsonNode를 사용할 수 없기 때문에 c태그를 사용하고 싶으면 여기서 배열로 만들어야 한다.
		// [key-value, key-value, key-value]형태
		ArrayList<Map<String,Object>> exercises = new ArrayList<>();
		if(root.isArray()) { // root가 array인지 확인 유무
			for(JsonNode node : root) {
				Map<String, Object> ex = new HashMap<>();
				//put: hashmap에서 값 삽입 시 사용하는 메소드
				// node.path().asText(): JsonNode에서 값을 가져오는 메소드
				ex.put("name", node.path("name").asText());
				ex.put("type", node.path("type").asText());
				ex.put("muscle", node.path("muscle").asText());
				ex.put("equipment", node.path("equipment").asText());
				ex.put("difficulty", node.path("difficulty").asText());
				ex.put("instructions", node.path("instructions").asText());
				exercises.add(ex); //ex를 exercises 배열에 집어넣음
			}
		}
		
		// 값 jsp에 전달하기
		return exercises;
	
	}// searchExercise
	
	// 트레이너가 입력한 오늘의 운동 플랜 회원에게 보이기
	@ResponseBody
	@RequestMapping(value="selectTodayWorkout.ex", produces="application/json; charset:utf-8")
	public String selectTodayWorkout(@RequestParam String userId) {
		//System.out.println("사용자 아이디 : " + userId);
		ArrayList<Workout> list = eService.selectWorkoutList(userId);
		return new Gson().toJson(list);
	}
	
	// 트레이너가 입력한 오늘의 운동 플랜 트레이너에게 보이기
	@ResponseBody
	@RequestMapping(value="selectTodayWorkoutforTrainer.ex", produces="application/json; charset:utf-8")
	public String selectTodayWorkutforTrainer(@RequestParam String userId) {
		//System.out.println("사용자 아이디 : " + userId);
		ArrayList<Workout> list = eService.selectWorkoutList(userId);
		return new Gson().toJson(list);
	}
	
	// 회원이 작성한 것을 보여주는 스케줄러
	@ResponseBody
	@RequestMapping(value="selectTraineeWorkoutList.ex", produces="application/json; charset:utf-8")
	public String selectTraineeWorkoutList(@RequestParam String userId) {
		ArrayList<TnWorkout> list = eService.selectTraineeWorkoutList(userId);
		return new Gson().toJson(list);
	}
	
	// 트레이너가 작성한 것을 회원에게 보여주는 스케줄러
	@ResponseBody
	@RequestMapping(value="workoutListfromTrainer.ex", produces="application/json; charset:utf-8")
	public String selectTrainerWorkoutList(@RequestParam String userId) {
		ArrayList<Workout> list = eService.selectWorkoutList(userId);
		return new Gson().toJson(list);
	}
	
	// 카카오톡을 이용하여 운동 플래너 알림(coolSMS)
	public void sendPlanMsg() {
		
	}


}
