package com.kh.fitguardians.exercise.model.vo;

import java.util.ArrayList;

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
public class ExerciseInfo {
	
	//PDF전용 메소드
	private ExerciseDesc exerciseDesc;
    private ArrayList<ExerciseDetails> exercise;
	
	
}
