package com.kh.fitguardians.exercise.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.fitguardians.exercise.model.dao.ExerciseDao;
import com.kh.fitguardians.exercise.model.vo.TnWorkout;
import com.kh.fitguardians.exercise.model.vo.Workout;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.member.model.vo.MemberInfo;


@Service
public class ExerciseServiceImpl implements ExerciseService {

	@Autowired
	private ExerciseDao eDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 트레이너의 담당 회원 조회
	@Override
	public ArrayList<Member> getTrainee(String userId) {
		return eDao.getTrainee(sqlSession, userId) ;
	}

	// 운동 플래너 추가
	@Override
	public int addExercise(Workout workout) {
		return eDao.addExercise(sqlSession, workout);
	}

	// 트레이너가 입력한 운동 플래너 표시
	@Override
	public ArrayList<Workout> selectWorkoutList(String userId) {
		return eDao.selectWorkoutList(sqlSession, userId);
	}
	
	// 운동 플래너 삭제
	@Override
	public int deleteExercise(int exerciseNo) {
		return eDao.deleteExercise(sqlSession, exerciseNo);
	}

	// 회원이 입력한 운동 플래너 표시
	@Override
	public ArrayList<TnWorkout> selectTraineeWorkoutList(String userId) {
		return eDao.selectTraineeWorkoutList(sqlSession, userId);
	}

	// 담당 회원 전체의 MemberInfo를 가져옴
	@Override
	public MemberInfo getMemberInfo(int userNo) {
		return eDao.getMemberInfo(sqlSession, userNo);
	}


	
}