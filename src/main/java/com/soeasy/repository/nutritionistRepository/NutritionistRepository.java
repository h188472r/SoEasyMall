package com.soeasy.repository.nutritionistRepository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.soeasy.model.NutritionistBean;


public interface NutritionistRepository extends JpaRepository<NutritionistBean, Integer>{

	List<NutritionistBean> findByNutritionistId(Integer nutritionistId);
}
