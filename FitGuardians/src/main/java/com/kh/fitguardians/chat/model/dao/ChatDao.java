package com.kh.fitguardians.chat.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.kh.fitguardians.chat.model.vo.Message;
import com.kh.fitguardians.chat.model.vo.MessageParticipantDTO;
import com.kh.fitguardians.member.model.vo.Member;

@Repository
public class ChatDao {
    
    // 메시지 전송
    public int sendMessage(SqlSessionTemplate session, Message message) {
	    int result = session.insert("ChatMapper.sendMessage", message);
	    return result;
    }
    
    // 채팅방 생성
    public int createChatRoom(SqlSessionTemplate session, int senderNo, int receiverNo) {
    	
    	// 파라미터를 Map에 담기 인자를 두개 넘겨야 하므로 맵에 담자
        Map<String, Integer> params = new HashMap<>();
        params.put("userNo", senderNo);
        params.put("trainerNo", receiverNo);
        
    	int result = session.insert("ChatMapper.createChatRoom", params );
    	return result;
    }
    
    // 채팅방 존재 확인
    public int checkChatRoomExists(SqlSessionTemplate session, int senderNo, int receiverNo) {
        
    	Map<String, Integer> params = new HashMap<>();
        params.put("senderNo", senderNo);
        params.put("receiverNo", receiverNo);
        
        int result = session.selectOne("ChatMapper.checkChatRoomExists", params );
    	return result;
    }
    
    // 채팅방 번호 가져오기
    public Integer getChatRoomNo(SqlSessionTemplate session, int senderNo, int receiverNo) {
        
    	Map<String, Integer> params = new HashMap<>();
        params.put("senderNo", senderNo);
        params.put("receiverNo", receiverNo);
    	
        int result = session.selectOne("ChatMapper.getChatRoomNo", params );
    	return result;
    }

    

    // 특정 채팅방의 메시지 조회
    public ArrayList<Message> getMessages(SqlSessionTemplate session, int chNo, int senderNo, int receiverNo) {
        // SQL 쿼리를 사용하여 메시지를 조회
        Map<String, Object> params = new HashMap<>();
        params.put("chNo", chNo);
        params.put("senderNo", senderNo);
        params.put("receiverNo", receiverNo);
        
        // 메시지를 조회
        ArrayList<Message> messages = (ArrayList)session.selectList("ChatMapper.getMessages", params);

        
        return messages;
    }
    
    // 특정 채팅방 새 메시지 조회
    public ArrayList<Message> fetchNewMessages(SqlSessionTemplate session, int chNo, int senderNo, int receiverNo, int lastMsgNo) {
        
        // SQL 쿼리를 사용하여 새 메시지를 조회
        Map<String, Object> params = new HashMap<>();
        params.put("chNo", chNo);
        params.put("senderNo", senderNo);
        params.put("receiverNo", receiverNo);
        params.put("lastMsgNo", lastMsgNo);
        
        // 새 메시지를 조회
        ArrayList<Message> newMessageNos = (ArrayList) session.selectList("ChatMapper.fetchNewMessages", params);
        
        return newMessageNos;
    }

    

    
    // 메시지 상태 업데이트 (추가 기능)
    public int updateMessageStatus(SqlSessionTemplate session, ArrayList<Message> messagesToUpdate) {
        int totalUpdated = 0;

        for (Message message : messagesToUpdate) {

            totalUpdated += session.update("ChatMapper.updateMessageStatus", message); // XML 매퍼에 정의된 SQL 쿼리 호출
        }

        return totalUpdated; // 업데이트된 메시지 수 반환
    }

    
    // 활성화된 채팅 수
    public int getActiveChatCount(SqlSessionTemplate sqlSession, int userNo) {
        return sqlSession.selectOne("ChatMapper.getActiveChatCount", userNo);
    }
    // 안읽은 채팅 수
    public int getUnReadMsgCount(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("ChatMapper.getUnReadMsgCount", userNo);
	}  

    // 활성화된 채팅 상대 조회 (회원용)
    public ArrayList<MessageParticipantDTO> getActiveParticipantsForUser(SqlSessionTemplate sqlSession, int userNo) {
        return (ArrayList) sqlSession.selectList("ChatMapper.getActiveParticipantsForUser", userNo);
    }

    // 활성화된 채팅 상대 조회 (트레이너용)
    public ArrayList<MessageParticipantDTO> getActiveParticipantsForTrainer(SqlSessionTemplate sqlSession, int userNo) {
        return (ArrayList) sqlSession.selectList("ChatMapper.getActiveParticipantsForTrainer", userNo);
    }
    
    // 트레이너 검색
    public ArrayList<Member> searchTrainers(SqlSessionTemplate sqlSession, String keyword) {
        ArrayList<Member> trainers = (ArrayList)sqlSession.selectList("ChatMapper.searchTrainers", keyword);
        return trainers;
    }
    
    // 파일 업로드
    public int uploadFile(SqlSessionTemplate session, String fileName, String filePath, int userNo) {
    	
    	Map<String, Object> params = new HashMap<>();
        params.put("fileName", fileName);
        params.put("filePath", filePath);
        params.put("uploadedBy", userNo);
    	
    	return session.insert("ChatMapper.uploadFile", params);
	}

	

}
