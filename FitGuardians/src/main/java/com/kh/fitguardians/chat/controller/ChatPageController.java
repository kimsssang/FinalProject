package com.kh.fitguardians.chat.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.fitguardians.chat.model.service.ChatService;
import com.kh.fitguardians.member.model.vo.Member;

@Controller
public class ChatPageController {
	
	@Autowired
    private ChatService chatService;
	
	
	@RequestMapping("chatPage.cp")
    public String showChatPage() {
        return "chat/chatPage"; // JSP 파일 경로
    }
	
	// 트레이너 검색 기능 추가
    @PostMapping("searchTrainers")
    @ResponseBody
    public ArrayList<Member> searchTrainers(@RequestParam String keyword) {
    	ArrayList<Member> trainers = chatService.searchTrainers(keyword);
        return trainers;
    }

}
