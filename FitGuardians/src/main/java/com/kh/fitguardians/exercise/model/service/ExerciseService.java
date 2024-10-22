package com.kh.fitguardians.exercise.model.service;

import java.util.ArrayList;

import com.kh.fitguardians.exercise.model.vo.TnWorkout;
import com.kh.fitguardians.exercise.model.vo.Workout;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.member.model.vo.MemberInfo;

public interface ExerciseService {
	
	// 트레이너의 담당 회원 조회
	ArrayList<Member> getTrainee(String userId);
	
	// 운동 플래너 추가
	int addExercise(Workout workout);

	// 트레이너가 입력한 운동 플래너 표시
	ArrayList<Workout> selectWorkoutList(String userId);

	// 운동 플래너 삭제
	int deleteExercise(int exerciseNo);

	// 회원이 입력한 운동 플래너 표시
	ArrayList<TnWorkout> selectTraineeWorkoutList(String userId);

	// 담당 회원 전체의 MemberInfo를 가져옴
	MemberInfo getMemberInfo(int userNo);

}
