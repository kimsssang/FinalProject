package com.kh.fitguardians.exercise.model.vo;

import com.fasterxml.jackson.annotation.JsonProperty;

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
public class TnWorkout {
	
	// 회원이 입력할 본인 플래너 작성용 인스턴스
	private int exerciseNo;
	private String userId;
	
	@JsonProperty("title")
	private String workoutTitle;
	
	@JsonProperty("date")
	private String workoutDate;
	
	@JsonProperty("target")
	private String workoutTarget;
	
	private String difficulty;
	private String description;
	private String workoutStatus;
}
