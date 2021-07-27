package com.soeasy.validator.customerValidator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.soeasy.model.member.CustomerSignInBean;

public class CustomerSignInValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return CustomerSignInBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "customerSignInEmail", "", "電子郵件不得空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "customerSignInPassword", "", "密碼不得空白");

	}

}
