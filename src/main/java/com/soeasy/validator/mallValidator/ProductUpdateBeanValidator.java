package com.soeasy.validator.mallValidator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.soeasy.model.LecturerBean;
import com.soeasy.model.PostBean;
import com.soeasy.model.ProductBean;
import com.soeasy.model.ProductUpdateBean;
import com.soeasy.model.ShopBean;

public class ProductUpdateBeanValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		boolean b = ProductUpdateBean.class.isAssignableFrom(clazz);

		return b;	}

	@Override
	public void validate(Object target, Errors errors) {
		ProductUpdateBean productupdateBean = (ProductUpdateBean) target;

		// 欄位不得空白
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "productName", "", "產品名字要記得填寫喔");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "productDescription", "", "描述要記得填寫喔");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "productPrice", "", "價格要記得填寫喔");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "productCalories", "", "熱量要記得填寫喔");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "productAmount", "", "庫存要記得填寫喔");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "productCost", "", "成本要記得填寫喔");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "shopBean.shopId", "", "shop要記得填寫喔");
//		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "productImg", "", "不得空白");
		
		if (productupdateBean.getProductDescription().length() > 800) {
			errors.rejectValue("productDescription", "", "字數超過800");
		}
	}

}
