package com.soeasy.validator.nutritionistValidator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.soeasy.model.NutritionistBean;

public class NutritionistValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		
		 boolean b = NutritionistBean.class.isAssignableFrom(clazz);
		
		 return b;
	}

	@Override
	public void validate(Object target, Errors errors) {
		NutritionistBean nutritionistBean=(NutritionistBean)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"nutritionistName","","營養師姓名不能空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"nutritionistDegree","","營養師學位不能空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"nutritionistEmail","","營養師 E-mail不能空白");
		
		if(nutritionistBean.getNutritionistCategoryBean().getNutritionistCategoryId()== -1) {
			errors.rejectValue("nutritionistCategoryBean", "","必須挑選專長分類欄的選項");
		}
		
		if(nutritionistBean.getNutritionistMultiImg().isEmpty()) {
			errors.rejectValue("nutritionistMultiImg","","必須挑選照片");
		}
	}
}
