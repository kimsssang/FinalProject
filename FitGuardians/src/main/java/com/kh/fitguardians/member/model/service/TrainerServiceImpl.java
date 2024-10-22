package com.kh.fitguardians.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.fitguardians.member.model.dao.TrainerDao;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.member.model.vo.Schedule;

@Service
public class TrainerServiceImpl implements TrainerService{

	@Autowired
	private TrainerDao tDao;
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<Schedule> selectSchedule(int userNo) {
		return tDao.selectSchedule(sqlSession, userNo);
	}
	
	@Override
	public int insertTrainerCalendar(Schedule schedule) {
		
		return tDao.insertTrainerCalendar(sqlSession, schedule);
	}

	@Override
	public boolean isDuplicateSchedule(Schedule schedule) {
		int count = tDao.findDuplicate(sqlSession, schedule);
		return count > 0;
	}

	@Override
	public ArrayList<Schedule> selectPtSchedule(Member m) {
		return tDao.selectPtSchedule(sqlSession, m);
	}

	@Override
	public int insertPtCalendar(Schedule schedule) {
		return tDao.insertPtCalendar(sqlSession, schedule);
	}

	@Override
	public String selectUserNo(String userId) {
		return tDao.selectUserNo(sqlSession, userId);
	}
	
	
	

}
