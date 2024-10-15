package com.kh.fitguardians.chat.model.vo;


import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Message {
	
	private int msgNo;          // 메시지 번호
    private String msgContent;   // 메시지 내용
    private String sendDate;      // 보낸 날짜
    private int chNo;           // 채팅방 번호
    private int senderNo;       // 발신자 번호
    private int receiverNo;     // 수신자 번호
    private String msgStatus;    // 메시지 상태 "U", "R", "D", "E" 중 하나로 관리
    private String profileImg; // 프로필 이미지
    private String senderName; // 발신자 이름 추가



}
