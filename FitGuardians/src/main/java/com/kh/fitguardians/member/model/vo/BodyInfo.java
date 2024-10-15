package com.kh.fitguardians.member.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class BodyInfo {
	
	private int bodyInfoNo;
	private String userId;
	private Date measureDate;
	private double bmi;
	private double fat;
	private double smm;
	private String biStatus;

}
