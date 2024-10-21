package com.kh.fitguardians.mealplan.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.fitguardians.mealplan.model.vo.MealPlan;
import com.kh.fitguardians.member.model.vo.Member;
@Repository
public class MealPlanDao {
	
	public ArrayList<MealPlan> mealList(SqlSession sqlSession){
		return (ArrayList)sqlSession.selectList("");
	}
	
	public ArrayList<Member> getTraineList(SqlSession sqlSession, String userId){
	

		return (ArrayList)sqlSession.selectList("mealplanMapper.getTraineList",userId);
	}
	public int insertMealPlan(SqlSession sqlSession,MealPlan m){
	
		return sqlSession.insert("mealplanMapper.insertMealPlan" ,m);
	}
	public  ArrayList<MealPlan> selectMealPlanList(SqlSession sqlSession, MealPlan m) {

		return  (ArrayList)sqlSession.selectList("mealplanMapper.selectMealPlanList", m);
	}
	public  ArrayList<MealPlan> selecttraineemealplanlist(SqlSession sqlSession, MealPlan m) {
		
		return  (ArrayList)sqlSession.selectList("mealplanMapper.selecttraineemealplanlist", m);
	}
	public int updatesendReMsg(SqlSession sqlSession, MealPlan m) {
		
		return  sqlSession.update("mealplanMapper.updatesendReMsg", m);
	}
	public int updatetrainersendReMsg(SqlSession sqlSession, MealPlan m) {
	
		return  sqlSession.update("mealplanMapper.updatetrainersendReMsg", m);
	}
	public Member searchtrainer(SqlSession sqlSession, String userId){
		
		
		return sqlSession.selectOne("mealplanMapper.searchtrainer",userId);
	}
	public int insertMealtraineePlan(SqlSession sqlSession,MealPlan m){
		
		return sqlSession.insert("mealplanMapper.insertMealtraineePlan" ,m);
	}
	public  ArrayList<MealPlan> selectMealPlantrainerList(SqlSession sqlSession, MealPlan m) {

		ArrayList<MealPlan> list = 	(ArrayList)sqlSession.selectList("mealplanMapper.selectMealPlantrainerList", m);
	
		return   list;
	}
	public  ArrayList<MealPlan> checkmealPlan(SqlSession sqlSession, MealPlan m) {
		
		return  (ArrayList)sqlSession.selectList("mealplanMapper.checkmealPlan", m);
	}
	public  int traineedleltemealPlan(SqlSession sqlSession, MealPlan m) {
		
		return  sqlSession.delete("mealplanMapper.traineedleltemealPlan", m);
	}
	public  ArrayList<MealPlan> trainercheckmealPlan(SqlSession sqlSession, MealPlan m) {
		
		return  (ArrayList)sqlSession.selectList("mealplanMapper.trainercheckmealPlan", m);
	}
	public  int trainerdleltemealPlan(SqlSession sqlSession, MealPlan m) {
		
		return  sqlSession.delete("mealplanMapper.trainerdleltemealPlan", m);
	}
	public  ArrayList<MealPlan> selectMealmainPlantrainerList(SqlSession sqlSession, MealPlan m) {
		
		return  (ArrayList)sqlSession.selectList("mealplanMapper.selectMealmainPlantrainerList", m);
	}
}
