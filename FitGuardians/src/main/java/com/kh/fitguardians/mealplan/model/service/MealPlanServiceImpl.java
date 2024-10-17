package com.kh.fitguardians.mealplan.model.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;


import com.kh.fitguardians.mealplan.model.dao.MealPlanDao;
import com.kh.fitguardians.mealplan.model.vo.MealPlan;

import com.kh.fitguardians.member.model.vo.Member;

@Service
public class MealPlanServiceImpl implements MealPlanservice{

	
	@Autowired(required = true)
	private MealPlanDao mDao = new MealPlanDao();

	
	@Override
	public int mealList() {
	//일단 음식명은 없이 한번 해볼거 나중에 string 한 추가해서 수정해야함
		
//		ArrayList<MealPlan> list = mDao.mealList(sqlSession);
		return 123;
	}
	@Override
	public ArrayList<Member> getTraineList(SqlSession sqlSession, String userId) {
		// TODO Auto-generated method stub
	
		ArrayList<Member> list=  mDao.getTraineList(sqlSession, userId);
		
		return list;
	}
	@Override
	public int insertMealPlan(SqlSession sqlSession, MealPlan m) {

		
		return mDao.insertMealPlan(sqlSession,m);
	}
	@Override
	public ArrayList<MealPlan> selectMealPlanList(SqlSession sqlSession, MealPlan m) {
		
		return  mDao.selectMealPlanList(sqlSession, m );
	}
	@Override
	public ArrayList<MealPlan> selecttraineemealplanlist(SqlSession sqlSession, MealPlan m) {
		
	
		return  mDao.selecttraineemealplanlist(sqlSession, m );
	}
	@Override
	public int updatesendReMsg(SqlSession sqlSession, MealPlan m) {
	
		return  mDao.updatesendReMsg(sqlSession, m );
	
	}
	@Override
	public int updatetrainersendReMsg(SqlSession sqlSession, MealPlan m) {
		
		return  mDao.updatetrainersendReMsg(sqlSession, m );
		
	}
	@Override
	public Member searchtrainer(SqlSession sqlSession, String userId) {
	
		
		return mDao.searchtrainer(sqlSession, userId);
		
	}
	
	@Override
	public int insertMealtraineePlan(SqlSession sqlSession, MealPlan m) {
		
		
		return mDao.insertMealtraineePlan(sqlSession,m);
	}
	@Override
	public ArrayList<MealPlan> selectMealPlantrainerList(SqlSession sqlSession, MealPlan m) {
		
		
		return mDao.selectMealPlantrainerList(sqlSession,m);
	}
	@Override
	public ArrayList<MealPlan> checkmealPlan(SqlSession sqlSession, MealPlan m) {
		
		return mDao.checkmealPlan(sqlSession,m);
	
	}
	@Override
	public int traineedleltemealPlan(SqlSession sqlSession, MealPlan m) {
		
	
		return mDao.traineedleltemealPlan(sqlSession,m);
	}
	@Override
	public ArrayList<MealPlan> trainercheckmealPlan(SqlSession sqlSession, MealPlan m) {
	
	
		return mDao.trainercheckmealPlan(sqlSession,m);
	}
	@Override
	public int trainerdleltemealPlan(SqlSession sqlSession, MealPlan m) {
		return mDao.trainerdleltemealPlan(sqlSession,m);
	
	}
	@Override
	public ArrayList<MealPlan> selectMealmainPlantrainerList(SqlSession sqlSession, MealPlan m) {

		return mDao.selectMealmainPlantrainerList(sqlSession,m);
	}

}
