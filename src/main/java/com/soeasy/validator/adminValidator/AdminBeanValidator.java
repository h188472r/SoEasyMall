package com.soeasy.validator.adminValidator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.soeasy.model.member.AdminBean;

public class AdminBeanValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return AdminBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		// 欄位不得空白
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "adminName", "", "名字不得空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "adminPassword", "", "密碼不得空白");
	}

}
