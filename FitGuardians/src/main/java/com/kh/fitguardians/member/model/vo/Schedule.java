package com.kh.fitguardians.member.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@NoArgsConstructor
@Getter@Setter
@ToString
public class Schedule {
	private int scheduleNo;
	private String userNo;
	private String ptUser;
	private String scheduleTitle;
	private String scheduleDes;
	private String startDate;
	private String endDate;
	private String dow;
	private String backColor;
	private String allDay;
	private String kakaoCalendarId;
}
