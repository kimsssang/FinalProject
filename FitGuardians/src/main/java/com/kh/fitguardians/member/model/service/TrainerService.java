package com.kh.fitguardians.member.model.service;

import java.util.ArrayList;

import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.member.model.vo.Schedule;

public interface TrainerService {

	// 스케줄 조회
	ArrayList<Schedule> selectSchedule(int userNo);
	
	// 중복확인
	boolean isDuplicateSchedule(Schedule schedule);
	
	// 스케줄 추가
	int insertTrainerCalendar(Schedule schedule); 
	
	// 회원 스케줄 조회
	public ArrayList<Schedule> selectPtSchedule(Member m);
	
	// 스케줄 추가
	int insertPtCalendar(Schedule schedule); 
	
	String selectUserNo(String userNo);
}
