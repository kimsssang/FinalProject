package com.kh.fitguardians.member.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter@Setter
@ToString
public class Member {

	private int userNo;
	private String userId;
	private String userPwd;
	private String userName;
	private String email;
	private String phone;
	private String gender;
	private String age;
	private String address;
	private String enrollDate;
	private String userLevel;
	private String pt;
	private String status;
	private String api;
	private String qr;
	private String profilePic;
	private String membership;
}
