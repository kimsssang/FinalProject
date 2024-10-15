package com.kh.fitguardians.member.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@ResponseBody
	@RequestMapping("addCalendar.tr")
	public String addTrainerCalendar(@RequestBody ArrayList<Schedule> schedules, HttpSession session) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		boolean flag = false;
		int count = 0;
		for (Schedule schedule : schedules) {
			schedule.setUserNo(loginUser.getUserNo() +"");
			System.out.println(schedule);
			
			if(tService.isDuplicateSchedule(schedule)) {
				flag = true; // 중복이 있을경우
				System.out.println("중복된 일정: " + schedule); // 중복된 일정 로그
			}else {
				int result = tService.insertTrainerCalendar(schedule);
				if(result > 0 ) {
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

}
