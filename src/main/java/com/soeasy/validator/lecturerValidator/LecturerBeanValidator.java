package com.soeasy.validator.lecturerValidator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.soeasy.model.LecturerBean;
import com.soeasy.model.ShopBean;

public class LecturerBeanValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return LecturerBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		LecturerBean lecturer = (LecturerBean) target;

		// 欄位不得空白
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lecturerName", "", "名字不得空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lecturerTalent", "", "專長不得空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lecturerExp", "", "經歷不得空白");

		if (lecturer.getLecturerMultiImg().isEmpty()) {
            errors.rejectValue("lecturerMultiImg", "", "必須挑選圖片");
        }
	}

}
