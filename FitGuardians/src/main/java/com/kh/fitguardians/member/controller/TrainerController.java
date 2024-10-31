package com.kh.fitguardians.member.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.fitguardians.member.model.service.TrainerServiceImpl;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.member.model.vo.Schedule;

@Controller
public class TrainerController {
	
	@Autowired
	private TrainerServiceImpl tService;
	
	@RequestMapping(value="calendar.tr", produces="application/json")
	public String trainerCalender(HttpSession session, HttpServletRequest request) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		
		ArrayList<Schedule> schedule = tService.selectSchedule(loginUser.getUserNo());
		request.setAttribute("schedule", schedule);
		
		return "Trainer/trainerCalendar";
	}
	
	
    // 담당회원의 스케줄 처리 기능들
	@ResponseBody
	@RequestMapping(value="selectCalendar.pt", produces="appication/json; charset=utf-8")
	public String selectPtSchedule(Member m) {
		ArrayList<Schedule> list = tService.selectPtSchedule(m);
		Gson gson = new Gson();
		
		return gson.toJson(list);
	}
	
	@ResponseBody
	@RequestMapping("addCalendar.pt")
	public String addPtSchedule(@RequestBody ArrayList<Schedule> schedules, HttpSession session) {
		boolean flag = false;
		int count = 0;
		for (Schedule schedule : schedules) {
			if(tService.isDuplicateSchedule(schedule)) {
				flag = true; // 중복이 있을경우
			}else {
				flag = false;
				int result = tService.insertPtCalendar(schedule);
				//int result2 = tService.insertTrainerCalendar(schedule);
				if(result > 0 ) {
					count++;
					String userNo = tService.selectUserNo(schedule.getPtUser());
					schedule.setUserNo(userNo);
					//int result2 = tService.insertTrainerCalendar(schedule);
				}
			}
		}
		if(flag) {
			return "DDDC";
		} else {
			return count > 0 ? "YYYC" : "NNNC";
		}
	}
}
