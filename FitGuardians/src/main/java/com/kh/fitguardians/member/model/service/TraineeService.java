package com.kh.fitguardians.member.model.service;

import java.util.ArrayList;

import com.kh.fitguardians.exercise.model.vo.TnWorkout;

public interface TraineeService {

	// 회원이 입력한 데이터 삽입 메소드
	int addTraineeExPlan(TnWorkout tn);
	
	// 회원이 입력한 모든 리스트 가져오는 메소드
	ArrayList<TnWorkout> selectTraineeWorkoutList(String userId);
	
	// 회원이 입력한 플래너 삭제
	int deleteTraineeExPlan(int exerciseNo);
	
}
