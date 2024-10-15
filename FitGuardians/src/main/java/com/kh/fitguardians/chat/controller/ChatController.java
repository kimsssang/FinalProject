package com.kh.fitguardians.chat.controller;

import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller; // 변경
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.kh.fitguardians.chat.model.service.ChatService;
import com.kh.fitguardians.chat.model.vo.Message;
import com.kh.fitguardians.chat.model.vo.MessageParticipantDTO;

@Controller // 변경
@RequestMapping("/chat")
@CrossOrigin(origins = "*") // 모든 출처에서 요청 허용
public class ChatController {

    @Autowired
    private ChatService chatService;
    
    @PostMapping("/send")
    @ResponseBody
    public ResponseEntity<?> sendMessage(@RequestBody Message message) {
        try {
            // 채팅방 번호와 발신자, 수신자 출력
            System.out.println("채팅방 번호: " + message.getChNo());
            System.out.println("발신자 번호: " + message.getSenderNo());
            System.out.println("수신자 번호: " + message.getReceiverNo());

            // 메시지 전송
            chatService.sendMessage(message);
            return ResponseEntity.ok().build();
        } catch (DataIntegrityViolationException e) {
            System.err.println("데이터 무결성 위반: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("메시지 전송 실패: 무결성 위반");
        } catch (Exception e) {
            System.err.println("예외 발생: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("메시지 전송 실패: 서버 오류");
        }
    }



    // 메시지 조회
    @GetMapping("/messages/{chNo}")
    @ResponseBody // JSON 형태로 응답
    public ArrayList<Message> getMessages(@PathVariable int chNo, @RequestParam int senderNo, @RequestParam int receiverNo) {
    	
    	System.out.println("채팅방 번호 : " + chNo);
    	System.out.println("발신자 번호 : " + senderNo);
    	System.out.println("수신자 번호 : " + receiverNo);
    	
    	ArrayList<Message> messages = chatService.getMessage(chNo, senderNo, receiverNo);
        System.out.println("조회된 메시지 수: " + messages.size()); // 조회된 메시지 수 출력
        for (Message message : messages) {
            System.out.println("메시지: " + message); // 각 메시지 출력
        }
        
        return messages;
    }

    // 메시지 상태 업데이트
    @PutMapping("/messages/{msgNo}/status")
    @ResponseBody // JSON 형태로 응답
    public int updateMessageStatus(@PathVariable int msgNo, @RequestParam String status) {
        return chatService.updateMessageStatus(msgNo, status);
    }
    
    // 활성화 채팅 수 조회
    @GetMapping("/activeChatCount/{userNo}")
    @ResponseBody // JSON 형태로 응답
    public int getActiveChatCount(@PathVariable int userNo) {
        return chatService.getActiveChatCount(userNo);
    }

    // 활성화된 채팅 참가자 조회 (회원)
    @GetMapping("/activeParticipants/user/{userNo}")
    @ResponseBody // JSON 형태로 응답
    public ArrayList<MessageParticipantDTO> getActiveParticipantsForUser(@PathVariable int userNo) {
        return chatService.getActiveParticipantsForUser(userNo);
    }

    // 활성화된 채팅 참가자 조회 (트레이너)
    @GetMapping("/activeParticipants/trainer/{userNo}")
    @ResponseBody // JSON 형태로 응답
    public ArrayList<MessageParticipantDTO> getActiveParticipantsForTrainer(@PathVariable int userNo) {
        return chatService.getActiveParticipantsForTrainer(userNo);
    }
}
