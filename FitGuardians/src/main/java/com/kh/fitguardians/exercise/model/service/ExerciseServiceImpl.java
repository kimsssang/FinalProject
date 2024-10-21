package com.kh.fitguardians.exercise.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.fitguardians.exercise.model.dao.ExerciseDao;
import com.kh.fitguardians.exercise.model.vo.TnWorkout;
import com.kh.fitguardians.exercise.model.vo.Workout;
import com.kh.fitguardians.member.model.vo.Member;


@Service
public class ExerciseServiceImpl {

	@Autowired
	private ExerciseDao eDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 트레이너의 담당 회원 조회
	public ArrayList<Member> getTrainee(String userId) {
		return eDao.getTrainee(sqlSession, userId) ;
	}

	// 운동 플래너 추가
	public int addExercise(Workout workout) {
		return eDao.addExercise(sqlSession, workout);
	}

	// 트레이너가 입력한 운동 플래너 표시
	public ArrayList<Workout> selectWorkoutList(String userId) {
		return eDao.selectWorkoutList(sqlSession, userId);
	}
	
	// 운동 플래너 삭제
	public int deleteExercise(int exerciseNo) {
		return eDao.deleteExercise(sqlSession, exerciseNo);
	}

	// 회원이 입력한 운동 플래너 표시
	public ArrayList<TnWorkout> selectTraineeWorkoutList(String userId) {
		return eDao.selectTraineeWorkoutList(sqlSession, userId);
	}


	
}
