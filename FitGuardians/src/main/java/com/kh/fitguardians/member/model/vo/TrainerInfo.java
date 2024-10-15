package com.kh.fitguardians.member.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter@Setter
@ToString
public class TrainerInfo {

	private int userNo;
	private String trCareer;
	private String trCerti;
	private String trDescript;
	private String trProfile;
}
