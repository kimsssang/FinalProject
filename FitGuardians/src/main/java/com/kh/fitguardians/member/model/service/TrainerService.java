package com.kh.fitguardians.member.model.service;

import java.util.ArrayList;

import com.kh.fitguardians.member.model.vo.Schedule;

public interface TrainerService {

	// 스케줄 조회
	ArrayList<Schedule> selectSchedule(int userNo);
	
	// 중복확인
	boolean isDuplicateSchedule(Schedule schedule);
	
	// 스케줄 추가
	int insertTrainerCalendar(Schedule schedule); 
	
}
