package com.kh.fitguardians.member.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter@Setter
@ToString
public class Events {
	
	private String id;
	private String calendarId;
	private String title;
	private String type; 
	private String startDate;
	private String endDate;
	private boolean allDay;
	private boolean IsHost;
	private boolean IsRecurEvent;
	private String color;
	
}
