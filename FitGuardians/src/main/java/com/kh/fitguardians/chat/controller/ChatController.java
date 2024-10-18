package com.kh.fitguardians.chat.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller; // 변경
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
    
    // 채팅 메시지 보내기
    @PostMapping("/send")
    @ResponseBody
    public ResponseEntity<?> sendMessage(@RequestBody Message message) {
        try {

            // 메시지 전송
            Message sentMessage = chatService.sendMessage(message); // 메시지 객체 반환

            if (sentMessage != null) {
                return ResponseEntity.ok(sentMessage); // 성공 시 메시지 객체 반환
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("메시지 전송 실패: 데이터베이스 오류");
            }
        } catch (DataIntegrityViolationException e) {
            System.err.println("데이터 무결성 위반: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("메시지 전송 실패: 무결성 위반");
        } catch (Exception e) {
            System.err.println("예외 발생: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("메시지 전송 실패: 서버 오류");
        }
    }
    
    // 채팅방 생성하기
    @PostMapping("/create")
    public ResponseEntity<Integer> createChatRoom(@RequestParam int senderNo, @RequestParam int receiverNo) {
        int chatRoomNo = chatService.createChatRoom(senderNo, receiverNo);
        return ResponseEntity.ok(chatRoomNo);
    }
    
    // 채팅방 존재 여부 확인 후 번호 가져오기
    @GetMapping("/exists")
    public ResponseEntity<Map<String, Object>> checkChatRoomExists(@RequestParam int senderNo, @RequestParam int receiverNo) {
        Map<String, Object> response = new HashMap<>();
        Integer chatRoomNo = chatService.checkChatRoomAndGetNumber(senderNo, receiverNo); // 존재 여부 확인 및 번호 가져오기

        if (chatRoomNo != null) {
            response.put("exists", true);
            response.put("chatRoomNo", chatRoomNo); // 존재할 경우 채팅방 번호 추가
        } else {
            response.put("exists", false);
        }

        return ResponseEntity.ok(response);
    }





    // 메시지 조회
    @GetMapping("/messages/{chNo}")
    @ResponseBody // JSON 형태로 응답
    public ArrayList<Message> getMessages(@PathVariable int chNo, @RequestParam int senderNo, @RequestParam int receiverNo) {
    	
    	ArrayList<Message> messages = chatService.getMessage(chNo, senderNo, receiverNo);
        
        return messages;
    }
    
    // 새 메시지 조회
    @GetMapping("/newMessages/{chNo}")
    @ResponseBody
    public ArrayList<Message> getNewMessages(
            @PathVariable("chNo") int chNo,
            @RequestParam("senderNo") int senderNo,
            @RequestParam("receiverNo") int receiverNo,
            @RequestParam("lastMsgNo") int lastMsgNo) {
        
        // 새로운 메시지를 가져오는 서비스 메서드 호출
        ArrayList<Message> newMessages = chatService.fetchNewMessages(chNo, senderNo, receiverNo, lastMsgNo);
        
        return newMessages; // 새로운 메시지 객체 리스트 반환
    }
    
    
    // 메시지 상태 업데이트
    @PostMapping("/updateStatus")
    public ResponseEntity<Integer> updateMessageStatus(@RequestBody ArrayList<Message> messagesToUpdate) {
    	
        int updatedCount = chatService.updateMessageStatus(messagesToUpdate);
        return ResponseEntity.ok(updatedCount); // HTTP 200과 함께 업데이트된 메시지 수 반환
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
