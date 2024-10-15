package com.kh.fitguardians.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.fitguardians.exercise.model.vo.TnWorkout;
import com.kh.fitguardians.member.model.dao.TraineeDao;

@Service
public class TraineeServiceImpl implements TraineeService{

	@Autowired
	private TraineeDao tnDao;
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int addTraineeExPlan(TnWorkout tn) {
		return tnDao.addTraineeExPlan(sqlSession, tn);
	}

	public ArrayList<TnWorkout> selectTraineeWorkoutList(String userId) {
		return tnDao.selectTraineeWorkoutList(sqlSession, userId);
	}

	public int deleteTraineeExPlan(int exerciseNo) {
		return tnDao.deleteTraineeExPlan(sqlSession, exerciseNo);
	}

}
