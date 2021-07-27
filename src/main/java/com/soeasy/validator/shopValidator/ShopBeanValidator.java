package com.soeasy.validator.shopValidator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.soeasy.model.ShopBean;

public class ShopBeanValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return ShopBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		ShopBean shop = (ShopBean) target;

		// 欄位不得空白
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "shopName", "", "名字不得空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "shopEmail", "", "電子郵件不得空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "shopPassword", "", "密碼不得空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "shopCheckPassword", "", "密碼確認不得空白");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "shopPhone", "", "電話號碼不得空白");

		// 密碼與密碼確認
		if (!shop.getShopPassword().equals(shop.getShopCheckPassword())) {
			errors.rejectValue("shopPassword", "", "密碼與密碼確認須一致");
		}
	}

}
