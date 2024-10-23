package com.kh.fitguardians.chat.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller; // 변경
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
    
    // 채팅 모달에서 파일 업로드
    @PostMapping("/fileUpload")
    @ResponseBody
    public String uploadFile(@RequestParam("files") MultipartFile[] files, @RequestParam("userNo") int userNo, HttpSession session) {
        
    	StringBuilder uploadedFileNames = new StringBuilder();
    	StringBuilder uploadedFileUrls = new StringBuilder();

        for (MultipartFile file : files) {
        	
        	
            if (!file.isEmpty()) {
                String fileName = saveFile(file, session); // 서비스 메서드 호출
                uploadedFileNames.append(fileName).append(", "); // 업로드된 파일 이름 추가
                String filePath = "/resources/uploadFiles/chat/" + fileName; // 파일 경로 생성
                
                // 파일 URL 생성
                String fileUrl = "/fitguardians" + filePath; // 실제 URL로 변환
                
                int result = chatService.uploadFile(fileName, filePath, userNo); // 업로드 후 반환값 체크
                
                // 파일 URL을 응답에 추가
                uploadedFileUrls.append(fileUrl).append(", ");
                
            }
        }

        // 마지막에 추가된 쉼표와 공백 제거
        if (uploadedFileNames.length() > 0) {
            uploadedFileNames.setLength(uploadedFileNames.length() - 2);
        }
        
        if (uploadedFileUrls.length() > 0) {
            uploadedFileUrls.setLength(uploadedFileUrls.length() - 2);
        }
        
        return "{\"success\": true, \"uploadedFiles\": \"" + uploadedFileNames.toString() + "\", \"uploadedFileUrls\": \"" + uploadedFileUrls.toString() + "\"}"; // JSON 형태로 응답
    }

    
    
    
    public String saveFile(MultipartFile upfile, HttpSession session) {
		String originName = upfile.getOriginalFilename(); // "flower.png" 원본명
		
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()); // "20240926150855"
		int ranNum = (int)(Math.random() * 90000 + 10000); // 23152 (5자리 랜덤값)
		String ext = originName.substring(originName.lastIndexOf(".")); // ".png"
		
		String changeName = currentTime + ranNum + ext;
		
		// 업로드 시키고자 하는 폴더의 물리적인 경로 알아내기
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/chat/");
		
		File folder = new File(savePath);
		if (!folder.exists()) {
		    folder.mkdirs(); // 폴더가 없으면 생성
		}
		
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		
		return changeName;
	}
}
