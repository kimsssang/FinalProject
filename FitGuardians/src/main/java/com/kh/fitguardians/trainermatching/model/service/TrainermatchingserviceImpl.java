package com.kh.fitguardians.trainermatching.model.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.fitguardians.common.model.vo.PageInfo;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.trainermatching.model.dao.TraineramtchingDao;
import com.kh.fitguardians.trainermatching.model.vo.trainermatching;

@Service
public class TrainermatchingserviceImpl implements Trainermatchingservice {
	
	@Autowired
	private TraineramtchingDao tDao = new TraineramtchingDao();
	
	@Override
	public ArrayList<trainermatching> trainercount(SqlSession sqlSession) {
		
		return tDao.trainercount(sqlSession);
	}

	@Override
	public ArrayList<trainermatching> trainerselect(SqlSession sqlSession ,PageInfo pi) {

		return tDao.trainerselect(sqlSession , pi);
	}

}
