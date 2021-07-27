package com.soeasy.service.nutritionistService.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soeasy.model.NutritionistCategoryBean;
import com.soeasy.repository.nutritionistRepository.NutritionistCategoryRepository;
import com.soeasy.service.nutritionistService.NutritionistCategoryService;


@Transactional
@Service
public class NutritionistCategoryServiceImpl implements NutritionistCategoryService{

	@Autowired
	NutritionistCategoryRepository nutritionistCategoryRepository;
	
	@Override
	public NutritionistCategoryBean getNutritionistCategory(Integer nutritionistCategoryId) {
		Optional<NutritionistCategoryBean> nutrition=nutritionistCategoryRepository.findById(nutritionistCategoryId);
		NutritionistCategoryBean nutritionistCategoryBean =null;
		if(nutrition.isPresent()) {
			nutritionistCategoryBean=nutrition.get();
		}else {
			throw new RuntimeException("SportCategory(id="+nutritionistCategoryId+")不存在");
		}
		return nutritionistCategoryBean;
	}

	@Override
	public List<NutritionistCategoryBean> getAllNutritionistCategorys() {
		return (List<NutritionistCategoryBean>) nutritionistCategoryRepository.findAll();
	}
}
