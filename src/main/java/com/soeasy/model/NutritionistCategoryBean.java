package com.soeasy.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "NutritionistCategory")
public class NutritionistCategoryBean implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer nutritionistCategoryId;
	
	private String nutritionistCategoryName;
	
	// ------------------------------------------
	public NutritionistCategoryBean() {
	}
	// ------------------------------------------

	public Integer getNutritionistCategoryId() {
		return nutritionistCategoryId;
	}

	public void setNutritionistCategoryId(Integer nutritionistCategoryId) {
		this.nutritionistCategoryId = nutritionistCategoryId;
	}

	public String getNutritionistCategoryName() {
		return nutritionistCategoryName;
	}

	public void setNutritionistCategoryName(String nutritionistCategoryName) {
		this.nutritionistCategoryName = nutritionistCategoryName;
	}
	
}
