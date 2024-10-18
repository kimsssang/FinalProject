package com.kh.fitguardians.trainermatching.controller;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.fitguardians.common.model.vo.PageInfo;
import com.kh.fitguardians.common.template.Pagination;
import com.kh.fitguardians.trainermatching.model.service.TrainermatchingserviceImpl;

import com.kh.fitguardians.trainermatching.model.vo.trainermatching;

@Controller
public class TrainerMatchingController {
	@Autowired(required = true)
	private SqlSessionTemplate sqlsession;
	
	
	@RequestMapping("trainermatching.bo")
	public String TrainerMatching(@RequestParam(value="cpage", defaultValue = "1") int currentPage ,HttpServletRequest request) {
			ArrayList<trainermatching> list2 = new TrainermatchingserviceImpl().trainercount(sqlsession);
			System.out.println(list2);
			PageInfo pi =  Pagination.getPageInfo(list2.size(), currentPage, 10, 10);
			ArrayList<trainermatching> list = new TrainermatchingserviceImpl().trainerselect(sqlsession,pi);
			System.out.println(pi);
			System.out.println(list);
			request.setAttribute("list", list);
			request.setAttribute("pi", pi);
			
		

//			list2.add(new trainerInfo());
		return "trainermatching/trainermatchinglist";
				
	}
	@RequestMapping("shop.do")
	public String tosspay() {
		System.out.println(123);
		return "trainermatching/tosspay";
	}

}

