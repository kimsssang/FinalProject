package com.kh.fitguardians.member.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.fitguardians.exercise.model.vo.TnWorkout;

@Repository
public class TraineeDao {

	public int addTraineeExPlan(SqlSessionTemplate sqlSession, TnWorkout tn) {
		return sqlSession.insert("memberMapper.addTraineeExPlan", tn);
	}

	public ArrayList<TnWorkout> selectTraineeWorkoutList(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectTraineeWorkoutList", userId);
	}

	public int deleteTraineeExPlan(SqlSessionTemplate sqlSession, int exerciseNo) {
		return sqlSession.update("memberMapper.deleteTraineeExPlan", exerciseNo);
	}

}
