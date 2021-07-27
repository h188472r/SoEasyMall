package com.soeasy.validator.sportMapValidator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.soeasy.model.SportCategoryBean;
import com.soeasy.model.SportMapBean;

public class SportCategoryBeanValidator implements Validator {

	
	@Override
	public boolean supports(Class<?> clazz) {
		
		 boolean b = SportMapBean.class.isAssignableFrom(clazz);
		
		 return b;
	}
	
	@Override
	public void validate(Object target, Errors errors){
		SportCategoryBean sportCategoryBean = (SportCategoryBean)target;
		//判斷欄位值
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"sportCategoryName","","分類名稱不能空白");
			
		
	}
	
}
