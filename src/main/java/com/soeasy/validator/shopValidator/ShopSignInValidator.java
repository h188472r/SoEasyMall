package com.soeasy.validator.shopValidator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.soeasy.model.member.ShopSignInBean;

public class ShopSignInValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return ShopSignInBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "shopSignInEmail", "", "電子郵件不得空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "shopSignInPassword", "", "密碼不得空白");		
	}

}
