package com.kh.fitguardians.exercise.model.vo;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString

public class ExercisePlan {
	
	//AI플랜
	private int aiExerciseNo;
	private int userNo;
	
	@JsonProperty("goal")
	private String exerciseGoal;
	
	@JsonProperty("fitness_level")
	private String fitnessLevel;
	
	@JsonProperty("exercise_types")
	private String exerciseType;
	
	@JsonProperty("equipment_available")
	private String equipment;
	
	@JsonProperty("health_conditions")
	private String healthCondition;
	
	@JsonProperty("days_per_week")
	private int daysPerWeek;
	
	@JsonProperty("session_duration")
	private int duration;
	
	@JsonProperty("plan_duration_weeks")
	private int planDurationWeek;

}
