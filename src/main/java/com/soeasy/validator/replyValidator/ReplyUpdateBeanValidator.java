package com.soeasy.validator.replyValidator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.soeasy.model.PostBean;
import com.soeasy.model.ReplyBean;

public class ReplyUpdateBeanValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {

		boolean b = ReplyBean.class.isAssignableFrom(clazz);

		return b;
	}

	@Override
	public void validate(Object target, Errors errors) {
		ReplyBean replyBean = (ReplyBean) target;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "replyContent", "", "留言修改內容不能空白");

	}

}
