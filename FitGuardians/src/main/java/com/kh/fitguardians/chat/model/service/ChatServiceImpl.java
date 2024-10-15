package com.kh.fitguardians.chat.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public int sendMessage(Message message) {
		if (message.getMsgStatus() == null) {
	        message.setMsgStatus("U"); // 기본값 설정
	    }
	    int result = chatDao.sendMessage(sqlSession, message);
	    
	    return result;
	}

	@Override
	public ArrayList<Message> getMessage(int chNo, int senderNo, int receiverNo) {
		
		return chatDao.getMessages(sqlSession, chNo, senderNo, receiverNo);
	}

	@Override
	public int updateMessageStatus(int msgNo, String status) {
		
		return chatDao.updateMessageStatus(sqlSession, msgNo, status);
	}

	
	
	
	// 활성화된 채팅 수 조회
    @Override
    public int getActiveChatCount(int userNo) {
        return chatDao.getActiveChatCount(sqlSession, userNo);
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
	
	

}
