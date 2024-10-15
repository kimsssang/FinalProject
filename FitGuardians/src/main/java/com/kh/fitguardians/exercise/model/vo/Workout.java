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
public class Workout {

	// 트레이너 플랜
	
	private int exerciseNo;
	private String userId;
	
	@JsonProperty("title")
	private String workoutTitle;
	
	@JsonProperty("date")
	private String workoutDate;
	
	@JsonProperty("selectTarget")
	private String workoutCategory;
	
	private String difficulty;
	private String description;

	
}
