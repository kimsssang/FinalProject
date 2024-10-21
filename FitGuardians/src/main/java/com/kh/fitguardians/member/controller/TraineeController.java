package com.kh.fitguardians.member.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.fitguardians.exercise.model.vo.TnWorkout;
import com.kh.fitguardians.member.model.service.MemberServiceImpl;
import com.kh.fitguardians.member.model.service.TraineeServiceImpl;
import com.kh.fitguardians.member.model.vo.BodyInfo;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.member.model.vo.MemberInfo;

@Controller
public class TraineeController {
	
	@Autowired
	private TraineeServiceImpl tnService;
	@Autowired
	private MemberServiceImpl mService;
	
	@RequestMapping("main.tn")
	public String traineeMain(HttpSession session) {
		// 기존 사용자 정보가 있을 경우 세션에 저장
		Member loginUser = (Member)session.getAttribute("loginUser");
		// 회원 추가정보 가져오기
		MemberInfo mi = mService.getMemberInfo(loginUser.getUserNo());

		// 회원 신체정보 가져오기
		BodyInfo bi = mService.getBodyInfo(loginUser.getUserId());

		// 회원 최근 6개 신체정보 가져오기
		ArrayList<BodyInfo> recentBi = mService.getRecentInfo(loginUser.getUserId());
		//System.out.println("로그인 유저의 아이디 : " + loginUser.getUserId());

		// 트레이너 정보 알아오기
		String trainerId = loginUser.getPt();
		Member trainer = mService.getTrainerInfo(trainerId);

		// 회원
		session.setAttribute("trainer", trainer);
		session.setAttribute("mi", mi);
		session.setAttribute("bi", bi);
		session.setAttribute("recentBi", recentBi);

		//System.out.println("회원의 recentBi : " + recentBi);
		return "Trainee/traineeDashboard";
	}
	
	@RequestMapping("traineeExercisePlanner.tn")
	public String traineeExercisePlanner(HttpSession session, Model model) {
		// 여기서 넘어갈 때 addTraineeExPlan들의 ArrayList를 가지고 와야 한다.
		// session에 저장된(Member타입) loginUser의 정보를 가져오는 방법 - getAttribute로 가져온다. 
		String userId = ((Member)session.getAttribute("loginUser")).getUserId();
		ArrayList<TnWorkout> list = tnService.selectTraineeWorkoutList(userId);
		
		String jsonList = new Gson().toJson(list);
		
		model.addAttribute("list", jsonList); // json형태의 문자열로 반환
		return "Trainee/traineeExerciseCalendar";
	}
	
	@ResponseBody
	@RequestMapping(value="addTraineeExPlan.tn", produces="application/json; charset=utf-8")
	public int addTraineeExPlan(@RequestBody TnWorkout tn) {
		// @JsonProperty로 키값을 매핑함 - json 객체가 되어버린다.
		// @RequestBody를 통해 json객체 -> java객체로 바꾼다. 
		// System.out.println("tn:" + tn);
		
		int result = tnService.addTraineeExPlan(tn);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value ="deleteTraineeExPlan.tn")
	public int deleteTraineeExPlan(int exerciseNo) {
		// System.out.println("exerciseNo값 잘 나오는지 : " + exerciseNo);
		int result = tnService.deleteTraineeExPlan(exerciseNo);
		// System.out.println(result);
		return result;
	}
	
	@RequestMapping("sendDatatoTrainer.tn")
	public String sendDatatoTrainer(@RequestBody TnWorkout tn, HttpSession session, Model model) {
		
		// System.out.println("tn 넘어오나 : " + tn);
		// user의 값을 여기서 얻는다.
		String userId = ((Member)session.getAttribute("loginUser")).getUserId();
		tn.setUserId(userId);
		
		model.addAttribute("data", tn);
		
		// System.out.println("tn 세팅 후 어떻냐 : " + tn);
		
		return "Trainer/traineeDetailInfo";
	}
	
	

}
