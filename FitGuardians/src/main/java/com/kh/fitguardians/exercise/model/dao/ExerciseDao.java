package com.kh.fitguardians.exercise.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.fitguardians.exercise.model.vo.Workout;
import com.kh.fitguardians.member.model.vo.Member;


@Repository
public class ExerciseDao {
	
	public ArrayList<Member> getTrainee(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("memberMapper.getTrainee", userId);
	}

	public int addExercise(SqlSessionTemplate sqlSession, Workout workout) {
		return sqlSession.insert("exerciseMapper.addExercise", workout);
	}

	public ArrayList<Workout> selectWorkoutList(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("exerciseMapper.selectWorkoutList", userId);
	}

	

}
