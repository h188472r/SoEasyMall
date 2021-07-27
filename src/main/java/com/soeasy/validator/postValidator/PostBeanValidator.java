package com.soeasy.validator.postValidator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.soeasy.model.PostBean;

public class PostBeanValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {

		boolean b = PostBean.class.isAssignableFrom(clazz);

		return b;
	}

	@Override
	public void validate(Object target, Errors errors) {
		PostBean postBean = (PostBean) target;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "postTitle", "", "文章標題不能空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "postContent", "", "文章內容不能空白");
		
		System.out.println(postBean.getPostCategoryBean().getPostCategoryId());

		if (postBean.getPostCategoryBean().getPostCategoryId() == -1) {
			errors.rejectValue("postCategoryBean", "", "必須挑選分類欄的選項");
		}

		if (postBean.getPostMultiImg().isEmpty()) {
			errors.rejectValue("postMultiImg", "", "必須挑選圖片");
		}

	}

}
