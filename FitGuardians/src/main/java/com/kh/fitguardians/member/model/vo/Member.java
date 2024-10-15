package com.kh.fitguardians.member.model.vo;

import java.util.Date;

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
	
	// 조인할 예정
	// memberInfo테이블 컬럼
	private double height;
	private double weight;
	private String disease;
	private String goal;
	
	// bodyInfo테이블 컬럼
	private int bodyInfoNo;
	private Date measureDate;
	private double bmi;
	private double fat;
	private double smm;
	private String biStatus;
	
}
