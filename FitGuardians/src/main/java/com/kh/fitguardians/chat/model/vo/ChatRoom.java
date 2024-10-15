package com.kh.fitguardians.chat.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class ChatRoom {
	private int chNo;          // 채팅방 번호
    private int userNo;        // 유저 번호
    private int trainerNo;     // 트레이너 번호
    private String createDate;   // 생성일
    private String status;      // 상태
}
