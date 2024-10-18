package com.kh.fitguardians.mealplan.model.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;

import com.kh.fitguardians.mealplan.model.vo.MealPlan;
import com.kh.fitguardians.member.model.vo.Member;

public interface MealPlanservice {
	
	//추천할 음식리스트들(검색기능추가)
	public int mealList();
	
	//트레이너에게 트레이닝 받는 회원 록록
	public ArrayList<Member> getTraineList(SqlSession sqlSession,String userId);
	
	//회원이 트레이닝받는 트레이너
	public Member searchtrainer(SqlSession sqlSession,String userId);
	
	// 트레이너가 식단 입력넣어주기
	public int insertMealPlan(SqlSession sqlSession,MealPlan m);
	//회원이 식단 입력넣어주기
	public int insertMealtraineePlan(SqlSession sqlSession,MealPlan m);
	
	//회원이 보낸 식단이 그날 이미 있는지 확인하는 메소드
	public ArrayList<MealPlan> checkmealPlan(SqlSession sqlSession,MealPlan m);
	
	//회원이 보낸 식단이 그날 이미 있을경우 삭제하는 메소드(update용도 삭제후 다시 insert할 예정)
	public int traineedleltemealPlan(SqlSession sqlSession,MealPlan m);
	
	
	//트레이너가 보낸 식단이 그날 이미 있는지 확인하는 메소드
	public ArrayList<MealPlan> trainercheckmealPlan(SqlSession sqlSession,MealPlan m);
	
	//트레이너가 보낸 식단이 그날 이미 있을경우 삭제하는 메소드(update용도 삭제후 다시 insert할 예정)
	public int trainerdleltemealPlan(SqlSession sqlSession,MealPlan m);

	
	
	//트레이너가 회원에게 보낸 식단 받아오기(회원용)
	public  ArrayList<MealPlan> selectMealPlanList(SqlSession sqlSession,MealPlan m);
	
	//트레이너가 회원에게 보낸 식단 받아오기(메인페이지용)
	public  ArrayList<MealPlan> selectMealmainPlantrainerList(SqlSession sqlSession,MealPlan m);
	
	// 트레이너가 회원에게 보낸 식단 받아오기(트레이너용)
	public  ArrayList<MealPlan> selecttraineemealplanlist(SqlSession sqlSession,MealPlan m);
	
	// 트레이너가 회원에게 보낸 식단에 회원이 답장하기(회원 전용)
	public int updatesendReMsg(SqlSession sqlSession,MealPlan m);
	
	// 회원이 보낸 식단에 트레이너가 답장하기(트레이너 전용)
	public int updatetrainersendReMsg(SqlSession sqlSession,MealPlan m);
	
	//트레이너가 회원이 보낸 식단 확인하기(트레이너용)
	public ArrayList<MealPlan> selectMealPlantrainerList(SqlSession sqlSession,MealPlan m);

}
