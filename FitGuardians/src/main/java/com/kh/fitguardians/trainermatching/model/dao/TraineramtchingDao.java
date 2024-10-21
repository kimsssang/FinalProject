package com.kh.fitguardians.trainermatching.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.fitguardians.common.model.vo.PageInfo;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.trainermatching.model.vo.trainermatching;

@Repository
public class TraineramtchingDao {
	
	public ArrayList<trainermatching> trainercount(SqlSession sqlSession ){
		
		
		return  (ArrayList)sqlSession.selectList("trainermatchingMapper.trainercount");
	}
	public ArrayList<trainermatching> trainerselect(SqlSession sqlSession ,PageInfo pi){
		int offset = (pi.getCurrentPage()-1)* pi.getBoardLimit() ;
		//보여줄 마지막 숫자
		int limit = pi.getBoardLimit()  ;
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		return  (ArrayList)sqlSession.selectList("trainermatchingMapper.trainerselect",null, rowBounds);
	}
	
	public int trainerupdate(SqlSession sqlSession ,Member m) {

		return sqlSession.update("trainermatchingMapper.trainerupdate",m);
	}
	public Member trainermatchingsearch(SqlSession sqlSession ,String userId) {
		
		return sqlSession.selectOne("trainermatchingMapper.trainermatchingsearch",userId);
	}

}
