package com.kh.fitguardians.member.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.fitguardians.member.model.vo.Schedule;

@Repository
public class TrainerDao {

	
	
	public int insertTrainerCalendar(SqlSessionTemplate sqlSession, Schedule schedule) {
		return sqlSession.insert("memberMapper.insertTrainerCalendar", schedule);
	}

	public ArrayList<Schedule> selectSchedule(SqlSessionTemplate sqlSession, int userNo) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectSchedule", userNo);
	}

	public int findDuplicate(SqlSessionTemplate sqlSession, Schedule schedule) {
		return sqlSession.selectOne("memberMapper.findDuplicate", schedule);
	}

}
