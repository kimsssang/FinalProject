package com.kh.fitguardians.mealplan.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Date;
import java.text.DateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.fitguardians.mealplan.model.service.MealPlanServiceImpl;
import com.kh.fitguardians.mealplan.model.vo.MealPlan;
import com.kh.fitguardians.member.model.vo.Member;

@Controller
public class mealplanController {
	@Autowired(required = true)
	private SqlSessionTemplate sqlSession ;
	
	private static final String servicekey = "xr9%2BpmuGgw9NDyPQBUCGl%2Fy%2FRPXgxalXf4lTt%2FmbnxWCqpWjsxEc9m1MrHsQ4OKKrmdVBc4Jhz1zU6uBOq008g%3D%3D";
	
	@RequestMapping("mealPlanPage.bo")
	public String mealmain() {
		
		return "mealPlan/mealPlanPage";
	}

	@ResponseBody
	@RequestMapping(value = "mealplanlist.bo", produces = "application/json; charset=utf-8")
	public String mealplan(ModelAndView mv , String foodName , String pageNo) throws IOException {
		//페이징바 , api받아서 만들기
		if(foodName == null) {
			foodName = "";
		}
		if(pageNo == null) {
			pageNo = "1";
		}
		String url="https://apis.data.go.kr/1471000/FoodNtrCpntDbInfo01/getFoodNtrCpntDbInq01";
		url += "?serviceKey="+servicekey;
		url +="&pageNo="+ pageNo;
		url +="&numOfRows="+ 10;
		url +="&type=json&FOOD_NM_KR="  + URLEncoder.encode(foodName,"utf-8") ;
		
		URL requestUrl = new URL(url);
		String resopnseText = "";
		HttpURLConnection urlconnection = (HttpURLConnection)requestUrl.openConnection();
		urlconnection.setRequestMethod("GET");
		
		BufferedReader br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream()));
		String line;
		while((line =br.readLine()) != null) {
			resopnseText += line;
		}
		br.close();
		urlconnection.disconnect();
		
		return resopnseText;
	}

	@RequestMapping(value = "trainermealplan.bo")
	public String mealplan(HttpServletRequest request ) {

		
		return "mealPlan/trainerMealPlan";
	}
	

	@RequestMapping(value = "setmealplanList.bo")
	public String mealplanList(HttpServletRequest request ,String[] foodCode ,String[] foodName  ,double[] kcal  ,double[] sugar  ,double[] carbs  
			,double[] protein  ,double[] fat  ,String mealDate, String getUserId , String sendUserId ,HttpSession session ,String mealMsg ) {
		//음식코드 insert용 
		
		int result2 = 1 ;
	    for(int i = 0 ;i< foodCode.length; i++) {
	    	//정보는 충분해 이 정보 가지고 지금부터 insert 할거임
	    	MealPlan m = new MealPlan();
	    	m.setSendUserId(sendUserId);
	    	m.setGetUserId(getUserId);
	    	m.setMealDate(mealDate);
	    	m.setFoodCode(foodCode[i]);
	    	m.setFoodName(foodName[i]);
	    	m.setKcal(kcal[i]);
	    	m.setSugar(sugar[i]);
	    	m.setCarbs(carbs[i]);
	    	m.setProtein(protein[i]);
	    	m.setFat(fat[i]);
	    	m.setMealMsg(mealMsg);

	    	int result = new MealPlanServiceImpl().insertMealPlan(sqlSession,m);
	    	//여기까진 끝 이제 원래 페이지 다시열
	    	result2 = result*result2;
	    	
	    }
	    if(result2>0) {
	    	
	    	return "mealPlan/trainerMealPlan";
	    }else {
	    	return "" ;
	    }
	  
	}
	
	@ResponseBody
	@RequestMapping(value="gettrainelist.bo")
	public ArrayList<Member> getTraineList(String userId) {
		//트레이너의 트레이닝 받는 회원들 확인
		ArrayList<Member> list = new MealPlanServiceImpl().getTraineList(sqlSession,userId);
		
		return list;
	}

	@RequestMapping(value="traineemealplan.bo")
	public String traineemealplan(HttpServletRequest request ) {
		//첫 로그인시 페이지
		//일단 혼자 시험해야하니까 임시로 로그인된 사람은 트레이너라는 가정하에 진행해보자
	

		
		LocalDate time = LocalDate.now();
	
		
		return "mealPlan/traineeMealPlan";
	}
	
	@ResponseBody
	@RequestMapping(value = "traineeMealPlanLsit.bo")
	public ArrayList<MealPlan> traineemealplanlist(Date day , HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		//일단 받아온 date를 String로 형변환
		 String today = day.toString();
		 //이제 이 String 가지고 서치해와야함
		 
		 //일단 같이 가야할 userId 가져오자
		 Member m =  (Member) session.getAttribute("loginUser");
		 String getuserId = m.getUserId();
		 //이제 이 userId와 today를 가지고 서치해와야하는 상황 일단 넣어주고 보낸다
		 MealPlan p = new MealPlan();
		 p.setGetUserId(getuserId);
		 p.setMealDate(today);
		 ArrayList<MealPlan> list = new MealPlanServiceImpl().selectMealPlanList(sqlSession, p);
		
		return list;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "mealPlanTrainerList.bo")
	public ArrayList<MealPlan> trainermealplanlist(Date day , HttpServletRequest request ,String sendUser) {
		HttpSession session = request.getSession();
	
		String today = day.toString();
		//이제 이 String 가지고 서치해와야함
		
		//일단 같이 가야할 userId 가져오자
		Member m =  (Member) session.getAttribute("loginUser");
		String getuserId = m.getUserId();
		
		//이제 이 userId와 today를 가지고 서치해와야하는 상황 일단 넣어주고 보낸다
		MealPlan p = new MealPlan();
		p.setGetUserId(getuserId);
		p.setMealDate(today);
		p.setSendUserId(sendUser);
	
		ArrayList<MealPlan> list = new MealPlanServiceImpl().selectMealPlantrainerList(sqlSession, p);

		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "traineesendmealplanlist.bo")
	public ArrayList<MealPlan> traineesendmealplanlist(Date day , HttpServletRequest request ,String getUserId) {
		HttpSession session = request.getSession();
		
		String today = day.toString();
		//이제 이 String 가지고 서치해와야함
		
		//일단 같이 가야할 userId 가져오자
		Member m =  (Member) session.getAttribute("loginUser");
		String senduserId = m.getUserId();
		
		//이제 이 userId와 today를 가지고 서치해와야하는 상황 일단 넣어주고 보낸다
		MealPlan p = new MealPlan();
		p.setGetUserId(getUserId);
		p.setMealDate(today);
		p.setSendUserId(senduserId);

		ArrayList<MealPlan> list = new MealPlanServiceImpl().selectMealPlantrainerList(sqlSession, p);
	
		
	
		return list;
	}
	@ResponseBody
	@RequestMapping(value = "traineesendmealplanlist2.bo")
	public ArrayList<MealPlan> traineesendmealplanlist2(Date day , HttpServletRequest request ,String sendUserId) {
		HttpSession session = request.getSession();
		
		String today = day.toString();
		//이제 이 String 가지고 서치해와야함
		
		//일단 같이 가야할 userId 가져오자
		Member m =  (Member) session.getAttribute("loginUser");
		String getuserId = m.getUserId();
		
		//이제 이 userId와 today를 가지고 서치해와야하는 상황 일단 넣어주고 보낸다
		MealPlan p = new MealPlan();
		p.setSendUserId(sendUserId);
		p.setMealDate(today);
		p.setGetUserId(getuserId);
	
	
		ArrayList<MealPlan> list = new MealPlanServiceImpl().selectMealPlantrainerList(sqlSession, p);
		
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "traineesendmealmainplanlist.bo")
	public ArrayList<MealPlan> traineesendmealmainplanlist(Date day , HttpServletRequest request ,String getUserId) {
		HttpSession session = request.getSession();
		
		String today = day.toString();
		//이제 이 String 가지고 서치해와야함
		
		//일단 같이 가야할 userId 가져오자
		Member m =  (Member) session.getAttribute("loginUser");
		String senduserId = m.getUserId();
		
		//이제 이 userId와 today를 가지고 서치해와야하는 상황 일단 넣어주고 보낸다
		MealPlan p = new MealPlan();
		p.setGetUserId(getUserId);
		p.setMealDate(today);
		p.setSendUserId(senduserId);
		
		ArrayList<MealPlan> list = new MealPlanServiceImpl().selectMealmainPlantrainerList(sqlSession, p);
		
		return list;
	}
	
	
	
	@RequestMapping("trainerMealPlanList.bo")
	public String trainermealPlanList(HttpServletRequest request ) {

		
		return "mealPlan/trainerMealPlanList";
	}
	
	@ResponseBody
	@RequestMapping(value = "trainerMealPlanLsit.bo")
	public ArrayList<MealPlan> traineemealplanlist(Date day , HttpServletRequest request , String getUser) {
		HttpSession session = request.getSession();
	

		//일단 받아온 date를 String로 형변환
		String today = day.toString();
		//이제 이 String 가지고 서치해와야함
		
		//일단 같이 가야할 userId 가져오자
		Member m =  (Member) session.getAttribute("loginUser");
		String senduserId = m.getUserId();
		//이제 이 userId와 today를 가지고 서치해와야하는 상황 일단 넣어주고 보낸다
		MealPlan p = new MealPlan();
		p.setSendUserId(senduserId);
		p.setGetUserId(getUser);
		p.setMealDate(today);
		ArrayList<MealPlan> list = new MealPlanServiceImpl().selecttraineemealplanlist(sqlSession, p);

		return list;
	}
	
	@RequestMapping(value = "sendReMsg.bo")
	public String sendReMsg(Date day , HttpServletRequest request ,String mealRemsg) {
		String today = day.toString();
		HttpSession session = request.getSession();
		Member m =  (Member) session.getAttribute("loginUser");
		String getuserId = m.getUserId();
		MealPlan p = new MealPlan();
		p.setGetUserId(getuserId);
		p.setMealDate(today);
		p.setMealRemsg(mealRemsg);
		int result = new MealPlanServiceImpl().updatesendReMsg(sqlSession, p);
		
		if(result>0) {
			return "mealPlan/traineeMealPlan";
		}else {
			return "" ;
			
		}
	}
	@RequestMapping(value = "trainersendReMsg.bo")
	public String sendReMsg(Date day , HttpServletRequest request, String sendUser, String mealRemsg) {
		String today = day.toString();
		HttpSession session = request.getSession();
		Member m =  (Member) session.getAttribute("loginUser");
		String getuserId = m.getUserId();
		MealPlan p = new MealPlan();
		p.setGetUserId(getuserId);
		p.setSendUserId(sendUser);
		p.setMealDate(today);
		p.setMealRemsg(mealRemsg);
		int result = new MealPlanServiceImpl().updatetrainersendReMsg(sqlSession, p);
		
		if(result>0) {
			return "mealPlan/traineeMealPlan";
		}else {
			return "" ;
			
		}
	}
	@RequestMapping("traineesnedMealplan.bo")
	public String traineesnedMealplan(HttpServletRequest request ) {

		return "mealPlan/traineesendMealPlan";
	}
	
	@ResponseBody
	@RequestMapping(value="searchtrainer.bo")
	public Member searchtrainer(String userId) {
		//회원의 트레이너 확인
	
		Member list = new MealPlanServiceImpl().searchtrainer(sqlSession,userId);
		
		return list;
	}
	@RequestMapping(value = "setmealplantraineeList.bo")
	public String mealplantraineeList(HttpServletRequest request ,String[] foodCode ,String[] foodName  ,double[] kcal  ,double[] sugar  ,double[] carbs  
			,double[] protein  ,double[] fat  ,String mealDate, String getUserId , String sendUserId ,HttpSession session ,String mealMsg ) {
		//음식코드 insert용 
		int result2 = 1 ;
	    for(int i = 0 ;i< foodCode.length; i++) {
	    	//정보는 충분해 이 정보 가지고 지금부터 insert 할거임
	    	MealPlan m = new MealPlan();
	    	m.setSendUserId(sendUserId);
	    	m.setGetUserId(getUserId);
	    	m.setMealDate(mealDate);
	    	m.setFoodCode(foodCode[i]);
	    	m.setFoodName(foodName[i]);
	    	m.setKcal(kcal[i]);
	    	m.setSugar(sugar[i]);
	    	m.setCarbs(carbs[i]);
	    	m.setProtein(protein[i]);
	    	m.setFat(fat[i]);
	    	m.setMealMsg(mealMsg);
	    	
	   
	    	
	    	int result = new MealPlanServiceImpl().insertMealtraineePlan(sqlSession,m);
	    	//여기까진 끝 이제 원래 페이지 다시열
	    	result2 = result*result2;
	    	
	    }
	    if(result2>0) {
	    	
	    	return "mealPlan/traineesendMealPlan";
	    }else {
	    	return "" ;
	    }
	  
	}
	@RequestMapping("trainergetMealPlanList.bo")
	public String trainergetmealPlanList(HttpServletRequest request ) {

		return "mealPlan/trainergetMealPlan";
	}
	@RequestMapping("traineesendMealPlanList.bo")
	public String traineesendmealPlanList(HttpServletRequest request ) {

		return "mealPlan/traineeMealPlanList";
	}
	
	@ResponseBody
	@RequestMapping("checkmealPlan.bo")
	public ArrayList<MealPlan> checkmealPlan(HttpServletRequest request , String getUserId, String sendUserId, Date mealDate ) {
	
		String today = mealDate.toString();
		MealPlan m = new MealPlan();
		m.setGetUserId(getUserId);
		m.setSendUserId(sendUserId);
		m.setMealDate(today);

		ArrayList<MealPlan> list = new MealPlanServiceImpl().checkmealPlan(sqlSession,m);

		
		return list;
	}
	
	@ResponseBody
	@RequestMapping("traineedleltemealPlan.bo")
	public int traineedleltemealPlan(HttpServletRequest request , String getUserId, String sendUserId, Date mealDate ) {
		
		String today = mealDate.toString();
		MealPlan m = new MealPlan();
		m.setGetUserId(getUserId);
		m.setSendUserId(sendUserId);
		m.setMealDate(today);
		
		int result = new MealPlanServiceImpl().traineedleltemealPlan(sqlSession,m);
	
		
		return result;
	}
	
@ResponseBody
@RequestMapping("trainercheckmealPlan.bo")
public ArrayList<MealPlan> trainercheckmealPlan(HttpServletRequest request , String getUserId, String sendUserId, Date mealDate ) {
	
	String today = mealDate.toString();
	MealPlan m = new MealPlan();
	m.setGetUserId(getUserId);
	m.setSendUserId(sendUserId);
	m.setMealDate(today);
	
	ArrayList<MealPlan> list = new MealPlanServiceImpl().trainercheckmealPlan(sqlSession,m);

	
	return list;
	
}
@ResponseBody
@RequestMapping("trainerdleltemealPlan.bo")
public int trainerdleltemealPlan(HttpServletRequest request , String getUserId, String sendUserId, Date mealDate ) {
	
	String today = mealDate.toString();
	MealPlan m = new MealPlan();
	m.setGetUserId(getUserId);
	m.setSendUserId(sendUserId);
	m.setMealDate(today);

	int result = new MealPlanServiceImpl().trainerdleltemealPlan(sqlSession,m);
	

	return result;
}
}
