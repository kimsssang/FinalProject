package com.kh.fitguardians.chat.model.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.fitguardians.chat.model.dao.ChatDao;
import com.kh.fitguardians.chat.model.vo.Message;
import com.kh.fitguardians.chat.model.vo.MessageParticipantDTO;
import com.kh.fitguardians.member.model.vo.Member;

@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ChatDao chatDao;
	
	// 메시지 전송
	@Override
	public Message sendMessage(Message message) {
	    if (message.getMsgStatus() == null) {
	        message.setMsgStatus("U"); // 기본값 설정
	    }
	    int result = chatDao.sendMessage(sqlSession, message);
	    
	    if (result > 0) {
	        return message; // 메시지 객체를 반환
	    } else {
	        return null; // 실패 시 null 반환
	    }
	}

	
	// 채팅방 생성
	@Override
	public int createChatRoom(int senderNo, int receiverNo) {
		
		return chatDao.createChatRoom(sqlSession ,senderNo, receiverNo);
	}
	
	// 서비스에서 채팅방 존재 여부 확인 및 번호 가져오기
	@Override
	public Integer checkChatRoomAndGetNumber(int senderNo, int receiverNo) {
	    int exists = chatDao.checkChatRoomExists(sqlSession, senderNo, receiverNo);
	    if (exists > 0) {
	        return chatDao.getChatRoomNo(sqlSession, senderNo, receiverNo);
	    }
	    return null; // 채팅방이 존재하지 않으면 null 반환
	}

	// 특정 채팅방 메시지 조회
	@Override
	public ArrayList<Message> getMessage(int chNo, int senderNo, int receiverNo) {
		
		return chatDao.getMessages(sqlSession, chNo, senderNo, receiverNo);
	}
	
	
	// 특정 채팅방 새 메시지 조회
	@Override
	public ArrayList<Message> fetchNewMessages(int chNo, int senderNo, int receiverNo, int lastMsgNo) {
		
		return chatDao.fetchNewMessages(sqlSession, chNo, senderNo, receiverNo, lastMsgNo);
	}
	
	// 메시지 상태 업데이트
	@Override
	public int updateMessageStatus(ArrayList<Message> messagesToUpdate) {
		return chatDao.updateMessageStatus(sqlSession, messagesToUpdate);
	}

	// 활성화된 채팅 수 조회
    @Override
    public int getActiveChatCount(int userNo) {
        return chatDao.getActiveChatCount(sqlSession, userNo);
    }
    
    // 안 읽은 채팅 수 조회
    @Override
	public int getUnReadMsgCount(int userNo) {
		return chatDao.getUnReadMsgCount(sqlSession, userNo);
	}

    
    // 활성화된 채팅 참가자 조회 (회원 기준)
	@Override
	public ArrayList<MessageParticipantDTO> getActiveParticipantsForUser(int userNo) {
		return chatDao.getActiveParticipantsForUser(sqlSession, userNo);
	}

	// 활성화된 채팅 참가자 조회 (트레이너 기준)
	@Override
	public ArrayList<MessageParticipantDTO> getActiveParticipantsForTrainer(int userNo) {
		return chatDao.getActiveParticipantsForTrainer(sqlSession, userNo);
	}

	// 트레이너 검색
	@Override
	public ArrayList<Member> searchTrainers(String keyword) {
		return chatDao.searchTrainers(sqlSession, keyword);
	}

	// 파일 업로드
	@Override
	public int uploadFile(String fileName, String filePath, int userNo) {
		return chatDao.uploadFile(sqlSession, fileName, filePath, userNo);
	}


	
	

	

	
	
	

}
