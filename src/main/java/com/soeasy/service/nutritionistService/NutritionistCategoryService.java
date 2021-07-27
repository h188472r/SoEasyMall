package com.soeasy.service.nutritionistService;

import java.util.List;

import com.soeasy.model.NutritionistCategoryBean;

public interface NutritionistCategoryService {
	
	//撈出NutritionistCategory by ID
	NutritionistCategoryBean getNutritionistCategory(Integer nutritionistCategoryId);
	
	//取出所有NutritionistCategory
	List<NutritionistCategoryBean> getAllNutritionistCategorys();
}
