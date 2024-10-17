package com.kh.fitguardians.trainermatching.model.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;

import com.kh.fitguardians.common.model.vo.PageInfo;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.trainermatching.model.vo.trainermatching;

public interface Trainermatchingservice {
	
	//트레이너 숫자조회
	ArrayList<trainermatching> trainercount(SqlSession sqlsession);
	//트레이너 조회
	ArrayList<trainermatching> trainerselect(SqlSession sqlSession, PageInfo pi);
	

	
}
