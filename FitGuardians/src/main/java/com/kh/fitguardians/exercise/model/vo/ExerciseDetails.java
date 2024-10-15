package com.kh.fitguardians.exercise.model.vo;

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
public class ExerciseDetails {

	// pdf 전용 메소드
	private String day;
	private String name;
	private String equipment;
	private String duration;
	private String repetitions;
	private String sets;

	
}
