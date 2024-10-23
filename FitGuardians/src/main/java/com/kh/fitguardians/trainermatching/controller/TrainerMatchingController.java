package com.kh.fitguardians.trainermatching.controller;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.fitguardians.common.model.vo.PageInfo;
import com.kh.fitguardians.common.template.Pagination;
import com.kh.fitguardians.member.model.vo.Member;
import com.kh.fitguardians.trainermatching.model.service.TrainermatchingserviceImpl;

import com.kh.fitguardians.trainermatching.model.vo.trainermatching;

@Controller
public class TrainerMatchingController {
	@Autowired(required = true)
	private SqlSessionTemplate sqlsession;
	
	
	@RequestMapping("trainermatching.bo")
	public String TrainerMatching(@RequestParam(value="cpage", defaultValue = "1") int currentPage ,HttpServletRequest request) {
			ArrayList<trainermatching> list2 = new TrainermatchingserviceImpl().trainercount(sqlsession);
			
			PageInfo pi =  Pagination.getPageInfo(list2.size(), currentPage, 10, 10);
			ArrayList<trainermatching> list = new TrainermatchingserviceImpl().trainerselect(sqlsession,pi);
	
			request.setAttribute("list", list);
			request.setAttribute("pi", pi);
			
		

//			list2.add(new trainerInfo());
		return "trainermatching/trainermatchinglist";
				
	}
	@RequestMapping("shop.do")
	public String tosspay( String orderpt, Model model) {
		model.addAttribute("orderpt",orderpt);
		return "trainermatching/tosspay";
	}
	
	@RequestMapping("/success")
	public String tosspay() {
	return "trainermatching/success";
	}
	
	@ResponseBody
	@RequestMapping("membershippt.bo")
	public String pt(int pttime, String pt, HttpServletRequest request) {
			HttpSession session = request.getSession();
			Member m =  (Member) session.getAttribute("loginUser");
			
			m.setPt(pt);
			m.setPtTime(pttime);
		int result = new TrainermatchingserviceImpl().trainerupdate(sqlsession,m);

		if(result >0) {
				
				return "pt결제 성공";
			}else {
				return "pt결제 실패";
			}
	
	}
	
	@ResponseBody
	@RequestMapping("trainermatchingsearch.bo")
	public Member trainermatchingsearch( HttpServletRequest request) {
		HttpSession session = request.getSession();
		Member m =  (Member) session.getAttribute("loginUser");
		String userId = m.getUserId();
		Member list =  new TrainermatchingserviceImpl().trainermatchingsearch(sqlsession,userId);
	
		return list;
	}
	
}

