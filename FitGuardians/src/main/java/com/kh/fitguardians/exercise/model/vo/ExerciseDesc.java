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
public class ExerciseDesc {
	
	// PDF 전용 메소드
	
	@JsonProperty("days_per_week")
	private String daysPerWeek;
	
	@JsonProperty("total_weeks")
	private String totalWeek;
	
	@JsonProperty("fitness_level")
	private String fitnessLevel;
	
	@JsonProperty("goal")
	private String goal;
	
	@JsonProperty("seo_content")
	private String seoContent;
	
	
}
