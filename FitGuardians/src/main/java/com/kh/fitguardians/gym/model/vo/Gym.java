package com.kh.fitguardians.gym.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Gym {
	
	private int gymNo;     // 헬스장 번호 (int)
    private String gymName;   // 헬스장 이름 (String)
    private String gymAddress; // 헬스장 주소 (String)
    private double latitude; // 헬스장 위도 (double)
    private double longitude; // 헬스장 경도 (double)
}
