package com.kh.fitguardians.mealplan.model.vo;



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
public class MealPlan {
	
	private String sendUserId;
	private String getUserId;
	private String foodName;
	private String foodCode;
	private double carbs;
	private double sugar;
	private double fat;
	private double protein;
	private double kcal;
	private String mealDate;
	private String mealMsg;
	private String mealRemsg;

}
