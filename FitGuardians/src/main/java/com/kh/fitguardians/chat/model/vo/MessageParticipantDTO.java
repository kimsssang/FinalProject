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
public class MessageParticipantDTO {

	private int participantNo; // 참가자 번호
    private String participantName; // 참가자 이름
    private String participantImage; // 참가자 이미지
    private String lastMessage; // 마지막 메시지
    private String lastActive; // 마지막 활동 시간
    private String participantStatus; // 상태 (활성/비활성 등)
    private int chatRoomNo; // 추가: 채팅방 번호
}
