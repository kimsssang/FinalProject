package com.kh.fitguardians.gym.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GymController {
	
	@RequestMapping("searchGym.ma")
	public String showGymSearchPage() {
		return "gym/gym";
	}

}
