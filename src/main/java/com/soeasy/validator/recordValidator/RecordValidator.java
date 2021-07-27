package com.soeasy.validator.recordValidator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.soeasy.model.RecordBean;

public class RecordValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		boolean b = RecordBean.class.isAssignableFrom(clazz);
		
		 return b;
	}

	@Override
	public void validate(Object target, Errors errors) {
		RecordBean recordBean=(RecordBean)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"recordHeight","","身高不能空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"recordWeight","","體重不能空白");
	}

}
