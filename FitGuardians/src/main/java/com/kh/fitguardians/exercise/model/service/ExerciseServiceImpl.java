package com.kh.fitguardians.exercise.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.fitguardians.exercise.model.dao.ExerciseDao;
import com.kh.fitguardians.exercise.model.vo.Workout;
import com.kh.fitguardians.member.model.vo.Member;


@Service
public class ExerciseServiceImpl {

	@Autowired
	private ExerciseDao eDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public ArrayList<Member> getTrainee(String userId) {
		return eDao.getTrainee(sqlSession, userId) ;
	}

	public int addExercise(Workout workout) {
		return eDao.addExercise(sqlSession, workout);
	}

	public ArrayList<Workout> selectWorkoutList(String userId) {
		return eDao.selectWorkoutList(sqlSession, userId);
	}
	
	public int deleteExercise(int exerciseNo) {
		return eDao.deleteExercise(sqlSession, exerciseNo);
	}


	
}
