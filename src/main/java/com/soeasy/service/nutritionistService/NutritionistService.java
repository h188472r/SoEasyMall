package com.soeasy.service.nutritionistService;

import java.util.List;

import com.soeasy.model.NutritionistBean;

public interface NutritionistService {
	
		// 新增文章
		void addNutritionist(NutritionistBean nutritionistBean);

		// 查詢一筆
		NutritionistBean findByNutritionistId(Integer nutritionistId);
		
		// 查詢全部
		List<NutritionistBean> findAllByNutritionistId();
		
		// 修改
		void updateNutritionist(NutritionistBean nutritionistBean);
		
		// 刪除
		void deleteByNutritionistId(Integer nutritionistId);
		
		// 查詢全部(有分頁)
		List<NutritionistBean> getAllPageNutritionist(int pageNo);
		
		Long getRecordCounts();
		
		Integer getTotalPages();
}
