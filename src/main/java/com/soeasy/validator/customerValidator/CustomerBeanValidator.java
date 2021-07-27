package com.soeasy.validator.customerValidator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.soeasy.model.CustomerBean;

public class CustomerBeanValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return CustomerBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		CustomerBean customer = (CustomerBean)target;
		//欄位不得空白
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "customerName", "", "名字不得空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "customerEmail", "", "電子郵件不得空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "customerPassword", "", "密碼不得空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "customerCheckPassword", "", "密碼確認不得空白");
		
		//密碼與密碼確認
		if(!customer.getCustomerPassword().equals(customer.getCustomerCheckPassword())) {
			errors.rejectValue("customerPassword", "", "密碼與密碼確認須一致");
		}
	}

}
