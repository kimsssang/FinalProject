package com.kh.fitguardians.member.model.vo;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class MemberInfo {
	
	private int userNo;
	private int height;			// 키
	private int weight;			// 몸무게
	private List<String> disease;		// 기저질환
	private String goal;		// 운동목표
	
}
