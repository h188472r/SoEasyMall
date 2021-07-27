package com.soeasy.validator.lectureValidator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.soeasy.model.LectureBean;

public class LectureBeanValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return LectureBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		LectureBean lecture = (LectureBean) target;

		// 欄位不得空白
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lectureTitle", "", "標題不得空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lectureCategory", "", "分類不得空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lectureContent", "", "內容不得空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lectureDate", "", "日期不得空白");
//		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lectureStatus", "", "狀態不得空白");

		if (lecture.getLectureMultiImg().isEmpty()) {
            errors.rejectValue("lectureMultiImg", "", "必須挑選圖片");
        }
	}

}
