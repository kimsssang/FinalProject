package com.kh.fitguardians.chat.model.service;

import java.util.ArrayList;

import com.kh.fitguardians.chat.model.vo.Message;
import com.kh.fitguardians.chat.model.vo.MessageParticipantDTO;
import com.kh.fitguardians.member.model.vo.Member;

public interface ChatService {
	
	// 메시지 전송
	Message sendMessage(Message message);
	
	// 채팅방 생성
	int createChatRoom(int senderNo, int receiverNo);
	
	// 채팅방 존재 여부 확인 및 번호 가져오기
    Integer checkChatRoomAndGetNumber(int senderNo, int receiverNo);
	
	// 특정 채팅방의 메시지 조회
	ArrayList<Message> getMessage(int chNo, int senderNo, int receiverNo);
	
	// 특정 채팅방의 새 메시지 조회
	ArrayList<Message> fetchNewMessages(int chNo, int senderNo, int receiverNo, int lastMsgNo);
	
	// 메시지 상태 업데이트
	int updateMessageStatus(ArrayList<Message> messagesToUpdate);
	
	// 활성화된 채팅 수 조회
    int getActiveChatCount(int userNo);
    
    // 활성화된 채팅 참가자 조회 (회원 기준)
    ArrayList<MessageParticipantDTO> getActiveParticipantsForUser(int userNo);

    // 활성화된 채팅 참가자 조회 (트레이너 기준)
    ArrayList<MessageParticipantDTO> getActiveParticipantsForTrainer(int userNo);
    
    // 트레이너 검색
    ArrayList<Member> searchTrainers(String keyword);



}
