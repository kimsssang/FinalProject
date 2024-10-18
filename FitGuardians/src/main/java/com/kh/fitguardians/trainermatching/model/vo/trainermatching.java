package com.kh.fitguardians.trainermatching.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Getter
@Setter
public class trainermatching {
	private int userNo;
	private String userId;
	private String userName;
	private String age;
	private String gender;
	
	private String trInfoNo;;
    private String trCareer;
    private String trProfile;
    private String trDescript;
    private String trCerti;

}
